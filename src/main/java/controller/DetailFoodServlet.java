package controller;

import entity.Category;
import entity.Food;
import service.CategoryService;
import service.FoodService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DetailFood",urlPatterns = "/food/detail")
public class DetailFoodServlet extends HttpServlet {
    private CategoryService categoryService = new CategoryService();
    private FoodService foodService = new FoodService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String sid = req.getParameter("id");
        Food food = foodService.getById(sid);
        if (food == null){
            System.out.println("Id not found!");
            resp.sendRedirect("/category/list");
            return;
        }
        req.setAttribute("food", food);
        req.setAttribute("categories",  categoryService.findByCondition());
        req.getRequestDispatcher("/food/detail.jsp").forward(req,resp);
    }
}
