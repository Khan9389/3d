<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">

<head>
	<meta name="keywords" content="3DBANK-SERVICE" />
	<title>3DBANK-SERVICE</title>
	<script src="/asia3d/vendor/jquery/jquery.min.js"></script>
	<script src="//static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"></script>
</head>


<body>

<div id="naver_id_login" class="hide"></div>

<script type="text/javascript">
	var acc_token;
	var naver_id_login;

	function naverSignInCallback() {
		// naver_id_login.getProfileData('프로필항목명');
		// 프로필 항목은 개발가이드를 참고하시기 바랍니다.

		var userObj = new Object();
		userObj.id = naver_id_login.getProfileData('id');
		userObj.name = naver_id_login.getProfileData('name');
		userObj.nickname = naver_id_login.getProfileData('nickname');
		userObj.profile_image = naver_id_login.getProfileData('profile_image');
		userObj.age = naver_id_login.getProfileData('age');
		userObj.birthday = naver_id_login.getProfileData('birthday');
		userObj.email = naver_id_login.getProfileData('email');
		userObj.enc_id = naver_id_login.getProfileData('enc_id');
		userObj.gender = naver_id_login.getProfileData('gender');

		//alert(userObj.age);
		//console.log(acc_token);
		//window.opener.console.log('===================', userObj);
		window.opener.socialLogin('withNaver', userObj);
		window.open('about:blank', '_self').close();
	}

	$(document).ready(function() {
		let url = 'https://service.3dbank.xyz';

		naver_id_login = new naver_id_login('Eu_Y4svvXiMxzoyRUCjg', url + '/member/callback_naver.do');

		//acc_token = naver_id_login.getAccessToken();
		acc_token = naver_id_login.oauthParams.access_token;

		naver_id_login.get_naver_userprofile("naverSignInCallback()");
	});
</script>
</body>
</html>