
<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.Category" %>
<%@ page import="entity.Food" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="mt" tagdir="/WEB-INF/tags" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%    List<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
    String linkImage = "https://res.cloudinary.com/truongph/image/upload/w_200,c_scale/";
    Food food = (Food) request.getAttribute("list");

%>



<c:set var="bodyContent">
    <!-- Nội dung cần thêm -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Detail Food</h1>
    </div>
    <hr>
    <form>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input value="<%= food.getName() %>" type="text" class="form-control" id="name" name="name" disabled>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="categoryId">Category</label>
                    <select class="form-control" id="categoryId" name="categoryId" disabled>
                        <%for (Category category : categories) { %>
                        <option <%=category.getId() == food.getCategoryId() ? "selected" : ""%>
                                value=<%=category.getId()%>><%=category.getName()%>
                        </option>
                        <%}%>
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="description">Description </label>
                    <textarea class="form-control" id="description" name="description" disabled
                              rows="3"><%= food.getDescription() %></textarea>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label>Thumbnail</label>
                    <div class="form-group">
                        <% if (food.getThumbnail() != null && food.getThumbnail().length() != 0) { %>
                        <img src="<%=linkImage + food.getThumbnail() + ".jpg"%>" alt="">
                        <% } else { %>
                           <h4>None</h4>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="price">Price</label>
                    <input value="<%= food.getPrice() %>" type="number" class="form-control" id="price" disabled
                           name="price">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="status">Status</label>
                    <select class="form-control" id="status" name="status" disabled>
                        <option <%= food.getStatus() == 1 ? "selected" : ""%> value="1">Selling</option>
                        <option  <%= food.getStatus() == 2 ? "selected" : ""%> value="2">Stopped selling</option>
                        <option <%= food.getStatus() == 0 ? "selected" : ""%> value="0">Deleted</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <a href="/food/list">
                    <button type="button" class="btn btn-primary">Back</button>
                </a>
            </div>
        </div>
        <% if (food.getThumbnail() != null && food.getThumbnail().length() != 0) { %>
        <input type="hidden" name="thumbnails" data-cloudinary-public-id="<%=food.getThumbnail()%>"
               value="<%=food.getThumbnail()%>">
        <% } %>
        <input type="hidden" class="form-control" name="id" value="<%= food.getId() %>">
    </form>
</c:set>

<mt:layoutAdmin title="Detail Food">
    <jsp:body>
        ${bodyContent}
    </jsp:body>
</mt:layoutAdmin>


