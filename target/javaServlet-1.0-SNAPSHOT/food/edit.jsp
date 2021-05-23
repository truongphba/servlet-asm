<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.Food" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HashMap<String, ArrayList<String>> errors = (HashMap<String, ArrayList<String>>) request.getAttribute("errors");
    if (errors == null) {
        errors = new HashMap<>();
    }
    String status = (String) request.getAttribute("status");
    List<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
    Food food = (Food) request.getAttribute("food");
    String linkImage = "https://res.cloudinary.com/truongph/image/upload/w_100,c_scale/";
%>
<%@ taglib prefix="mt" tagdir="/WEB-INF/tags" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://cloudinary.com/jsp/taglib" prefix="cl" %>


<c:set var="bodyContent">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Create Food</h1>
    </div>
    <div style="width: 80vw; margin: 0 auto">
        <%if (status != null) {%>
        <p class="text-danger"><%=status%>
        </p>
        <% } %>
        </p>
        <form method="post" action="/food/edit" id="product_form">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="name">Name</label>
                        <input value="<%= food.getName() %>" type="text" class="form-control" id="name" name="name">
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
                            <option <%=category.getId() == food.getCategoryId() ? "selected" : ""%>
                                    value=<%=category.getId()%>><%=category.getName()%>
                            </option>
                            <%}%>
                            <%
                                if (errors.containsKey("categoryId")) {
                            %>
                            <span class="error-msg">
                        <%=errors.get("categoryId").get(0)%>
                            </span>
                            <%
                                }%>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="description">Description </label>
                        <textarea class="form-control" id="description" name="description"
                                  rows="3"><%= food.getDescription() %></textarea>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Thumbnail</label>
                        <div class="form-group">
                            <button type="button" <%=food.getThumbnail() != null && food.getThumbnail().length() != 0? "disabled" : ""%> id="upload_widget"
                                    class="btn btn-primary">Add Thumbnail
                            </button>
                            <div class="thumbnails">
                                <% if (food.getThumbnail() != null && food.getThumbnail().length() != 0) { %>
                                <ul class="cloudinary-thumbnails">
                                    <li class="cloudinary-thumbnail active">
                                        <img src="<%=linkImage + food.getThumbnail() + ".jpg"%>" alt="">
                                        <a href="javascript:void(0)" class="cloudinary-delete">x</a>
                                    </li>
                                </ul>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="price">Price</label>
                        <input value="<%= food.getPrice() %>" type="number" class="form-control" id="price"
                               name="price">
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
                    <div class="form-group">
                        <label for="status">Status</label>
                        <select class="form-control" id="status" name="status">
                            <option <%= food.getStatus() == 1 ? "selected" : ""%> value="1">Selling</option>
                            <option  <%= food.getStatus() == 2 ? "selected" : ""%> value="2">Stopped selling</option>
                            <option <%= food.getStatus() == 0 ? "selected" : ""%> value="0">Deleted</option>
                        </select>
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
            <% if (food.getThumbnail() != null && food.getThumbnail().length() != 0) { %>
            <input type="hidden" name="thumbnails" data-cloudinary-public-id="<%=food.getThumbnail()%>"
                   value="<%=food.getThumbnail()%>">
            <%
                }%>
            <input type="hidden" class="form-control" name="id" value="<%= food.getId() %>">
        </form>
    </div>
</c:set>
<mt:layoutAdmin title="Edit Food">
    <jsp:body>
        ${bodyContent}
    </jsp:body>
</mt:layoutAdmin>
