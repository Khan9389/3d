<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/head.jsp" %>

<style> 
  .popup-image {
    position: fixed;
    top:0; left:0;
    background: rgba(0,0,0,.9);
    height: 100%;
    width: 100%;
    z-index: 100;
    display:none;
    padding: 100px 130px;
  }

  .popup-image span {
    position: absolute;
    top:30px; right:10px;
    font-size: 60px;
    font-weight: bolder;
    color: #fff;
    cursor: pointer;
    z-index: 100;
  }

  .popup-image img {
    position: absolute;
    top:50%; left:50%;
    transform: translate(-50%, -50%);
    border:5px solid #fff;
    border-radius: 5px;
    width: 750px;
    object-fit: cover;
    background-color: #eee;
  }

</style>

<script type="text/javascript"> 

  var userUid = window.USER_INFO.user_uid;

  var mListInfo = new Array();
  var jsonParam = new Object();
  jsonParam.service_tp = 'exh_tmpl_list';
  jsonParam.max_ret_count = '18';
  jsonParam.page_num = '1';
  jsonParam.user_uid = userUid;


  $(document).ready(function() {

    $('body').on("click", ".paging a", function(){
      var pageId = $(this)[0].id;

      AIRPASS.pageInfo.rangePage = pageId.slice(4);		
      AIRPASS.pageInfo.pageNum = parseInt(pageId.slice(4));
      jsonParam.page_num = AIRPASS.pageInfo.rangePage;

      $('#tbody_tmpl').empty();
      doCommunication(jsonParam);
    });

    $('body').on("click", "._view-fl", function(){
      const tmpl_uid = $(this).attr('tmpl-id');
      $('.popup-image').css('display','block');
      $('#3dviewer').attr('src', 'https://service.3dbank.xyz/p/exhibition/index.html?tmpl_idx=' + tmpl_uid);
      //$('body').css('margin-right', (window.innerWidth - $('body').width()) + 'px');
    	//$('body').css('overflow', 'hidden');
    });

    $('.popup-image span').on("click", function(){
      $('.popup-image').css('display','none');
      //$('body').css('overflow', '');
      //$('body').css('margin-right', '');
    });

    readList();
  });
  

  function readList() {
    AIRPASS.pageInfo.rangePage = 1;
    AIRPASS.pageInfo.pageNum = 1;

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
				    mListInfo = result;
				    setList();
			    } else {
        		alert(result.retmsg);
        	}
        }
    });
  }

  // ????????? ??????
  function setList() {
    if (mListInfo.exh_tmpl_list == undefined) return;

    AIRPASS.pageInfo.totalCount = mListInfo.total_cnt;
    let idx = (AIRPASS.pageInfo.pageNum-1)*18+1;

    for (var i=0; i<mListInfo.exh_tmpl_list.length; i++, idx++) {
      let tmplInfo = mListInfo.exh_tmpl_list[i];
      
      let tmpl_tp = (tmplInfo.tmpl_tp == "1") ? "?????????" : "?????????";
      let use_yn = (tmplInfo.use_yn == "Y") ? "?????? ??????" : "?????? ?????????";
      let htmlText = '';

      if(tmplInfo.user_uid == userUid) htmlText = "<td><a href='/exhibition/template/edit.do?tmpl_id=" +tmplInfo.exh_tmpl_uid+ "'>" + tmplInfo.tmpl_name + "</a></td>";
      else htmlText = "<td>" + tmplInfo.tmpl_name + "</td>";
      
      var tmpHtml = 
        "<tr>" + 
          "<td>" + idx + "</td>" + htmlText +
          "<td>" + tmpl_tp + "</td>" + 
          "<td>" + tmplInfo.prod_cnt + "</td>" + 
          "<td class='alignL _view-fl' tmpl-id='" + tmplInfo.exh_tmpl_uid + "'><a href='javascript:;'>" + tmplInfo.file_name + "</a></td>" +
          "<td>" + use_yn + "</td>" +
        "</tr>";
      $('#tbody_tmpl').append(tmpHtml);
    }

    pagination(AIRPASS.pageInfo);
  }

</script>


<body id="page-top">
  <div id="wrapper">
    <%@ include file="../include/header.jsp" %>
      <div class="container-fluid" id="container-wrapper">
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
          <h1 class="h3 mb-0 text-gray-800">????????? ????????? ??????</h1>
          <ol class="breadcrumb">
            <li class="breadcrumb-item">????????? ????????? ??????</li>
            <li class="breadcrumb-item active" aria-current="page">????????? ????????? ??????</li>
          </ol>
        </div>

        <div class="row">
          <div class="col-lg-12 mb-4">
            <div class="card">
              <div class="table-responsive">
                <table class="table align-items-center table-flush text-center">
                  <colgroup>
                    <col width="70px">
                    <col width="400px">
                    <col width="150px">
                    <col width="140px">
                    <col width="250px">
                    <col width="140px">
                  </colgroup>
                  <thead class="thead-light">
                    <tr>
                      <th>No</th>
                      <th>????????? ????????????</th>
                      <th>????????? ??????</th>
                      <th>?????? ?????? ???</th>
                      <th>3D????????? ?????????</th>
                      <th>????????? ????????????</th>
                    </tr>
                  </thead>
                  <tbody id="tbody_tmpl">
                    <!--<tr>
                      <td>1</td>
                      <td><a href="/template/edit.do">???????????? ?????????</a></td>
                      <td>?????????</td>
                      <td>10</td>
                      <td>VR_sport.gltf</td>
                      <td>??????</td>
                    </tr>
                    <tr>
                      <td>2</td>
                      <td><a href="/template/edit.do">?????? ?????????</a></td>
                      <td>?????????</td>
                      <td>30</td>
                      <td>Sila_museum.gltf</td>
                      <td>?????????</td>
                    </tr>-->
                  </tbody>
                </table>
              </div>
              <div class="card-footer paging">
              </div>
            </div>
          </div>
        </div>
      </div>
    </div> <!-- div#content end -->
    <!-- popUp ?????? -->
    <div class="popup-image">
      <span>&times;</span>
      <iframe id="3dviewer" width="100%" height="100%" frameborder="0" allowfullscreen="" onmousewheel="" allowvr="" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe>
    </div>
<%@ include file="../include/footer.jsp" %>
</body>
</html>