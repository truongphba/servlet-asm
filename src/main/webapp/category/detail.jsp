<%@ page import="entity.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="mt" tagdir="/WEB-INF/tags" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% Category category = (Category) request.getAttribute("category"); %>


<c:set var="bodyContent">
    <!-- Nội dung cần thêm -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Detail Category</h1>
    </div>
    <hr>
    <form>
        <div class="row">
            <div class="col-md-4">
                <div class="form-group">
                    <label for="name">Id</label>
                    <input type="text" class="form-control"
                           value="<%= category.getId() %>"
                           placeholder="" name="name" disabled>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" class="form-control" id="name"
                           value="<%= category.getName() %>"
                           placeholder="" name="name" disabled>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <a href="/category/list"><button type="button" class="btn btn-primary">Back</button></a>
            </div>
        </div>

    </form>
</c:set>

<mt:layoutAdmin title="Detail Category">
    <jsp:body>
        ${bodyContent}
    </jsp:body>
</mt:layoutAdmin>


