<%@ 
	page language="java" 
	contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"
%>

<%
	String user_uid = (String)session.getAttribute("user_uid");
	String p_login_id = (String)session.getAttribute("p_login_id");
	String token_uuid = (String)session.getAttribute("token_uuid");
	String p_name = (String)session.getAttribute("p_name");
	String my_photo = (String)session.getAttribute("my_photo");
%>

	
<script type="text/javascript">
	<% if(user_uid != null) { %>
		window.USER_INFO = {
			user_uid: 	'<%=user_uid%>',
			my_photo: 	'<%=my_photo%>',
			token_uuid: '<%=token_uuid%>',
			p_name: 	'<%=p_name%>',
			my_photo: 	'<%=my_photo%>'
		};
	<% } %>
</script>


<html lang="ko"> 
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="keywords" content="AIRPASS" />
		<meta name="google-signin-client_id" content="721946935341-g8ukcq5vrbk4lo6lj8bf953h40043jem.apps.googleusercontent.com">
		<title>3DBANK-SERVICE</title>
		<link rel="preconnect" href="https://fonts.googleapis.com">
	    <link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400&display=swap" rel="stylesheet">
		<link href="/asia3d/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
		<link href="/asia3d/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	  	<link href="/asia3d/css/ruang-admin.min.css" rel="stylesheet">
	  	<link href="/asia3d/css/custom.css" rel="stylesheet">
		<link rel="shortcut icon" href="/asia3d/main/img/favicon.ico" type="image/x-icon" />
		<link rel="icon" href="/asia3d/img/favicon.ico" type="image/x-icon" />
	  	<%/*<script src="/asia3d/js/jquery-2.2.3.js" type="text/javascript"></script>*/%>
		<script src="//static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"></script>
		<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
		<script src="//apis.google.com/js/platform.js" async defer></script>
		<script src="/asia3d/vendor/jquery/jquery.min.js"></script>
		<script src="/asia3d/js/jquery.lazyload.min.js" type="text/javascript"></script>
		<!-- SERVER --> 
		<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=b5893122931a7115d40e4ba4dafef111"></script>
	</head>

