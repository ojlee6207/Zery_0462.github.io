package com.kh.board.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.kh.board.model.vo.Reply;
import com.kh.board.service.BoardService;
import com.kh.member.model.vo.Member;

/**
 * Servlet implementation class AjaxReplyInsertController
 */
@WebServlet("/insRep.do")
public class AjaxReplyInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxReplyInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String repContent = request.getParameter("replyContent");
		int refBNo = Integer.valueOf(request.getParameter("bnum"));
		
		HttpSession session = request.getSession();
		Member m = (Member)request.getSession().getAttribute("loginUser");
		int userNo = m.getUserNo();
		
		Reply rep = new Reply();
		rep.setReplyContent(repContent);
		rep.setRefBNo(refBNo);
		rep.setReplyWriter(""+userNo);
		
		int result = new BoardService().insertReply(rep);
		
		if (result > 0) {
			request.getSession().setAttribute("alertMsg", "댓글이 등록되었습니다.");
			response.sendRedirect(request.getContextPath()+"/detail.bo?bnum="+refBNo);
		} else {
			request.setAttribute("errorMsg", "댓글 등록 실패");
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
	    response.setContentType("application/json; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		Gson gson = new Gson();
		gson.toJson(rep, response.getWriter());

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
