<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.Food" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="helper.ConvertHelper" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="mt" tagdir="/WEB-INF/tags" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%
    ArrayList<Food> foods = (ArrayList<Food>) request.getAttribute("foods");
    List<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
    String linkImage = "https://res.cloudinary.com/truongph/image/upload/w_100,c_scale/";
%>
<% int currentPage = (int) request.getAttribute("currentPage"); %>
<% int totalPages = (int) request.getAttribute("totalPages"); %>

<c:set var="bodyContent">
    <!-- Nội dung cần thêm -->
    <div>
        <div class="row">
            <div class="col-md-6">
                <h1 class="h3 mb-0 text-gray-800">List Food</h1>
            </div>
            <div class="col-md-6 text-right">
                <a href="/food/create"><button class="btn btn-success">Create new</button></a>
            </div>
        </div>
    </div>
    <hr>
    <div>
        <table class="table table-striped">
            <thead class="table-dark">
            <tr  class="text-center">
                <th scope="col">Id</th>
                <th scope="col">Name</th>
                <th scope="col">Category</th>
                <th scope="col">Description</th>
                <th scope="col">Thumbnail</th>
                <th scope="col">Price</th>
                <th scope="col">Start Selling At</th>
                <th scope="col">Status</th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody>
            <% if (foods != null && foods.size() > 0) {
                for (int i = 0; i < foods.size(); i++) {
            %>
            <tr>
                <td scope="col" style="text-align: center"><%=foods.get(i).getId()%>
                </td>
                <td scope="col" style="text-align: center"><%=foods.get(i).getName()%>
                </td>
                <td scope="col" style="text-align: center">
                    <%for (Category category : categories) {
                        if (foods.get(i).getCategoryId() == category.getId()){%>
                    <%=category.getName()%>
                    <%}
                    }%>
                </td>
                <td scope="col" style="text-align: center"><%=foods.get(i).getDescription()%>
                </td>
                <td scope="col" style="text-align: center">
                    <div style="width: 100px; height: 100px; background-repeat: no-repeat; background-position: center; background-size: cover; background-image:
                            url('<%=linkImage + foods.get(i).getThumbnail() + ".jpg"%>')"></div>
                </td>
                <c:set var = "balance" value = "<%=foods.get(i).getPrice()%>" />
                <td scope="col" style="text-align: center">
                    <fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${balance}" />VNĐ
                </td>
                <td scope="col"
                    style="text-align: center"><%=foods.get(i).getSaleStartDate()%>
                </td>
                <td scope="col" style="text-align: center"><%=foods.get(i).toStatus(foods.get(i).getStatus())%>
                </td>
                <td scope="col" style="text-align: center">
                    <div class="btn-group">
                        <a href="/food/detail?id=<%=foods.get(i).getId()%>" class="btn btn-primary">Detail</a>
                        <a href="/food/edit?id=<%=foods.get(i).getId()%>" class="btn btn-success">Edit</a>
                        <a href="/food/delete?id=<%=foods.get(i).getId()%>" class="btn btn-danger">Delete</a>
                    </div>
                </td>
            </tr>
            <%
                    }
                }%>
            </tbody>
        </table>
        <% if (totalPages > 1) { %>
        <ul class="pagination" style="float: right">
            <li class="page-item <%= currentPage <= 1 ? "disabled" : ""%>"><a class="page-link" href="list?pages=<%=currentPage - 1%>">Previous</a></li>
            <% for (int i = 1; i < totalPages + 1; i++) { %>
            <li class="page-item <%=  i == currentPage ? "active" : "" %>">
                <a class="page-link" href="list?pages=<%=i%>"> <%=i%>  <%=  i == currentPage ? "<span class=\"sr-only\">(current)</span>" : "" %></a>
            </li>
            <% } %>
            <li class="page-item <%= currentPage >= totalPages ? "disabled" : ""%>"><a class="page-link" href="list?pages=<%=currentPage + 1%>">Next</a></li>
        </ul>
        <% } %>
    </div>

</c:set>

<mt:layoutAdmin title="List Food">
    <jsp:body>
        ${bodyContent}
    </jsp:body>
</mt:layoutAdmin>