<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="../include/header.jsp" %>
</head>

<style>
	#bootstrap-data-table tr th{
	
	text-align: center;
	
	}
</style>

<body>

    <!--본문-->
    <section id="adm_sc">
        <div id="adm_sc_area">
            <div id="adm_sc_con">
                <div class="adm_sc_size">

                    <!--본문 내용-->
                    <section class="adm_sc_txt" style="width:auto !important">
                        <div class="sc_con">
                            <div class="title">
                                <span></span>
                                <span>문제 연결 관리</span>
                            </div>
                            <div class="table_wrap">
                                <table id="bootstrap-data-table">
                                    <tr>
                                        <th class="number">번호</th>
                                        <th class="name">제목</th>
                                        <th class="type">타입</th>
                                        <th class="create_tm">생성일시</th>
                                        <th class="update_tm">수정일시</th>
                                        <th class="setting">비고</th>
                                    </tr>
                                    <c:if test="${model.list.size() <= 0 }">
                                    	<tr>
                                    		<td colspan="6">
                                    			해당 타입으로 검색되는 리스트가 없습니다.
                                    		</td>
                                    	</tr>
                                    </c:if>
                                    <c:if test="${model.list.size() > 0 }">
                                    <c:forEach var="item" items="${model.list}" varStatus="status">
                                    <tr data-role="button" data-id="${item.idx}"  >
                                        <td>${model.itemtotalcount - (status.index + model.page *  model.itemcount)}</td>
                                        <td>${item.name }</td>
                                        <td>${item.type }</td>
                                        <td>
                                            ${fn:substring(item.create_tm,0,11)}
                                        </td>
                                        <td>
                                            ${fn:substring(item.update_tm,0,11)}
                                        </td>
                                        <td>
                                        	<button type="button" onclick="question_view('${item.idx}' )" >보기</button>
                                        	<c:if test="${model.before.exam_idx != 'false' }">
                                        	<button type="button" onclick="question_connect('connect' , this)" data-idx="${item.idx }" data-name="${item.name }" data-type="${item.type }" data-content='${item.content }' data-objectives="${item.objectives }" data-select_type="${item.select_type }" data-select_val="${item.select_val }" data-solution="${item.solution }" >연결</button>
                                        	</c:if>
                                        	<button type="button" onclick="question_connect('update' , this)" data-idx="${item.idx }" data-name="${item.name }" data-type="${item.type }" data-content='${item.content }' data-objectives="${item.objectives }" data-select_type="${item.select_type }" data-select_val="${item.select_val }" data-solution="${item.solution }" >가져와서 수정하기</button>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                    </c:if>
                                </table>
                            </div>

                            <!--관리자 버튼-->
                            <div class="page_seach">
                                <div>
                                    <select id="SEARCH_TYPE" name="SEARCH_TYPE">
                                        <option value="name" <c:if test="${model.before.SEARCH_TYPE == 'name'}">selected</c:if>>이름</option>
                                    </select>
                                    <input style="width: 191px;" type="text" value="${model.before.SEARCH_TEXT }" name="SEARCH_TEXT" id="SEARCH_TEXT" >
                                    <button type="button" value="검색" onClick="searchBtnClick()">검색</button>
                                </div>
                            </div>

                            <!--관리자 버튼 end-->


                            <!--페이지 넘버-->
                            <nav class="paging_number">
                                <ul class="page">
                                   <ul class="page">

			<c:if test="${model.page > 0}"> 
				<c:if test="${model.itempagestart-model.itemcount > 0}">
	                 <li id="first_a"><a href="javascript:pageChanged(0, 0);"><img src="${pageContext.request.contextPath}/resources/img/first_arrow.png" alt="맨처음"></a></li>
	                 <li id="prev_a"><a href="javascript:pageChanged(${model.page-1}, ${model.itempageend});"><img src="${pageContext.request.contextPath}/resources/img/prev_arrow.png" alt="뒤로"></a></li>
				</c:if>
				<c:if test="${model.itempagestart-model.itemcount <= 0}">
					<li id="first_a"><a href="javascript:pageChanged(0,0);"><img src="${pageContext.request.contextPath}/resources/img/first_arrow.png" alt="맨처음"></a></li>
					<li id="prev_a"><a href="javascript:pageChanged(${model.page-1}, ${model.itempageend});"><img src="${pageContext.request.contextPath}/resources/img/prev_arrow.png" alt="뒤로"></a></li>
				</c:if>
			</c:if>

			<c:if test="${model.page <= 0}">
				  <li id="first_a"><a href="#"><img src="${pageContext.request.contextPath}/resources/img/first_arrow.png" alt="맨처음"></a></li>
			      <li id="prev_a"><a href="#"><img src="${pageContext.request.contextPath}/resources/img/prev_arrow.png" alt="뒤로"></a></li>
			</c:if>
			
			<c:if test="${model.itempageend > 0}">
				<c:forEach var="i" begin="${model.itempagestart}" end="${model.itempageend}">
					<c:choose>
						<c:when test="${model.page == i }">
							<li class="number page_active"><a href="#">${i+1}</a></li>
						</c:when>
						<c:otherwise>
							<li class="number"><a href="javascript:pageChanged(${i}, ${model.itempageend});">${i+1}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:if>

			<c:if test="${model.itempageend == 0}">
				<li class="number">1</li>
			</c:if>
			<c:if test="${model.itempageend < 0}">
				<li class="number">1</li>
			</c:if>
			
			<c:if test="${model.itemcount < model.itemtotalcount/(model.page+1)}">
				<li id="next_a"><a href="javascript:pageChanged(${model.page+1}, ${model.itemtotalpage});"><img src="${pageContext.request.contextPath}/resources/img/next_arrow.png" alt="다음"></a></li>
			</c:if>
			<c:if test="${model.itemcount >= model.itemtotalcount/(model.page+1)}">
				<li id="next_a"><a href="#"><img src="${pageContext.request.contextPath}/resources/img/next_arrow.png" alt="다음"></a></li>
			</c:if>

			<fmt:parseNumber var="lastPage" value="${(model.itemtotalcount % model.itemcount)==0? ((model.itemtotalcount/model.itemcount)-1) : (model.itemtotalcount / model.itemcount)}" integerOnly="true" />
			<c:choose>
				<c:when	test="${model.itemcount < model.itemtotalcount/(page+1)}">
				<li id="end_a"><a href="javascript:pageChanged(${model.itemtotalpage-1}, ${model.itemtotalpage-1});"><img src="${pageContext.request.contextPath}/resources/img/end_arrow.png" alt="맨끝"></a></li>
					
				</c:when>
				<c:otherwise>
				<li id="end_a"><a href="#"><img src="${pageContext.request.contextPath}/resources/img/end_arrow.png" alt="맨끝"></a></li>
				</c:otherwise>
			</c:choose>
			
			</ul>
			
			
			<script>			
