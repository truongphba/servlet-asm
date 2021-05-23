package controller;

import entity.Category;
import entity.Food;
import helper.GenericValidateClass;
import service.CategoryService;
import service.FoodService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@WebServlet(name = "CreateFood", urlPatterns = "/food/create")
public class CreateFoodServlet extends HttpServlet {
    private CategoryService categoryService = new CategoryService();
    private FoodService foodService = new FoodService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categories = categoryService.findByCondition();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/food/create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");
        String categoryId = req.getParameter("categoryId");
        String description = req.getParameter("description");
        String price = req.getParameter("price").length()>0?req.getParameter("price"):"0";
        String thumbnail = req.getParameter("thumbnails") != null ? req.getParameter("thumbnails") : "";
        Food food = new Food();
        food.setName(name);
        food.setDescription(description);
        food.setPrice(Double.valueOf(price));
        food.setCategoryId(Integer.parseInt(categoryId));
        food.setThumbnail(thumbnail);
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
            req.getRequestDispatcher("/food/create.jsp").forward(req, resp);
            return;
        }
        boolean res = foodService.create(food);
        if (!res) {
            req.setAttribute("categories",  categoryService.findByCondition());
            req.setAttribute("status", "Create food fail!");
            req.getRequestDispatcher("/food/create.jsp").forward(req, resp);
            return;
        }
        resp.sendRedirect("/food/list");
    }
}
