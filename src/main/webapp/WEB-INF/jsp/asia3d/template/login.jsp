<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp" %>

<script type="text/javascript"> 

  // 로그인
  var loginObj = new Object();
  loginObj.service_tp = "user_login";
  loginObj.p_login_id = "";
  loginObj.p_pswd = "";
  loginObj.sns_tp = "";
  loginObj.sns_id = "";

  // SNS Login
  var snsObj = new Object();
  snsObj.service_tp = "user_login";

  $(document).ready(function() {
    $(this).on("click", "#loginBtn", formMethod);

  });

  const formMethod = function(e) {

		switch($(this)[0].id){
			case "loginBtn" :
				var form = $(this).parents("form");
				var input = {};
				input.email = form.find("#email");
				input.password = form.find("#pw");
				
				if(!input.email.val()){
					alert("이메일 주소를 입력해주세요.");
					input.email.focus();
					return false;
				}else if(! input.email.val().match(/([a-z]|[A-Z]|[0-9]).{0,24}\@([a-z]|[A-Z]|[0-9]).{0,24}/gi) ){
					alert("이메일 주소 형식대로 입력해주세요.");
					input.email.focus();
					return false;
				}
				
				if(!input.password.val()){
					alert("비밀번호를 입력해주세요.");
					input.password.focus();
					return false;
				}
				
				var params = form.serialize();
				params = setParamDecode(params);
        $.extend(loginObj, params);
				
				ajaxSend('loginCheck', loginObj);
				return false;
				
				break;
			
		}
	}

  const setParamDecode = function( params ){
		var json = {};
		var data = params.toString().split("&");
		
		for(var i=0; i < data.length; i++){
			json[data[i].split("=")[0]] = decodeURIComponent( data[i].split("=")[1] );
		}
		return json;
	}

  const ajaxSend = function(type, params) {
    
    $.ajaxSetup({
			url : "/exhibition/AjaxAirpassController.do",
			type : "POST",
			crossDomain : true,
			dataType : "json"
		});

    switch(type){
      case 'loginCheck':
        $.ajax({
					data : { jsondata : JSON.stringify(params) },
					xhrFields: {
					  withCredentials: true
					},
					success : function(res){						
						if(!res.user_uid){
							alert(res.retmsg.toString());
						} else {
              location.href = "/exhibition/template/index.do"
						}
					}
				});
				break;
    }
  }


  const getKakakoData = function(at, rt){
		Kakao.API.request({
			url: "/v2/user/me",
			success: function(res) {
				var params = {};
				$.extend(params, snsObj);

				params.sns_tp = "03";		
				params.kakao = res;

				ajaxSend("loginCheck", params);			
			}
		});
	}


  function socialLogin(snsTp, userObj){
    switch(snsTp){
			case "withKakao" :
				Kakao.init('b5893122931a7115d40e4ba4dafef111');
				Kakao.Auth.login({
		          success: function(authObj) {
		        	  getKakakoData(authObj.access_token, authObj.refresh_token);
		          },
		          fail: function(err) {
		        	  alert("인증에 실패하였습니다.\n관리자에게 문의하세요.");
		        	  document.location.href= "//service.3dbank.xyz/login.do";
		          }
		        });
				break;

      case "withNaver" :
				var params = {};
				$.extend(params, snsObj);

				params.sns_tp = "01";		
				params.naver = userObj;		

				ajaxSend("loginCheck", params);

				break;
    }

  }

</script>

<body class="bg-gradient-login">
  <!-- Login Content -->
  <div class="container-login">
    <div class="row justify-content-center">
      <div class="col-xl-6 col-lg-12 col-md-9">
        <div class="card shadow-sm my-5">
          <div class="card-body p-0">
            <div class="row">
              <div class="col-lg-12">
                <div class="login-form">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">Administration</h1>
                  </div>
                  <form id="loginForm" class="user" method="post">
                    <fieldset>
                      <div class="form-group">
                        <input id="email" type="text" class="form-control" name="p_login_id" placeholder="이메일 주소를 입력해주세요">
                      </div>
                      <div class="form-group">
                        <input type="password" id="pw" class="form-control" name="p_pswd" placeholder="비밀번호를 입력해주세요">
                      </div>
                      <div class="form-group">
                        <button type="submit" class="btn btn-primary btn-block" id="loginBtn">이메일 로그인</button>
                      </div>
                      <div class="sns" style="display:">
                        <div id="naver_id_login" style="display:none"></div>
                        <strong style="padding-left: 35px;">소셜 로그인</strong>
                          <ul class="list_sns">
                          <li class="naver"><a href="#" onClick="$('#naver_id_login a').trigger('click'); return false"><i class="ico_sns">네이버</i></a></li>
                          <li class="kakao"><a href="#" onClick="socialLogin('withKakao'); return false"><i class="ico_sns">카카오톡</i></a></li>
                        </ul>
                        <div class="g-signin2" style="margin-left:45%" data-onsuccess="onSignIn"></div>
                      </div>
                      <!--<a href="#" onclick="signOut();">Sign out</a>-->
                      <script>

                        /*function signOut() {
                          var auth2 = gapi.auth2.getAuthInstance();
                          auth2.signOut().then(function () {
                            console.log('User signed out.');
                          });
                        }*/

                        function onSignIn(googleUser) {
                          var profile = googleUser.getBasicProfile();
                          console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
                          console.log('Name: ' + profile.getName());
                          console.log('Image URL: ' + profile.getImageUrl());
                          console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
                        }
                      </script>
                      <script>
                        let url = 'https://service.3dbank.xyz';
                        document.naver_id_login = new naver_id_login('Eu_Y4svvXiMxzoyRUCjg', url + '/member/callback_naver.do');

                        let state = document.naver_id_login.getUniqState();
                        document.naver_id_login.setButton("green", 3, 32);
                        document.naver_id_login.setDomain('service.3dbank.xyz');
                        document.naver_id_login.setState(state);
                        document.naver_id_login.setPopup();
                        document.naver_id_login.init_naver_id_login();
                      </script>
                    </fieldset>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script type="text/javascript" charset="utf-8" src="/asia3d/vendor/jquery/jquery.min.js"></script>
  <script type="text/javascript" charset="utf-8" src="/asia3d/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script type="text/javascript" charset="utf-8" src="/asia3d/vendor/jquery-easing/jquery.easing.min.js"></script>
  <script type="text/javascript" charset="utf-8" src="/asia3d/js/ruang-admin.min.js"></script>
  <script src="/asia3d/js/serviceDAO.js"></script>
</body>
</html>