function pageChanged(page, endpage)
{
	if (page < 0) 
	{
		page = 0;
	}
	if (endpage < 0){
		endpage = 0;
	}
	if (page >= endpage) {
		page = endpage;
	}
	
	
	var URL = "${requestURI}?PAGE="+page;

	
	if('${model.beforeDomain.ITEM_COUNT}' == '')
	{
		URL = URL + "&ITEM_COUNT=" + '10';
	}else
	{
		URL = URL + "&ITEM_COUNT=" + '${model.beforeDomain.ITEM_COUNT}';
	}
	
URL = URL + "&type=" + '${model.before.type}';
	URL = URL + "&SEARCH_TEXT=" + encodeURI('${model.beforeDomain.SEARCH_TEXT}');
	URL = URL + "&SEARCH_TYPE=" + '${model.beforeDomain.SEARCH_TYPE}';
	
	
	location.href = URL;
}


</script>
                                </ul>
                            </nav>
                            <!--페이지 넘버 end-->
                        </div>
                    </section>
                    <!--본문 내용 end-->
                </div>
            </div>
        </div>
    </section>
    <!--본문 end-->

    <!--푸터-->
    <footer>
	<%@ include file="../include/footer.jsp" %>
    </footer>
    <!--푸터 end-->

</body>
<script>

