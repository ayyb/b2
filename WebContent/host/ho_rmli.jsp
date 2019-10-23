<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<!DOCTYPE html>
<html lang="ko">

<head>

<%@ include file="../assets/inc/meta.jsp"%>
<title>공실관리</title>
 
<!-- header, footer, ho_rmli css 참조 -->
<link rel="stylesheet" type="text/css" href="ho_assets/ho_rmli.css" />
<link rel="stylesheet" type="text/css" href="ho_assets/ho_common.css" />

</head>

<body>
<div id="root">
    <div class="box">
        <!-- 헤더 -->
        <%@ include file="ho_assets/ho_inc/ho_header.jsp" %> 

        <!-- content -->
        <!-- 공실관리 -->
        <div class="content-box">
            <div class="title-box">
                <h1 class="title-h1">공실관리</h1>
            </div>
            <!--  -->
            <div class="isroom-div">
                <p class="isroom-p1">
                    <span>0</span>건의 공실이 있습니다.
                </p>
                <p class="isroom-p2">공실상태</p>
                <ul width="135" class="isroom-dropdown-closed">
                    <li name="option" value="0" class="isroom-dropdown-li">전체
                        <svg width="10px" height="5px" viewBox="0 0 10 5" version="1.1">
                            <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                <g transform="translate(-1235.000000, -281.000000)" fill="#444444">
                                    <g transform="translate(180.000000, 263.000000)">
                                        <g transform="translate(945.000000, 0.000000)">
                                            <path d="M119.297,18 L114.9935,21.755 L114.5345,21.3545455 L114.537,21.3568182 L110.7135,18.0204545 L110,18.6427273 C111.0565,19.565 114.007,22.1395455 114.9935,23 C115.7265,22.3609091 115.012,22.9840909 120,18.6318182 L119.297,18 Z" id="arrow_down-[#339]"></path></g></g></g></g></svg>
                    </li>
                    <li name="option" value="1" class="isroom-dropdown-li2">공개</li>
                    <li name="option" value="2" class="isroom-dropdown-li2">비공개</li>
                </ul>
            </div>

        <div class="container">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover">
                    <colgroup>
                        <col width="10%">
                        <col width="45%">
                        <col width="15%">
                        <col width="15%">
                        <col width="15%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th class="text-center">공실번호</th>
                            <th class="text-center">공실정보</th>
                            <th class="text-center">공실현황</th>
                            <th class="text-center">게시글관리</th>
                            <th class="text-center">공실관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="text-center">11469</td>
                            <td>
                                <div class="table-div">
                                    <span class="table-span1">원룸</span>
                                    <b class="table-span1-1">월세 500/30</b><br>
                                    <span class="table-span2">서울특별시 관악구 봉천동 945-17</span><br>
                                    <span>2019.09.24</span>
                                </div>
                            </td>
                            <td class="text-center">
                                <span class="label label-info">소유자 확인중</span>
                            </td>
                            <td class="text-center">
                                <button class="btn btn-default">수정</button>
                                <button class="btn btn-default">삭제</button>
                            </td>
                            <td class="text-center">
                                <button class="btn btn-default">공실상태전환</button>
                            </td>
                        </tr>
                        <tr>
                            <td class="text-center">11469</td>
                            <td>
                                <div class="table-div">
                                    <span class="table-span1">투룸</span>
                                    <b class="table-span1-1">전세 1억</b><br>
                                    <span class="table-span2">서울특별시 강북구 수유동 945-17</span><br>
                                    <span>2019.09.15</span>
                                </div>
                            </td>
                            <td class="text-center">
                                <span class="label label-info">소유자 확인중</span>
                            </td>
                            <td class="text-center">
                                <button class="btn btn-default">수정</button>
                                <button class="btn btn-default">삭제</button>
                            </td>
                            <td class="text-center">
                                <button class="btn btn-default">공실상태전환</button>
                            </td>
                        </tr>
                        <tr>
                            <td class="text-center">11469</td>
                            <td>
                                <div class="table-div">
                                    <span class="table-span1">쓰리룸</span> 
                                    <b class="table-span1-1">매매 3억</b><br>
                                    <span class="table-span2">서울특별시 강북구 미아동 235</span><br>
                                    <span>2019.09.21</span>
                                </div>
                            </td>
                            <td class="text-center">
                                <span class="label label-danger">소유자 확인실패</span>
                            </td>
                            <td class="text-center">
                                <button class="btn btn-default">수정</button>
                                <button class="btn btn-default">삭제</button>
                            </td>
                            <td class="text-center">
                                <button class="btn btn-default">공실상태전환</button>
                            </td>
                        </tr>
                    </tbody>
                </table>

            </div>
            <!--/ .table-responsive -->
        </div>
        <!-- / .table container -->
    </div>
    <!-- / content -->
	
	<!-- footer -->
    <%@ include file="ho_assets/ho_inc/ho_footer.jsp" %> 
    
    </div>
    <!--/ .box -->
</div>
<!--/ #root -->

<!-- Javascript -->
<script src="../assets/js/jquery-1.10.2.min.js"></script>
<script src="../assets/js/bootstrap.min.js"></script>
<script type="text/javascript">
    $(function () {
        $(".header-dropbox").hover(function() {
            $(this).toggleClass('header-dropbox header-dropbox-open')
        });

        $(".isroom-dropdown-closed").click(function() {
            $(this).toggleClass('isroom-dropdown-closed isroom-dropdown-opened')
        });
    });

</script>
</body>
</html>