package controller;

import entity.Food;
import service.FoodService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DeleteFood", urlPatterns = "/food/delete")
public class DeleteFoodServlet extends HttpServlet {
    private FoodService foodService = new FoodService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String sid = req.getParameter("id");
        Food existFood = foodService.getById(sid);
        if (existFood == null){
            System.out.println("không tìm thấy id");
            resp.sendRedirect("/food/list");
            return;
        }
        foodService.delete(sid, existFood);
        resp.sendRedirect("/food/list");
    }
}
