package controller;

import entity.Category;
import repository.GenericRepository;
import service.CategoryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ListCategory", urlPatterns = "/category/list")
public class ListCategoryServlet extends HttpServlet {
    private CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int total = 5, currentPage = 1;
        int totalRows = new GenericRepository<>(Category.class).getCountCategory();

        int totalPages = totalRows / total;
        if (totalRows % total != 0){
            totalPages += 1;
        }
        if (req.getParameter("pages") != null) {
            currentPage = Integer.parseInt(req.getParameter("pages"));
        }
        if (currentPage > totalPages) {
            currentPage = totalPages;
        }
        int index = (currentPage - 1) * total;

        req.setAttribute("categories", categoryService.getList(index, total));
        req.setAttribute("totalRows", totalRows);
        req.setAttribute("total", total);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.getRequestDispatcher("/category/list.jsp").forward(req, resp);
    }
}
