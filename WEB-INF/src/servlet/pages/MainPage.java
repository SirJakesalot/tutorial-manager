package pageDB_pages;

import pageDB_model.DataModel;
import pageDB_model.TreeNode;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/main")


public class MainPage extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        DataModel dm = null;
        try {
            dm = new DataModel();
            TreeNode tree = dm.getTree();
            request.setAttribute("title", "Tutorial Site Main Page");
            request.setAttribute("tree", tree);
        } catch (Exception e) {
            DataModel.log("MainPage doGet", e);
            request.setAttribute("err", "MainPage error");
        } finally {
            dm.closeConnection();
            request.getRequestDispatcher("jsp/main.jsp").forward(request, response);
        }
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException { 
        doGet(request, response);
    }
}
