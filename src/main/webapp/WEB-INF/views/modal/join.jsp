<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/css/modal_css/join.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/css/etc/reset.css">

<!-- sweetalert -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugin/sweetalert/sweetalert2.css" />
<script src="${pageContext.request.contextPath}/assets/plugin/sweetalert/sweetalert2.all.min.js"></script>

<!-- script -->
<script src="${pageContext.request.contextPath}/assets/js/jquery-1.10.2.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>

<div class="modal-content wholething sw" id="myModal">
	<div class="modal-header">
		<h4 class="modal-title">회원가입</h4>
		<!-- 닫기버튼 -->
		<button class="btnclose" data-dismiss="modal">
			<svg width="30" height="30" viewBox="0 0 32 32"> 
				<g fill="none" fill-rule="evenodd" transform="translate(1 1)"> 
					<circle class="Circle" cx="15" cy="15" r="15"></circle> 
				<g class="Close" stroke-linecap="round" stroke-width="2"> 
					<path d="M19.243 19.243l-8.486-8.486M19.243 10.757l-8.486 8.486"></path></g></g>
			</svg>
		</button>
	</div>
	<form method="post" action="${pageContext.request.contextPath}/modal/join_ok.do" 
		id="join_form">
		<div class="modal-body padding">
			<div class="information clearfix">
				<p class="subtitle">이름</p>
				<input class="input1" type="text" name="name" id="user_id"
					class="full-wid input1" />
			</div>
			<div class="information information2 numberdiv clearfix">
				<p class="subtitle">이메일</p>
				<input type="text" name="email" id="email" class="email input1" />
				<p class="wid">@</p>
				<select class="select-email select1" name="email1" id="email1">
					<option value="">선택해주세요</option>
					<option value="naver.com">naver.com</option>
					<option value="gmail.com">gmail.com</option>
				</select>
				<button type="button" class="btn btn-color inclick buttonre" id="insnumber" value="인증번호 요청">인증번호 요청</button>
				<!-- data-toggle="modal" data-target="#requested" -->
			</div>
			<div class="information information2 numberdiv clearfix">
				<p class="subtitle"></p>
				<input type="text" name="pingaree" id="reemailinput" class="number input1" />
				<button type="button" class="btn btn-color inclick buttonre butrwh"
					id="reinsnumber" value="인증번호 확인">인증번호 확인</button>
			</div>
			<div class="information information2 clearfix">
				<p class="subtitle">비밀번호</p>
				<input type="password" name="passwd" class="full-wid input1"
					placeholder="비밀번호" id="user_pw" />
			</div>
			<div class="information information2 clearfix">
				<p class="subtitle">비밀번호확인</p>
				<input type="password" name="repasswd" class="full-wid input1"
					placeholder="비밀번호확인" id="user_pw_re" />
			</div>
			<div class="information information2 clearfix">
				<p class="subtitle">휴대폰 번호</p>
				<select class="select-tel pin select1" name="tel">
					<option>010</option>
					<option>011</option>
					<option>016</option>
					<option>017</option>
					<option>018</option>
					<option>019</option>
				</select>
				<p class="wid">-</p>
				<input type="number" name="tel1" id="tel1" class="pin input1 telnum" />
				<p class="wid">-</p>
				<input type="number" name="tel2" id="tel2" class="pin input1 telnum"/>
			</div>
			<div class="Information3">
				<p class="p">
					*만 14세 이상 회원 가입 가능합니다. 해당 내용은 <a href="#">이용약관 및 정책</a>에서도 확인이
					가능합니다
				</p>
			</div>
		</div>
		<div class="footer-body">
			<button type="submit" id="buttonjoin"
				class="buttonup btn btn-colordown buttontlzl">이메일 회원가입</button>
		</div>
	</form>
</div>

<!-- regex --> 
<script src="${pageContext.request.contextPath}/assets/js/regex.js"></script>

