<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>


<% String page_num = request.getParameter("page_num"); %>


<script type="text/javascript"> 

  var userUid = window.USER_INFO.user_uid;

  var contsListInfo = new Array();
  var jsonParam = new Object();
  jsonParam.service_tp = "conts_info_list";
  jsonParam.page_num = '1';
  jsonParam.max_ret_count = '16';
  jsonParam.user_uid = userUid;


  $(document).ready(function() {
    readList();

    $("#conts_tp").change(function() {
			refreshPage();
		});

    $("#btn_contsch").on("click",function(){
			getContSearch();
		});

    $('body').on("click", ".paging a", function(){
      var pageId = $(this)[0].id;

      AIRPASS.pageInfo.rangePage = pageId.slice(4);		
      AIRPASS.pageInfo.pageNum = parseInt(pageId.slice(4));
      jsonParam.page_num = AIRPASS.pageInfo.rangePage;

      $('#_box-item').empty();
      doCommunication(jsonParam);
    });

  });


  function refreshPage() {
		var pageUrl = document.location.href = '/exhibition/product/index.do?ct='+ $('#conts_tp').val();
		location.href = pageUrl;
	}


	function getContSearch(){

		var inp_text = $("._inp_contsch").val();
		if(inp_text == null || inp_text == ""){
			alert("검색어를 입력해주세요");
		} else {
			document.location.href = '/exhibition/product/index.do?ct='+ $('#conts_tp').val() + '&conts_word=' + inp_text;		
		}

  }

  function readList() {
    AIRPASS.pageInfo.rangePage = 1;
    AIRPASS.pageInfo.pageNum = 1;
    AIRPASS.pageInfo.maxRetCount = 16;

    jsonParam.conts_tp = getURLParameter("ct") ? getURLParameter("ct") : 'ALL';
    jsonParam.conts_word = getURLParameter("conts_word") ? getURLParameter("conts_word") : '';

    $('#conts_tp').val(jsonParam.conts_tp); // conts_tp의 value 값

    doCommunication(jsonParam);
  }

  function doCommunication(jsonParam) {
    var jsondata = "jsondata=" + JSON.stringify(jsonParam);
    printLog("send data", jsondata);

    	$.ajax({
        type : "POST",  
        url : "/exhibition/AjaxAirpassController.do",
        data : jsondata,
        success : function(result) {
        	printLog("response data", JSON.stringify(result));
        	
          if (result.retcode == "000") {
				    AIRPASS.contsList = result;
				    setContsList();
			    } else {
        		alert(result.retmsg);
        	}
        }
    });
  }

  function setContsList() { 
    if (AIRPASS.contsList.conts_list == undefined) return;

    AIRPASS.pageInfo.totalCount = AIRPASS.contsList.total_count;

    for (var i=0; i < AIRPASS.contsList.conts_list.length; i++) {
      var contsInfo = AIRPASS.contsList.conts_list[i];
      
      let htmlText = '';
      if(contsInfo.user_uid == userUid) htmlText = '<div class="item" onclick="location.href=\'/exhibition/product/edit.do?conts_uid='+ contsInfo.conts_uid + '\'">';
      else htmlText = '<div class="item">';

      var tmpHtml = htmlText +
          '<div class="thumb _thumbImg" style="background-image:url(\'/exhibition/downThumbImg.do?conts_uid='+ contsInfo.conts_uid +'&file=' +contsInfo.conts_save_name +'\')"></div>' +
          '<div class="text d-flex">' +
            '<p class="tit">'+ contsInfo.conts_name +'</p>' +
          '</div>' +
        '</div>';
      $('#_box-item').append(tmpHtml);
      
      $('._thumbImg').lazyload({
        effect: "fadeIn",
      });
    }

    pagination(AIRPASS.pageInfo);
  }

</script> 



<body id="page-top">
  <div id="wrapper">
    <%@ include file="../include/header.jsp" %>
      <div class="container-fluid" id="container-wrapper">
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
          <h1 class="h3 mb-0 text-gray-800">전시 콘텐츠 목록</h1>
          <ol class="breadcrumb">
            <li class="breadcrumb-item">전시 콘텐츠 관리</li>
            <li class="breadcrumb-item active" aria-current="page">전시 콘텐츠 목록</li>
          </ol>
        </div>

        <div class="row layout-list">
          <div class="col-lg-12 mb-4">
            <div class="card">
              <div class="card-header d-flex align-items-baseline justify-content-between">
                <label class="d-flex align-items-center">
                  <p class="mr-3">콘텐츠 상태</p>
                  <select id="conts_tp" class="form-control">
                    <option value="ALL">전체</option>
                    <option value="3">3D 데이터</option>
                  </select>
                </label>

                <div class="input-group bar-search">
                  <input type="text" class="form-control bg-light border-1 small _inp_contsch" placeholder="검색어를 입력하세요" aria-label="Search" aria-describedby="basic-addon2" style="border-color: #3f51b5;" onkeypress="if(event.keyCode==13) {$('#btn_contsch').trigger('click'); return false;}">
                  <div class="input-group-append">
                    <button id="btn_contsch" class="btn btn-primary" type="button">
                      <i class="fas fa-search fa-sm"></i>
                    </button>
                  </div>
                </div>
              </div>

              <div id="_box-item" class="card-body d-flex box-item">
                <!--<div class="item" onclick="location.href='/product/edit.do'">
                  <div class="thumb" style="background-image:url('/asia3d/img/data/product/1/01_01/img_01.jpg')"></div>
                  <div class="text d-flex">
                    <p class="tit">XR 스포츠 체험</p>
                    <p><i class="fas fa-download"></i></p>
                  </div>
                </div>-->
                
              </div>
              
              <div class="card-footer paging">
                <!--<ul class="pagination justify-content-center mb-1">
                  <li class="page-item previous disabled">
                    <a href="#" class="page-link">이전</a>
                  </li>
                  <li class="page-item active">
                    <a href="#" class="page-link">1</a>
                  </li>
                  <li class="page-item">
                    <a href="#" class="page-link">2</a>
                  </li>
                  <li class="page-item">
                    <a href="#" class="page-link">3</a>
                  </li>
                  <li class="page-item">
                    <a href="#" class="page-link">4</a>
                  </li>
                  <li class="page-item">
                    <a href="#" class="page-link">5</a>
                  </li>
                  <li class="page-item next">
                    <a href="#" class="page-link">다음</a>
                  </li>
                </ul>-->
              </div>
            </div>
          </div>
        </div>
      </div>
    </div> <!-- div#content end -->
<%@ include file="../include/footer.jsp" %>
</body>
</html>