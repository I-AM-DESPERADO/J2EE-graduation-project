<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<table id='dt_weekReport' class="responsive table table-striped table-bordered table-condensed">
											<thead>
												<tr>
													<th>流程节点</th>
													<th>处理人</th>
													<th>开始时间</th>
													<th>结束时间</th>
													<th>处理意见</th>
													<th>附件</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${taskhistory}" var="item">
													<tr>
													<td>${item.name}</td>
													<td>${item.user==null?"":item.user.chinesename}</td>
													<td> <fmt:formatDate value="${item.startTime}" type="time" dateStyle="full" pattern="yyyy-MM-dd HH:mm"/></td>
													<td> <fmt:formatDate value="${item.endTime}" type="time" dateStyle="full" pattern="yyyy-MM-dd HH:mm"/></td>
													<td>${item.approves}</td>
													<td>
														<c:forEach items="${item.attachment }" var="bean">
															<a href="${pageContext.request.contextPath}/upload/${bean.name}"> ${bean.name }</a>
															<br/>
														</c:forEach>
													</td>
												</tr>
											</c:forEach>
											</tbody>
										</table>