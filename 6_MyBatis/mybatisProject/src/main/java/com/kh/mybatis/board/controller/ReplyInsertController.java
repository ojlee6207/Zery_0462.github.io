package com.kh.mybatis.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.mybatis.board.model.vo.Reply;
import com.kh.mybatis.board.service.BoardServiceImpl;
import com.kh.mybatis.member.model.vo.Member;

/**
 * Servlet implementation class ReplyInsertController
 */
@WebServlet("/insertReply.rp")
public class ReplyInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReplyInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int refBNo = Integer.valueOf(request.getParameter("bnum"));
		int replyNo = Integer.valueOf(request.getParameter("replyNo")); 
		String replyContent = request.getParameter("replyContent");
		String replyWriter = request.getParameter("replyWriter");
		String status = request.getParameter("status");
	
		Member m = new Member();
		
		Reply rp = new Reply(replyNo, replyContent, refBNo, m.getUserName());
		
		int result = new BoardServiceImpl().insertReply(refBNo);
		
		if (result > 0) {
			response.sendRedirect(request.getContextPath()+"/WEB-INF/views/board/boardDetailView.jsp");
		} else {
			request.setAttribute("errorMsg", "댓글 등록 실패");
			request.getRequestDispatcher("WEB-InF/views/common/errorPage.jsp").forward(request, response);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
