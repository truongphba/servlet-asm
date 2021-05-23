package service;

import entity.Category;
import entity.Food;
import repository.GenericRepository;

import java.sql.Date;
import java.util.List;

public class FoodService {

    private GenericRepository<Food> foodGenericRepository;

    public FoodService() {
        this.foodGenericRepository = new GenericRepository<>(Food.class);
    }

    java.sql.Date date = new java.sql.Date(System.currentTimeMillis());

    public static void main(String[] args) {
        FoodService foodService = new FoodService();
        System.out.println(foodService.getList(1, 16));

    }

    public boolean create(Food food) {
        food.setSaleStartDate(date);
        food.setCreatedAt(date);
        food.setUpdatedAt(date);
        food.setStatus(1);
        return foodGenericRepository.save(food);
    }


    public boolean edit(String id, Food food) {
//        if (food.validate()) {
        food.setUpdatedAt(date);
        return foodGenericRepository.update(id, food);
//        }
//        return false;
    }

    public boolean delete(String id, Food obj) {
        obj.setUpdatedAt(date);
        obj.setStatus(0);
        return foodGenericRepository.update(id, obj);
    }

    public List<Food> getList(int a, int b) {
        return foodGenericRepository.findAll(a, b);
    }

    public Food getById(String id) {
        return foodGenericRepository.findById(id);
    }

}