function searchBtnClick(){
	
	 URL = './select_list.do';
URL = URL + "?category=" + '${model.before.category}';
     URL = URL + "&PAGE=0";
     URL = URL + "&ITEM_COUNT=" + '10';
     URL = URL + "&SEARCH_TEXT=" + encodeURI($('#SEARCH_TEXT').val());
     URL = URL + "&SEARCH_TYPE=" + $('#SEARCH_TYPE').val();

	location.href = URL;
	
}

$(document).ready(function () {
	
	$(".adm_menu_con > li").eq(3).find(".sub_menu_con").show();
	$(".adm_menu_con > li").eq(3).css({
	    backgroundColor: "#fff"
	});
});

function question_view(idx){
	
	window.open('/admin/question/view.do?idx='+idx+'');
	
}

function question_connect(connect_type , e){
	
	console.log($(e));
	
	var idx = $(e).attr('data-idx');
	var name = $(e).attr('data-name');
	var type = $(e).attr('data-type');
	var content = $(e).attr('data-content');
	var select_type = $(e).attr('data-select_type');
	<c:if test="${model.before.category == '1'}">
	var objectives = $(e).attr('data-objectives');
	var select_val = $(e).attr('data-select_val');
	var solution = $(e).attr('data-solution');
	</c:if>
	
	console.log("idx : " + idx);
	console.log("name : " + name);
	console.log("type : " + type);
	console.log("content : " + content);
	console.log("select_type : " + select_type);
	<c:if test="${model.before.category == '1'}">
	console.log("objectives : " + objectives);
	console.log("select_val : " + select_val);
	console.log("solution : " + solution);
	</c:if>
	
	opener.document.getElementsByName('name')[0].value = name;
	opener.ckeditorInstance.setData(content);
	opener.document.getElementsByName('select_type')[0].value = select_type;
	opener.select_type_change();
	<c:if test="${model.before.category == '1'}">
	opener.document.getElementsByName('objectives')[0].value = objectives;
	opener.document.getElementsByName('select_val')[0].value = select_val;
	opener.document.getElementsByName('solution')[0].value = solution;
	</c:if>
	console.log(type);
	
	$.ajax({
		url : '/admin/select/listAPI.do',
		type : 'POST',
		data : ({
            question_idx : idx
        }),
        success : function(data , status , xhr){
            console.log('success');
            console.log(data);
            console.log(data.list);
            console.log(data.list.length);
            
            if(select_type == '1'){
            	opener.document.getElementsByName('select_type_cnt')[0].value = data.list.length;	
            }
            
            if(connect_type == 'connect'){
            	opener.select_list_append(data.list.length,'0', '2');	
            }else if(connect_type == 'update'){
            	opener.select_list_append(data.list.length,'0', '3');
            }
            
            
            
            for(var i = 0; i < data.list.length; i ++){
            	
            	$('#select_ul_'+i+' [name=seq]' , opener.document).val(data.list[i].seq);
				$('#select_ul_'+i+' [name=content]' , opener.document).val(data.list[i].content);
				$('#select_ul_'+i+' [name=image]' , opener.document).val(data.list[i].image);
				
            }
            
            switch (connect_type) {
        	case 'connect':
        		console.log('connect');
        		//연결에 대한 저장 버튼쪽 변경하기
        		opener.button_change('2');
        		alert('해당 문제를 연결합니다.');
        		opener.document.getElementsByName('question_idx')[0].value = idx;
        		window.close();
        		break;
        	case 'update':
        		console.log('update');
        		//가져와서 수정하기 대한 저장 버튼쪽 변경하기
        		opener.button_change('3');
        		alert('해당 문제를 수정할수 있도록 합니다.');
        		window.close();
        		break;
        	}
            
        },
        error : function(error , status , xhr){
             console.log('error');   
        }
	})

	
}

</script>

</html>

