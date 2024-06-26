<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

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
    <!--헤더-->
	<%@ include file="../include/menu.jsp" %>
    <!--헤더 end-->

    <!--본문-->
    <section id="adm_sc">
        <div id="adm_sc_area">
            <div id="adm_sc_con">
                <div class="adm_sc_size">

                    <!--본문 내용-->
                    <section class="adm_sc_txt">
                        <div class="sc_con">
                            <div class="title">
                                <span></span>
                                <span>자가진단 관리</span>
                            </div>
                            <div class="table_wrap">
                                <table id="bootstrap-data-table">
                                    <tr>
                                        <th class="number">번호</th>
                                        <th class="name">제목</th>
                                        <th class="category">유형</th>
                                        <th class="l_category">대분류</th>
                                        <th class="m_category">소분류</th>
                                        <th class="type">사용여부</th>
                                        <th class="create_tm">생성일시</th>
                                        <th class="update_tm">수정일시</th>
                                        <th class="setting">비고</th>
                                    </tr>
                                    <c:forEach var="item" items="${model.list}" varStatus="status">
                                    <tr data-role="button" data-id="${item.idx}"  >
                                        <td>${model.itemtotalcount - (status.index + model.page *  model.itemcount)}</td>
                                        <td style="text-align:left">${item.name }</td>
                                        <td>
                                        	<c:choose>
                                        		<c:when test="${item.category == '0' }">설문</c:when>
                                        		<c:when test="${item.category == '1' }">진단</c:when>
                                        	</c:choose>
                                        </td>
                                        <td>${item.l_category }</td>
                                        <td>${item.m_category }</td>
                                        <td>
                                        	<c:choose>
                                        		<c:when test="${item.type == '1' }">ON</c:when>
                                        		<c:when test="${item.type == '0' }">OFF</c:when>
                                        	</c:choose>
                                        </td>
                                        <td>
                                            ${fn:substring(item.create_tm,0,11)}
                                        </td>
                                        <td>
                                            ${fn:substring(item.update_tm,0,11)}
                                        </td>
                                        <td>
                                        	<button type="button" onclick="location.href='/admin/exam/question_list.do?exam_idx=${item.idx}&category=${item.category }'">문제 확인</button>
                                        	<button type="button" onclick="location.href='/admin/exam/update.do?idx=${item.idx}'">관리</button>
                                        	<button type="button"  onclick="location.href='/admin/exam/status.do?idx=${item.idx}&category=${item.category }'">통계</button>
                                        	<button type="button"  onclick="qrCode('http://cnwpanel.com//user/exam/view.do?idx=${item.idx}&category=${item.category }','${status.index + 1 }' , '${item.name}')" >QR코드 생성</button>
                                            <button type="button" onclick="location.href='/admin/exam/result/list.do?idx=${item.idx}'">추가문의 확인</button>
                                            <button type="button" onclick="location.href='/admin/exam/result/Final.do?idx=${item.idx}'">최종결과물</button>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>

                            <!--관리자 버튼-->
                            <div class="page_seach">
                                <div>
                                    <select id="SEARCH_TYPE" name="SEARCH_TYPE">
                                        <option value="ALL">전체</option>
                                        <option value="type" <c:if test="${model.before.SEARCH_TYPE == 'type'}">selected</c:if>>상태</option>
                                        <option value="l_category"  <c:if test="${model.before.SEARCH_TYPE == 'l_category'}">selected</c:if>>대분류</option>
                                        <option value="m_category" <c:if test="${model.before.SEARCH_TYPE == 'm_category'}">selected</c:if>>중분류</option>
                                        <option value="name" <c:if test="${model.before.SEARCH_TYPE == 'name'}">selected</c:if>>이름</option>
                                    </select>
                                    <input style="width: 191px;" type="text" value="${model.before.SEARCH_TEXT }" name="SEARCH_TEXT" id="SEARCH_TEXT" >
                                    <button type="button" value="검색" onClick="searchBtnClick()">검색</button>
                                </div>
                                <div class="adm_btn_wrap stats_btn_area">
                                    <ul>
                                    <li class="delete">
                                        <a href="./insert.do">자가진단 등록</a>
                                    </li>
                                </ul>
                                </div>
                            </div>

                            <!--관리자 버튼 end-->


                            <!--페이지 넘버-->
                            <nav class="paging_number">
                                <ul class="page">
                                   <%@ include file="../include/pageing.jsp" %>
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
<script src="https://cdn.jsdelivr.net/npm/qrcodejs@1/qrcode.min.js"></script>
<script>

function searchBtnClick(){
	
	 URL = './list.do';
     URL = URL + "?PAGE=0";
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

// QR 코드 생성 함수
function qrCode(link, statusNumber,name) {
    // QR 코드를 감쌀 div 요소 생성
    var qrWrapper = document.createElement('div');
    qrWrapper.style.display = 'flex';
    qrWrapper.style.justifyContent = 'center';

    // QR 코드를 위한 div 요소 생성
    var qrCodeElement = document.createElement('div');
    qrCodeElement.id = "qrcode_" + statusNumber;

    // QR 코드 생성
    new QRCode(qrCodeElement, {
        text: link,
        width: 128,
        height: 128
    });

    // QR 코드를 감싸는 div에 추가
    qrWrapper.appendChild(qrCodeElement);

    // Swal2 팝업에 QR 코드 표시
    Swal.fire({
        title: 'QR-CODE',
        html: qrWrapper,
        confirmButtonText: '다운로드',
        preConfirm: () => {
            qrDown(statusNumber , name); // 버튼 클릭 시 다운로드 함수 호출
        }
    });
}


// QR Code Download Function
function qrDown(statusNumber , name) {
    var canvas = document.getElementById("qrcode_" + statusNumber).getElementsByTagName("canvas")[0];
    var imgData = canvas.toDataURL("image/png").replace("image/png", "image/octet-stream");
    var a = document.createElement("a");
    a.href = imgData;
    a.download = name + "_QRCode.png";
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
}


</script>

</html>

