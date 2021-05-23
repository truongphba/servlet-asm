package controller;

import entity.Category;
import helper.GenericValidateClass;
import service.CategoryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

@WebServlet(name = "CreateCategory", urlPatterns = "/category/create")
public class CreateCategoryServlet extends HttpServlet {
    private CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/category/create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        Category category = new Category();
        category.setName(req.getParameter("name"));
        GenericValidateClass<Category> categoryGenericValidateClass = new GenericValidateClass<>(Category.class);
        if (!categoryGenericValidateClass.validate(category)) {
            HashMap<String, ArrayList<String>> errors = categoryGenericValidateClass.getErrors();
            req.setAttribute("errors", errors);
            req.setAttribute("category", category);
            req.getRequestDispatcher("/category/create.jsp").forward(req, resp);
            return;
        }
        boolean res = categoryService.create(category);
        if (!res) {
            req.setAttribute("status", "Create category fail!");
            req.setAttribute("category", category);
            req.getRequestDispatcher("/category/create.jsp").forward(req, resp);
            return;
        }
        resp.sendRedirect("/category/list");
    }
}
