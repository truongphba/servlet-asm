package service;

import entity.Category;
import repository.GenericRepository;

import java.util.List;

public class CategoryService {
    private GenericRepository<Category> categoryGenericRepository;

    public CategoryService() {
        this.categoryGenericRepository = new GenericRepository<>(Category.class);
    }

    java.sql.Date date = new java.sql.Date(System.currentTimeMillis());

    public boolean create(Category category) {
        category.setCreatedAt(date);
        category.setUpdatedAt(date);
        category.setStatus(1);
        return categoryGenericRepository.save(category);
    }

    ;

    public List<Category> getList(int a, int b) {
        return categoryGenericRepository.findAll(a, b);
    }

    public List<Category> findByCondition() {
        return categoryGenericRepository.findByCondition("SELECT * FROM categories");
    }

    public Category getById(String id) {
        return categoryGenericRepository.findById(id);
    }

}
