<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<!-- sweetalert -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugin/sweetalert/sweetalert2.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/modal_css/join.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/etc/reset.css">

<!-- script -->
<script src="${pageContext.request.contextPath}/assets/plugin/sweetalert/sweetalert2.all.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery-3.2.1.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>

<!-- regex -->
<script src="${pageContext.request.contextPath}/assets/js/regex.js"></script>


<!-- 전화번호 4자리 남기기 로직 -->
<script>
   $(function() {
      function substring(target) {
         $(target).keyup(function() {
            var value = $(this).val(); // 입력값을 가져온다.
            if (value.length >= 4) { // 글자수가 4자 이상이 되면?
               var input = value.substring(0, 4); // 4자만 남겨놓고 자른다.
               $(this).val(input); // 잘라낸 값을 다시 설정한다.
               $(target).focus(); // 포커스 이동
            } // end if
         }); // end keyup event
      }

      substring($('#tel1'));
      substring($('#tel2'));

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

    $("#reinsnumber").click(function() {
        var user = $('#reemailinput').val();
        if (auth == user) {
            alert("인증번호가 확인되었습니다");
        } else {
            alert("인증번호를 다시 확인해 주세요");

        }
    });

    $("#insnumber").click(function() {
        if ($("#email").val().trim() == "" || $("#email1 option:selected").text() == "선택해주세요") {
            alert("메일을 입력해 주세요");
            return false;
        } else {
                var email = $("#email").val();
                var email2 = $("#email1 option:selected").text();
                var allemail = email + "@" + email2;
                alert(allemail + "으로 메일이 발송되었습니다");
                $.ajax({
                        url : "modal/joinema.do",
                        type : 'POST',
                        data : {
                           "allemail" : allemail,
                           "auth" : auth
                        },
                        success : function(data) {
                        },
                        error : function(jqXHR, textStatus, errorThrown) {
                           alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
                           self.close();
                        }
                    }); // $.ajax
                } //if 

            }); //$("#insnumber").click(function() {

                  /** 가입폼의 submit 이벤트 */
    $("#buttonjoin").click(function() {
                  
        // 기본동작 수행 방식
        //e.preventDefault();

        /** 이름 검사 */
        if (!regex.value('#user_id', '이름을 입력하세요.')) { return false; }
        if (!regex.kor('#user_id', '이름은 한글만 입력 가능합니다.')) { return false; }
        if (!regex.min_length('#user_id', 2, 
        	'이름은 최소 2자 이상 입력 가능합니다.')) { return false; }
        
        /** 이메일 검사 */
        if (!regex.value('#email', '이메일를 입력하세요.')) { return false; }
        if (!regex.value('#email1', '이메일도메인을 선택하세요.')) { return false; }
        
        var user = $('#reemailinput').val();
        if (user != auth) {
           alert("인증번호를 다시 입력해주세요");
           return false;
        }
        
        if (!regex.value('#reemailinput', '인증번호를 입력하세요.')) { return false; }
       
        var user = $('#reemailinput').val();
        if (user != auth) {
           alert("인증번호를 다시 입력해주세요");
           return false;
        }
        
        /** 비밀번호 검사 */
        if (!regex.value('#user_pw', '비밀번호를 입력하세요.')) { return false; }
        if (!regex.min_length('#user_pw', 4,
              '비밀번호는 최소 4자 이상 입력 가능합니다.')) {
           return false;
        }
        if (!regex.compare_to('#user_pw', '#user_pw_re',
              '비밀번호 확인이 잘못되었습니다.')) {
           return false;
        }

        /** 휴대폰 검사 */
        if (!regex.value('#tel1', '번호를 입력하세요.')) { return false; }
        if (!regex.value('#tel2', '번호를 입력하세요.')) { return false; }

        $("#join_form").submit();

}); //$("#join_form").submit(function() {
   
   
</script>

<!-- 이메일 중복확인 -->
<script type="text/javascript">
    $('#checkid').click(function(){
    	if ($("#email").val().trim() == "" || $("#email1 option:selected").text() == "선택해주세요") {
            alert("메일을 입력해 주세요");
              return false;
    	  }
    	  var email1 = $("#email").val();
          var email2 = $("#email1 option:selected").text();
          var email = email1 + "@" + email2;
    
         $.ajax({
            url: "${pageContext.request.contextPath}/modal/idCheck.do",
            type: "GET",
            data:{
               "email": email
            },
            success: function(data){
           console.log(data) 	
           
               if(data == 0){
            	   $("#buttonjoin").prop("disabled", false);
            	   $("#insnumber").prop("disabled", false);
            	   $("#reinsnumber").prop("disabled", false);
					alert("사용가능");
               }else{
            	   $("#buttonjoin").prop("disabled", true);
            	   $("#insnumber").prop("disabled", true);
            	   $("#reinsnumber").prop("disabled", true);
            	   alert("불가");
               }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                alert("에러 발생~~ \n" + textStatus + " : " + errorThrown);
                self.close();
            }
        }); // end ajax   
    }); // end function
 </script>


<!-- modal 본문 시작 -->
    <div class="modal-content wholething sw" id="myModal">
       <div class="modal-header">
          <h4 class="modal-title">회원가입</h4>
          <!-- 닫기버튼 -->
              <button class="btnclose"  data-dismiss="modal">
                 <svg width="30" height="30" viewBox="0 0 32 32">
                    <g fill="none" fill-rule="evenodd" transform="translate(1 1)">
                       <circle class="Circle" cx="15" cy="15" r="15"></circle>
                       <g class="Close" stroke-linecap="round" stroke-width="2">
                          <path d="M19.243 19.243l-8.486-8.486M19.243 10.757l-8.486 8.486"></path>
                       </g>
                    </g>
                 </svg>
              </button>
           </div>
           <form method="post" action="${pageContext.request.contextPath}/modal/join_ok.do" id="join_form">
       <div class="modal-body padding">
          <div class="information clearfix">
             <p class="subtitle">이름</p>
             <input class="input1" type="text" name="name" id="user_id" class="full-wid input1" />
          </div>
          <div class="information information2 clearfix">
             <p class="subtitle">이메일</p>
             <input type="text" name="email" id="email" class="email input1" />
             <p class="wid">@</p>
             <select class="select-email select1" name="email1" id="email1">
                <option value="">선택해주세요</option>
                <option value="naver.com">naver.com</option>
                <option value="gmail.com">gmail.com</option>
             </select>
             <button type="button" class="btn btn-color inclick buttonre" id="insnumber"  value="인증번호 요청">인증번호 요청</button>
             <!-- data-toggle="modal" data-target="#requested" -->
          </div>
          <button type="button"  id="checkid"  value="중복확인">중복확인</button>
          <div class="information information2 numberdiv clearfix">
             <p class="subtitle"></p>
             <input type="text" name="pingaree" class="number input1" id="reemailinput" />
             <button type="button" class="btn btn-color inclick buttonre" id="reinsnumber" value="인증번호 확인" >인증번호 확인</button>
          </div>
          <div class="information information2 clearfix">
             <p class="subtitle">비밀번호</p>
             <input type="password" name="passwd" class="full-wid input1" id="user_pw" placeholder="비밀번호" />
          </div>
          <div class="information information2 clearfix">
             <p class="subtitle">비밀번호확인</p>
             <input type="password" name="repasswd" class="full-wid input1" id="user_pw_re" placeholder="비밀번호확인" />
          </div>
          <div class="information information2 clearfix">
             <p class="subtitle">휴대폰 번호</p>
             <select class="select-tel pin select1" id="tel">
                <option>010</option>
                <option>011</option>
                <option>016</option>
                <option>017</option>
                <option>018</option>
                <option>019</option>
             </select>
             <p class="wid">-</p>
             <input type="number" name="tel1" class="pin input1" id="tel1"/>
             	<p class="wid">-</p>
             <input type="number" name="tel2" class="pin input1" id="tel2"/>
          </div>
          <div class="Information3">
             <p class="p">*만 14세 이상 회원 가입 가능합니다. 해당 내용은 <a href="#">이용약관 및 정책</a>에서도 확인이 가능합니다</p>
          </div>
       </div>
       <div class="footer-body">
          <button type="submit" id="buttonjoin" class="buttonup btn btn-colordown buttontlzl" >이메일 회원가입</button>
       </div>
       </form>
    </div>
<!-- modal 본문 끝 -->
         
         
         
      
      