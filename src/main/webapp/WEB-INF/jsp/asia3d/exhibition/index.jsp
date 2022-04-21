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

<% String page_num = request.getParameter("page_num"); %>

<script type="text/javascript"> 
var userUid = window.USER_INFO.user_uid;
var exhListInfo = new Array();

var jsonParam = new Object();
jsonParam.service_tp = "exh_info_list";
jsonParam.page_num = '1';
jsonParam.max_ret_count = '18';
jsonParam.user_uid = userUid;

$(document).ready(function() {
  readList();

  $('body').on("click", "._tmpl-view", function(){
    const tmpl_uid = $(this).attr('tmpl-id');
    $('.popup-image').css('display','block');
    $('#3dviewer').attr('src', 'https://service.3dbank.xyz/p/exhibition/index.html?tmpl_idx=' + tmpl_uid);
  });

  $('.popup-image span').on("click", function(){
    $('.popup-image').css('display','none');
    //$('body').css('overflow', '');
    //$('body').css('margin-right', '');
  });

  $("#_use-yn").change(function() {
    refreshPage();
  });

  $('body').on("click", ".paging a", function(){
    var pageId = $(this)[0].id;

    AIRPASS.pageInfo.rangePage = pageId.slice(4);		
    AIRPASS.pageInfo.pageNum = parseInt(pageId.slice(4));
    jsonParam.page_num = AIRPASS.pageInfo.rangePage;

    $('._tbody').empty();
    doCommunication(jsonParam);
  });

});

function refreshPage() {
  let useYN = $('#_use-yn').val() == '공개' ? 'Y' : 'N';
  document.location.href = '/exhibition/exhibition/index.do?useYn='+ useYN;
}


function setExhibitionList() {
  let exhList = AIRPASS.exhList.exh_list;
  let exhInfo;
  let tmpHtml = '';
  let useYN = ''; 

  AIRPASS.pageInfo.totalCount = AIRPASS.exhList.total_count;
  let idx = (AIRPASS.pageInfo.pageNum-1)*18+1;

  for (var i=0; i < exhList.length; i++, idx++) { 
    exhInfo = exhList[i];
    useYN = exhInfo.use_yn == 'Y' ? '공개' : '비공개';

    let htmlText = '';
    if(exhInfo.user_uid == userUid) htmlText = '<td><a href="/exhibition/exhibition/edit.do?exh_uid='+exhInfo.exh_uid+'">'+ exhInfo.exh_name +'</a></td>';
    else htmlText = '<td>'+ exhInfo.exh_name +'</td>';

    let dateHtml = '';
    if(exhInfo.dateCheck == 'true') dateHtml = '<td><a href="//service.3dbank.xyz/p/exhibition/index.html?idx='+exhInfo.exh_uid+'">'+ exhInfo.exh_start_period +' ~ '+ exhInfo.exh_end_period +'</a></td>';
    else dateHtml = '<td>'+ exhInfo.exh_start_period +' ~ '+ exhInfo.exh_end_period +'</td>';

    tmpHtml = 
      '<tr>' +
        '<td>'+ idx +'</td>' + htmlText +
        '<td>'+ useYN +'</td>' +
        '<td class="_tmpl-view" tmpl-id="' + exhInfo.exh_tmpl_uid + '"><a href="javascript:;">' + exhInfo.tmpl_name +'</a></td>' +
        '<td>'+ exhInfo.conts_cnt +'</td>' +
        '<td><a href="/exhibition/exhibition/view.do?exh_uid='+exhInfo.exh_uid+'">'+ exhInfo.main_conts_cnt +'</a></td>' + dateHtml+
      '</tr>';

    $('._tbody').append(tmpHtml);
  }

  pagination(AIRPASS.pageInfo);

}


function doCommunication(jsonParam) {
  var jsondata = "jsondata=" + JSON.stringify(jsonParam);
  printLog("send data", jsondata);

    $.ajax({
      type : "POST",  
      url : "/exhibition/AjaxAirpassController.do",
      data : jsondata,
      success : function(result) {        
        if (result.retcode == "000") {
          AIRPASS.exhList = result;
          setExhibitionList();
        } else {
          alert(result.retmsg);
        }
      }
  });
}

