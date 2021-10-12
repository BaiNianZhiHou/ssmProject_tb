package com.tb.service;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.tb.mapper.TbMapper;
import com.tb.mapper.UserMapper;
import com.tb.pojo.TbComment;
import com.tb.pojo.TbTw;

@Service
public class TbServiceImpl implements TbService {
	private ClassPathXmlApplicationContext context;
	private TbMapper tbMapper;
	private UserMapper userMapper;

	@Override
	public boolean send_tb(TbTw tt) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");

		this.tbMapper = (TbMapper) this.context.getBean("tbMapper");

		boolean flag = this.tbMapper.send_tb(tt);
		return flag;
	}

	@Override
	public List<TbTw> showSortTw(String tw_sort) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");

		this.tbMapper = (TbMapper) this.context.getBean("tbMapper");

		List<TbTw> list_tw_sort = this.tbMapper.showSortTw(tw_sort);

		return list_tw_sort;
	}

	@Override
	public TbTw showDetailTw(int tw_id) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.tbMapper = (TbMapper) this.context.getBean("tbMapper");

		TbTw tt = this.tbMapper.showDetailTw(tw_id);

		return tt;
	}

	@Override
	public boolean delTbTw(int tw_id) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.tbMapper = (TbMapper) this.context.getBean("tbMapper");

		boolean flag_del = this.tbMapper.delTbTw(tw_id);

		return flag_del;
	}

	@Override
	public Integer doComment(TbComment tc) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.tbMapper = (TbMapper) this.context.getBean("tbMapper");

		int comment_id = this.tbMapper.doComment(tc);

		return comment_id;
	}

	@Override
	public Map show_allComment(int tw_id, String writer, String user_name, int showCommentPage) {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.tbMapper = (TbMapper) this.context.getBean("tbMapper");

		Map dataMap = new TreeMap<>();
		Map map = new TreeMap<>();

		map.put("tw_id", tw_id);
		// ����incomment_id=0 ���ȵõ�����
		map.put("incomment_id", 0);// incomment_idΪ0 ��õ����� ��Ϊ0��õ������е�����
									// ���Ϊ�����е�����incomment_id��Ӧcomment_id��֮��ȵ�����

		String str_allComment = "";// �������ݵ�ƴ��

		List<TbComment> list_allComment = this.tbMapper.show_allComment(map);// �õ���������(�����������е�����)

		// �õ����۵�ͬʱ���з�ҳ-��showPage����ʾ�ڼ�ҳ������
		int showNum = 5;// һҳ�����ʾshowNum������

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// ��data���и�ʽ��

		for (int i = (showCommentPage - 1) * showNum; i < list_allComment.size()
				&& i < showCommentPage * showNum; i++) {
			// ��dataת���String���ͣ��������ʽ��
			String str_commentTime = sf.format(list_allComment.get(i).getComment_time());

			// �õ�����
			str_allComment = str_allComment + "<li id=\'show_comment" + list_allComment.get(i).getComment_id() + "\'>"
					+ "<div><a href='http://localhost:8080/ssmProject_tb/personal.action?user2_name="
					+ list_allComment.get(i).getUser_name() + "\' target='_Blank'>"
					+ list_allComment.get(i).getUser_name() + "</a>:" + list_allComment.get(i).getComment_context()
					+ "<a href='javascript:insert_inputComment(" + list_allComment.get(i).getTw_id() + ","
					+ list_allComment.get(i).getComment_id() + ",\"" + user_name + "\","
					+ list_allComment.get(i).getIncomment_id() + ")'>�ظ�����</a>" + str_commentTime;

			// �����¼���û�Ϊ���������� ���� Ϊ�������۵ķ����� �����ִ��ɾ������
			if (user_name.equals(writer) || list_allComment.get(i).getUser_name().equals(user_name)) {
				str_allComment += "<a href='javascript:delComment(" + list_allComment.get(i).getComment_id()
						+ ")' onclick='return cf_delComment()' id='del_a'>ɾ��</a>";
			}

			str_allComment += "<div id=\'insert_inputComment" + list_allComment.get(i).getComment_id()
					+ "\'></div></div>";// ����ظ����۵���һ��������������лظ����ۣ�

			// �õ���ǰ�����еĻظ�����
			int get_comment_id = list_allComment.get(i).getComment_id();// �õ���ǰ���۵�id

			map.put("tw_id", tw_id);
			map.put("incomment_id", get_comment_id);// ���ҵ�ǰ�����еĻظ����۵�id

			List<TbComment> list_inComment = this.tbMapper.show_allComment(map);// �õ���ǰ�����е����лظ�����

			// �õ���ǰ�����еĻظ�����
			String str_inComment = "";

			for (int j = 0; j < list_inComment.size(); j++) {
				// ��dataת���String���ͣ��������ʽ��
				String str_inCommentTime = sf.format(list_inComment.get(j).getComment_time());

				str_inComment = str_inComment + "<div id=\'show_comment" + list_inComment.get(j).getComment_id() + "\' "
						+ "style=\'margin-left:40px;\'>"
						+ "<a href='http://localhost:8080/ssmProject_tb/personal.action?user2_name="
						+ list_inComment.get(j).getUser_name() + "\' target='_Blank'>"
						+ list_inComment.get(j).getUser_name() + "</a>:" + list_inComment.get(j).getComment_context()
						+ str_inCommentTime;

				// �����¼���û�Ϊ���������� ���� Ϊ�������۵ķ����� �����ִ��ɾ������
				if (user_name.equals(writer) || list_inComment.get(j).getUser_name().equals(user_name)) {
					str_inComment += "<a href='javascript:delComment(" + list_inComment.get(j).getComment_id()
							+ ")' onclick='return cf_delComment()'>ɾ��</a>";
				}

				str_inComment += "</div>";
			}

			str_allComment = str_allComment + str_inComment + "<hr></li>";

		}

		dataMap.put("str_allComment", str_allComment);// �����������۵��ַ���ƴ��

		// ������۷�ҳ����ҳ��
		map.put("tw_id", tw_id);
		map.put("incomment_id", 0);// inComment_idΪ0����˵����ֱ������

		int sumOfComment = this.tbMapper.show_allComment(map).size();

		int sumPageComment = sumOfComment / showNum;

		if ((sumOfComment % showNum) != 0) {// �޷�ȡ�� ˵������һҳ
			sumPageComment += 1;
		}

		dataMap.put("sumPageComment", sumPageComment);// �õ����۷�ҳ�����ҳ��

		return dataMap;
	}

	@Override
	public boolean delComment(int comment_id) {
		boolean flag = false;

		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.tbMapper = (TbMapper) this.context.getBean("tbMapper");

		flag = this.tbMapper.delComment(comment_id);

		return flag;
	}

	@Override
	public List<TbTw> showAllTw() {
		this.context = new ClassPathXmlApplicationContext("classpath:spring/applicationContext-dao.xml");
		this.tbMapper = (TbMapper) this.context.getBean("tbMapper");

		List<TbTw> allTw = this.tbMapper.showAllTw();

		return allTw;
	}
}
