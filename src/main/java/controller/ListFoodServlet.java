package controller;

import entity.Category;
import entity.Food;
import repository.GenericRepository;
import service.CategoryService;
import service.FoodService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ListFood", urlPatterns = "/food/list")
public class ListFoodServlet extends HttpServlet {
    private CategoryService categoryService = new CategoryService();
    private FoodService foodService = new FoodService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categories = categoryService.findByCondition();
        int total = 5, currentPage = 1;
        int totalRows = new GenericRepository<>(Food.class).getCountFood();
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

        //Lấy ra danh sách sản phẩm
        req.setAttribute("foods", foodService.getList(index, total));
        req.setAttribute("totalRows", totalRows);
        req.setAttribute("total", total);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/food/list.jsp").forward(req, resp);
    }
}
