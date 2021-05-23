<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="entity.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="mt" tagdir="/WEB-INF/tags" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    HashMap<String, ArrayList<String>> errors = (HashMap<String, ArrayList<String>>) request.getAttribute("errors");
    if (errors == null) {
        errors = new HashMap<>();
    }
    String status = (String) request.getAttribute("status");
    Category category = (Category) request.getAttribute("category");
%>
<c:set var="bodyContent">
    <!-- Nội dung cần thêm -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Create Category</h1>
    </div>
    <div style="width: 80vw; margin: 0 auto">
        <%if (status != null) {%>
        <p class="text-danger"><%=status%>
        </p>
        <% } %>

        <form method="post" action="/category/create">
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="name">Name</label>
                        <input type="text" class="form-control" id="name"
                               value="<%= category != null ?  category.getName() : ""%>"
                               placeholder="" name="name">
                        <span class="error-msg">
                        <%
                            if (errors.containsKey("name")) {
                                ArrayList<String> Errors = errors.get("name");
                        %>
                        <%=Errors.get(0)%>
                        <%
                            }%>
                        </span>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <button type="submit" class="btn btn-success">Submit</button>
                    <a href="/category/list"><button type="button" class="btn btn-primary">Back</button></a>
                </div>
            </div>

        </form>
    </div>
</c:set>
<mt:layoutAdmin title="Create Category">
    <jsp:body>
        ${bodyContent}
    </jsp:body>
</mt:layoutAdmin>

