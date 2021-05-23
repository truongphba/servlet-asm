<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="entity.Food" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HashMap<String, ArrayList<String>> errors = (HashMap<String, ArrayList<String>>) request.getAttribute("errors");
    if (errors == null) {
        errors = new HashMap<>();
    }
    String status = (String) request.getAttribute("status");
    List<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
    Food food = (Food) request.getAttribute("food");

%>
<%@ taglib prefix="mt" tagdir="/WEB-INF/tags" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://cloudinary.com/jsp/taglib" prefix="cl" %>


<c:set var="bodyContent">
    <!-- Nội dung cần thêm -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Create Food</h1>
    </div>
    <div style="width: 80vw; margin: 0 auto">
        <%if (status != null) {%>
        <p class="text-danger"><%=status%>
        </p>
        <% } %>
        <form method="post" action="/food/create" id="product_form">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="name">Name</label>
                        <input type="text" class="form-control" id="name"
                               value="<%= food != null ? food.getName() : "" %>" placeholder="" name="name">
                        <%
                            if (errors.containsKey("name")) {
                        %>
                        <span class="error-msg">
                        <%=errors.get("name").get(0)%>
                             </span>
                        <%
                            }%>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="categoryId">Category</label>
                        <select class="form-control" id="categoryId" name="categoryId">
                            <%for (Category category : categories) { %>
                            <option value=<%=category.getId()%> <%= food != null && food.getCategoryId() == category.getId() ? "selected" : "" %>><%=category.getName()%>
                            </option>
                            <%}%>
                        </select>

                        <%
                            if (errors.containsKey("categoryId")) {
                        %>
                        <span class="error-msg">
                        <%=errors.get("categoryId").get(0)%>
                            </span>
                        <%
                            }%>

                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea class="form-control" id="description" name="description" placeholder=""
                                  rows="3"><%= food != null ? food.getDescription() : "" %></textarea>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Thumbnail</label>
                        <div class="form-group">
                            <button type="button" id="upload_widget" class="btn btn-primary">Add Thumbnail
                            </button>
                            <div class="thumbnails"></div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="price">Price</label>
                        <input type="number" class="form-control" id="price"
                               value="<%= food != null ? food.getPrice() : "" %>" placeholder="" name="price">
                        <%
                            if (errors.containsKey("price")) {
                        %>
                        <span class="error-msg">
                        <%=errors.get("price").get(0)%>
                              </span>
                        <%
                            }%>

                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <button type="submit" class="btn btn-success">Submit</button>
                    <a href="/food/list">
                        <button type="button" class="btn btn-primary">Back</button>
                    </a>
                </div>
            </div>
        </form>
    </div>
</c:set>
<mt:layoutAdmin title="Create Food">
    <jsp:body>
        ${bodyContent}
    </jsp:body>
</mt:layoutAdmin>
