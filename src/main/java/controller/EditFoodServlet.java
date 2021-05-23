package controller;

import entity.Food;
import helper.GenericValidateClass;
import service.CategoryService;
import service.FoodService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

@WebServlet(name = "EditFood", urlPatterns = "/food/edit")
public class EditFoodServlet extends HttpServlet {
    private FoodService foodService = new FoodService();
    private CategoryService categoryService = new CategoryService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String sid = req.getParameter("id");
        Food food = foodService.getById(sid);
        if (food == null){
            System.out.println("không tìm thấy id");
            resp.sendRedirect("/food/list");
            return;
        }
        req.setAttribute("status", "");
        req.setAttribute("food", food);
        req.setAttribute("categories",  categoryService.findByCondition());
        req.getRequestDispatcher("/food/edit.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8"); // lỗi Utf8 ngoài view
        String sid = req.getParameter("id");
        String name = req.getParameter("name");
        String categoryId = req.getParameter("categoryId");
        String description = req.getParameter("description");
        String price = req.getParameter("price").length()>0?req.getParameter("price"):"0";
        String thumbnail = req.getParameter("thumbnails") != null ? req.getParameter("thumbnails") : "";

        String status = req.getParameter("status");
        Food food = foodService.getById(sid);
        if (food == null){
            resp.sendRedirect("/food/list");
            return;
        }
        food.setName(name);
        food.setCategoryId(Integer.parseInt(categoryId));
        food.setDescription(description);
        food.setThumbnail(thumbnail);
        food.setPrice(Double.valueOf(price));
        food.setStatus(Integer.parseInt(status));

        GenericValidateClass<Food> foodGenericValidateClass = new GenericValidateClass<>(Food.class);
        HashMap<String, ArrayList<String>> errors = foodGenericValidateClass.getErrors();
        if (food.getPrice() <= 0){
            errors.computeIfAbsent("price", k -> new ArrayList<>()).add("Price must be better than 0");
        }
        if (food.getName().length() <= 7){
            errors.computeIfAbsent("name", k -> new ArrayList<>()).add("Name must be better than 7 character");
        }
        if (!foodGenericValidateClass.validate(food) && errors.size() > 0) {
            req.setAttribute("categories",  categoryService.findByCondition());
            req.setAttribute("errors", errors);
            req.setAttribute("food", food);
            req.getRequestDispatcher("/food/edit.jsp").forward(req, resp);
            return;
        }
        boolean res = foodService.edit(sid,food);
        if (!res) {
            req.setAttribute("categories",  categoryService.findByCondition());
            req.setAttribute("status", "Create food fail!");
            req.setAttribute("food", food);
            req.getRequestDispatcher("/food/edit.jsp").forward(req, resp);
            return;
        }
        resp.sendRedirect("/food/list");
    }
}
