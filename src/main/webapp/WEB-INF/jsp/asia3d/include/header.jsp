

<%@ 
	page language="java" 
	contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"
%>


<script type="text/javascript">

  var pName = '';
  var pImg = '';

  $(document).ready(function() {
    $('#link_logout').on('click', logoutMethod);
    setUserInfo();
  });

  function setUserInfo() {
    pName = window.USER_INFO.p_name;
    pImg = window.USER_INFO.my_photo;

    if(pImg == 'null') {
      $('.fa-user').css('display','');
    } else {
      $('.img_my_mphoto').attr('src', pImg);
      $('.img_my_mphoto').css('display','');
    }

    $('#_p-name').text(pName);
  }

  const logoutMethod = function(e) {

		var form = document.createElement("form");
		var parm = new Array();
		var input = new Array();

		form.action = '/logout.do';
		form.method = 'post';

		parm.push( ['logout', 'true'] );
		
		for (var i = 0; i < parm.length; i++) {
			input[i] = document.createElement("input");
			input[i].setAttribute("type", "hidden");
			input[i].setAttribute('name', parm[i][0]);
			input[i].setAttribute("value", parm[i][1]);
			form.appendChild(input[i]);
		}
		document.body.appendChild(form);
		form.submit();

		return false;
  }

</script>

<!-- Sidebar -->
<ul class="navbar-nav sidebar sidebar-light accordion" id="accordionSidebar">
  <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/exhibition/template/index.do" style="background-color: #fafafa;" >
    <img src="/asia3d/img/logo.png" alt="">
  </a>
  <hr class="sidebar-divider my-0" />
  <li class="nav-item">
    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menuTemplate"
      aria-expanded="true" aria-controls="menuTemplate">
      <i class="far fa-fw fa-window-maximize"></i>
      <span>전시관 템플릿 관리</span>
    </a>
    <div id="menuTemplate" class="collapse" aria-labelledby="headingBootstrap" data-parent="#accordionSidebar">
      <div class="bg-white py-2 collapse-inner rounded">
        <h6 class="collapse-header">전시관 템플릿 관리</h6>
        <a class="collapse-item" href="/exhibition/template/index.do">템플릿 목록</a>
        <a class="collapse-item" href="/exhibition/template/write.do">템플릿 등록</a>
      </div>
    </div>
  </li>
  <li class="nav-item">
    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menuProduct"
      aria-expanded="true" aria-controls="menuProduct">
      <i class="fas fa-fw fa-cube"></i>
      <span>전시 콘텐츠 관리</span>
    </a>
    <div id="menuProduct" class="collapse" aria-labelledby="headingBootstrap" data-parent="#accordionSidebar">
      <div class="bg-white py-2 collapse-inner rounded">
        <h6 class="collapse-header">전시 콘텐츠 관리</h6>
        <a class="collapse-item" href="/exhibition/product/index.do">콘텐츠 목록</a>
        <a class="collapse-item" href="/exhibition/product/write.do">콘텐츠 등록</a>
      </div>
    </div>
  </li>
  <li class="nav-item">
    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menuExhibition"
      aria-expanded="true" aria-controls="menuExhibition">
      <i class="fas fa-fw fa-sitemap"></i>
      <span>3D전시회 관리</span>
    </a>
    <div id="menuExhibition" class="collapse" aria-labelledby="headingBootstrap" data-parent="#accordionSidebar">
      <div class="bg-white py-2 collapse-inner rounded">
        <h6 class="collapse-header">3D전시회 관리</h6>
        <a class="collapse-item" href="/exhibition/exhibition/index.do">3D전시회 목록</a>
        <a class="collapse-item" href="/exhibition/exhibition/write.do">3D전시회 등록</a>
      </div>
    </div>
  </li>
  
</ul>

<div id="content-wrapper" class="d-flex flex-column">
  <div id="content">
    <!-- TopBar -->
    <nav class="navbar navbar-expand navbar-light bg-navbar topbar mb-4 static-top">
      <button id="sidebarToggleTop" class="btn btn-link rounded-circle mr-3">
        <i class="fa fa-bars"></i>
      </button>
      <ul class="navbar-nav ml-auto">
        
        <li class="nav-item dropdown no-arrow">
          <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown"
            aria-haspopup="true" aria-expanded="false">
            <span class="img-profile rounded-circle text-center">
              <i style="display: none" class="fas fa-user"></i>
              <img class="img_my_mphoto" style="height:40px; display: none" onerror="this.onerror=null; this.src='';">
            </span>
            <span id="_p-name" class="ml-2 d-none d-lg-inline text-white small"></span>
          </a>
          <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
            <a class="dropdown-item" href="javascript:;" id="link_logout">
              <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
              Logout
            </a>
          </div>
        </li>
      </ul>
    </nav>