<!-- 전화번호 4자리 남기기 로직 -->
<script>
$(function() {
function substring(target) {
            $(target).keyup(function() {
                var value = $(this).val();              // 입력값을 가져온다.
                if (value.length >= 4) {                // 글자수가 4자 이상이 되면?
                    var input = value.substring(0, 4);  // 4자만 남겨놓고 자른다.
                    $(this).val(input);                 // 잘라낸 값을 다시 설정한다.
                    $(target).focus();               // 포커스 이동
                } // end if
            }); // end keyup event
       };
       
       substring($('#tel1'));
       substring($('#tel2'));
       
});
</script>

<!-- 회원가입 유효성검사 로직 -->
<script type="text/javascript">
$(function () {

    var user = $('#reemailinput').val();
	/** 가입폼의 submit 이벤트 */
    $("#join_form").submit(function() {
        // 기본동작 수행 방식
        e.preventDefault();
        
        /** 이름 검사 */
        if (!regex.value('#user_id', '이름을 입력하세요.')) { return false; }
        if (!regex.kor('#user_id', '이름은 한글만 입력 가능합니다.')) { return false; }
        if (!regex.min_length('#user_id', 2, '이름은 최소 2자 이상 입력 가능합니다.')) { return false; }
        
        /** 이메일 검사 */
        if (!regex.value('#email', '이메일를 입력하세요.')) { return false; }
        if (!regex.value('#email1', '이메일도메인을 선택하세요.')) { return false; }
        
        var user = $('#reemailinput').val();
        if (user != auth) {
			alert("인증번호를 다시 입력해주세요");
			return false;
		}
        
        if (!regex.value('#reemailinput', '인증번호를 입력하세요.')) { return false; }
        /**if (regex.value('#reemailinput', '인증번호를 입력하세요.') == auth) { return false; } */
        
        /** 비밀번호 검사 */
        if (!regex.value('#user_pw', '비밀번호를 입력하세요.')) { return false; }
        if (!regex.min_length('#user_pw', 4, '비밀번호는 최소 4자 이상 입력 가능합니다.')) { return false; }
        if (!regex.compare_to('#user_pw', '#user_pw_re', '비밀번호 확인이 잘못되었습니다.')) { return false; }
        
        /** 휴대폰 검사 */
        if (!regex.value('#tel1', '번호를 입력하세요.')) { return false; }
        if (!regex.value('#tel2', '번호를 입력하세요.')) { return false; }
        if (!regex.max_length('#tel1', 4, '번호는 4자 입력하세요.')) { return false; }

        $(this).submit();

    });

});
</script>

<!-- 인증번호 확인처리 로직 -->
<script>

//인증번호
function random() {
    	var num = Math.floor(Math.random() * 10);
    	return num;
    }
	
	var auth = "";
	
	for (var i = 0; i < 6; i++) {
		auth += random();
	}
	
	$("#reinsnumber").click(function () {
		var user = $('#reemailinput').val();
		if (auth == user) {
			alert("인증번호가 확인되었습니다");
		}else {
			alert("인증번호를 다시 확인해 주세요");
			
		}
	});

$("#insnumber").click(function () {
	var emailnu = $('#insnumber').val() 
	var email1 = document.getElementById("email1");
	
	if ($("#email").val().trim() == "" || $("#email1 option:selected").text() == "선택해주세요") {
    	alert("메일을 입력해 주세요");
    	e.preventDefault();
	}else {
		var email = $("#email").val();
		var email1 = document.getElementById("email1");
		var email2 = $("#email1 option:selected").text();
		var allemail = email + "@" + email2; 
		
			$.ajax({
	    	    url:"modal/joinema.do",
	    	    type:'POST',
	    	    data: {"allemail": allemail,
	    	    		"auth" : auth},
	    	    success:function(data){
	    	    	alert(allemail + "으로 메일이 발송되었습니다");
	    	    },
	    	    error:function(jqXHR, textStatus, errorThrown){
	    	        alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
	    	        self.close();
		        }	
	    });
	}
});
</script>