<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="layout.basic">
	<tiles:putAttribute name="title">
		Person Management
	</tiles:putAttribute>
	<tiles:putAttribute name="header" value="/views/header.jsp" />
		
	<tiles:putAttribute name="body">
		<div id="persons">
			<h3>Person Management</h3>

			<c:choose>
				<c:when test="${persons.size() == 0}">
					<h1 class="productNotExist">Don't have any Person</h1>
					<a href="person/add" id="addLnk"
						class="btn btn-success productNotExistAddBtn">Add Person</a>
				</c:when>
				<c:otherwise>
					<table class="table">
						<thead>
							<tr>
								<th>#</th>
								<th>FirstName</th>
								<th>LastName</th>
								<th>Phone</th>
								<th>Email</th>
								<th>City</th>
								<th>State</th>
								<th>ZipCode</th>
								<th>Country</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="person" items="${persons}">
								<tr>
									<td>${person.id}</td>
									<td>${person.firstName}</td>
									<td>${person.lastName}</td>
									<td>${person.phone}</td>
									<td>${person.email}</td>
									<td>${person.address.city}</td>
									<td>${person.address.state}</td>
									<td>${person.address.zipcode}</td>
									<td>${person.address.country}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<c:url var="firstUrl" value="person?index=1" />
					<c:url var="lastUrl"
						value="person?index=${deploymentLog.totalPages}" />
					<c:url var="prevUrl" value="person?index=${currentIndex - 1}" />
					<c:url var="nextUrl" value="person?index=${currentIndex + 1}" />
					<ul class="pagination">
						<c:choose>
							<c:when test="${currentIndex == 1}">
								<li class="disabled"><a href="#">First</a></li>
								<li class="disabled"><a href="#">Prev</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${firstUrl}">First</a></li>
								<li><a href="${prevUrl}">Prev</a></li>
							</c:otherwise>
						</c:choose>
						<c:forEach var="i" begin="${beginIndex}" end="${endIndex}">
							<c:url var="pageUrl" value="person?index=${i}" />
							<c:choose>
								<c:when test="${i == currentIndex}">
									<li class="active"><a href="${pageUrl}"><c:out
												value="${i}" /></a></li>
								</c:when>
								<c:otherwise>
									<li><a href="${pageUrl}"><c:out value="${i}" /></a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when
								test="${deploymentLog.totalPages == 0 || currentIndex == deploymentLog.totalPages}">
								<li class="disabled"><a href="#">Next</a></li>
								<li class="disabled"><a href="#">Last</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${nextUrl}">Next</a></li>
								<li><a href="${lastUrl}">Last</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
					<a href="person/add" id="addLnk" class="btn btn-success">Add
						Person</a>
				</c:otherwise>
			</c:choose>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>