function readList() {
  AIRPASS.pageInfo.rangePage = 1;
  AIRPASS.pageInfo.pageNum = 1;
  AIRPASS.pageInfo.maxRetCount = 18;

  jsonParam.use_yn = getURLParameter("useYn") ? getURLParameter("useYn") : 'Y';
  jsonParam.exh_word = getURLParameter("exh_word") ? getURLParameter("exh_word") : '';

  $('#_use-yn').val(jsonParam.use_yn == 'Y' ? '공개' : '비공개'); // 전시 상태의 value 값

  doCommunication(jsonParam);
}


function searchExhibition() {
  let inp_text = $('#_searchExh').val();
  let useYN = $('#_use-yn').val() == '공개' ? 'Y' : 'N';
  if(inp_text == null || inp_text == ""){
    alert("검색어를 입력해주세요");
  } else {
    document.location.href = '/exhibition/exhibition/index.do?useYn='+ useYN + '&exh_word=' + inp_text;		
  }
}

</script>


<body id="page-top">
  <div id="wrapper">
    <%@ include file="../include/header.jsp" %>
      <div class="container-fluid" id="container-wrapper">
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
          <h1 class="h3 mb-0 text-gray-800">전시회 목록</h1>
          <ol class="breadcrumb">
            <li class="breadcrumb-item">3D전시회 관리</li>
            <li class="breadcrumb-item active" aria-current="page">전시회 목록</li>
          </ol>
        </div>

        <div class="row layout-list">
          <div class="col-lg-12 mb-4">
            <div class="card">
              <div class="card-header d-flex align-items-baseline justify-content-between">
                <label class="d-flex align-items-center">
                  <p class="mr-3">전시 상태</p>
                  <select id="_use-yn" class="form-control">
                    <option value="공개">공개</option>
                    <option value="비공개">비공개</option>
                  </select>
                </label>

                <div class="input-group bar-search">
                  <input id="_searchExh" type="text" class="form-control bg-light border-1 small" placeholder="검색어를 입력하세요" aria-label="Search" aria-describedby="basic-addon2" style="border-color: #3f51b5;" onkeypress="if(event.keyCode==13) {$('#_search').trigger('click'); return false;}">
                  <div class="input-group-append">
                    <button id="_search" class="btn btn-primary" type="button" onclick="searchExhibition()">
                      <i class="fas fa-search fa-sm"></i>
                    </button>
                  </div>
                </div>
              </div>

              <div class="table-responsive">
                <table class="table align-items-center table-flush text-center">
                  <colgroup>
                    <col width="70px">
                    <col width="200px">
                    <col width="118px">
                    <col width="200px">
                    <col width="120px">
                    <col width="120px">
                    <col width="250px">
                  </colgroup>
                  <thead class="thead-light thead-center">
                    <tr>
                      <th>No</th>
                      <th>전시회명</th>
                      <th>전시상태</th>
                      <th>전시관 명</th>
                      <th>최대 <br>게시물 수</th>
                      <th>등록 <br>전시물 수</th>
                      <th>전시 기간</th>
                    </tr>
                  </thead>
                  <tbody class="_tbody">
                    <!--<tr>
                      <td>1</td>
                      <td><a href="/exhibition/edit.do">에어패스 체험관</a></td>
                      <td>공개</td>
                      <td>VR_체험관</td>
                      <td>10</td>
                      <td>10</td>
                      <td><a href="/exhibition/view.do">2021.10.10 ~ 2021.12.12</a></td>
                    </tr> -->
                  </tbody>
                </table>
              </div>
              <div class="card-footer paging">
                <!--<ul class="pagination justify-content-end mb-1">
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
                </ul> -->
              </div>
            </div>
          </div>
        </div>
      </div>
    </div> <!-- div#content end -->
    <!-- popUp 기술 -->
    <div class="popup-image">
      <span>&times;</span>
      <iframe id="3dviewer" width="100%" height="100%" frameborder="0" allowfullscreen="" onmousewheel="" allowvr="" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe>
    </div>
<%@ include file="../include/footer.jsp" %>
</body>
</html>