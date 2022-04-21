<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/head.jsp" %>


<script type="text/javascript">
  <% String exh_uid = request.getParameter("exh_uid") == null ? "" : request.getParameter("exh_uid"); %>

  $(document).ready(function() {
    readExhibitionViewInfo();
  });


  function setExhibitionContsInfo() {
    const exhContsList = AIRPASS.exhViewInfo.exh_conts;

    for (var i=0; i < exhContsList.length; i++) {
      const exhConts = exhContsList[i];
      let tmpHtml = 
        '<div class="item">' +
          '<div class="thumb" style="background-image:url(\'/exhibition/downThumbImg.do?conts_uid='+ exhConts.conts_uid +'&file=' +exhConts.thumb_img +'\')"></div>' +
          '<div class="text d-flex">' +
            '<p class="tit">'+ exhConts.main_conts_name +'</p>' +
          '</div>' +
        '</div>';
        $('#_conts-img').append(tmpHtml);
    }

  }


  function setExhibitionViewInfo() {
    const exhInfo = AIRPASS.exhViewInfo.exh_view_info;
    const exhFileList = AIRPASS.exhViewInfo.exh_file;

    for (var i=0; i < exhFileList.length; i++) { 
      const fileInfo = exhFileList[i];
      if (exhInfo.exh_thumb_file_seq == fileInfo.exh_file_seq) {
        const tmpHtml = '<img class="_thumb" src="/exhibition/downThumbImg.do?exh_uid='+ exhInfo.exh_uid +'&file=' + fileInfo.exh_save_name + '&dir=exh' +'" alt="사진이 없습니다.">'
        $('#_exh-thumb-img').append(tmpHtml);
      } else {
        const $tmpHtml = $(
        '<div class="item _file-img">' +
          '<img class="_thumb_s" src="/exhibition/downThumbImg.do?exh_uid='+ exhInfo.exh_uid +'&file=' + fileInfo.exh_save_name + '&dir=exh' +'" alt="사진이 없습니다.">' +
        '</div>'); 

        $('#_exh-file-img').append($tmpHtml);
        $tmpHtml.find('._file-img').lazyload({
          effect: "fadeIn",
        });
      }

    }

    const tmpHtml = '<img src="/exhibition/downThumbImg.do?tmpl_uid='+ exhInfo.exh_tmpl_uid +'&file=' + exhInfo.tmpl_structure_img + '&dir=tmpl' +'" alt="사진이 없습니다.">';
    $('#_tmpl-structure').append(tmpHtml);

    setExhibitionContsInfo();
  }

  function doCommunication(jsonParam) {
    var jsondata = "jsondata=" + JSON.stringify(jsonParam);
    printLog("Send Json Data", jsondata);

    $.ajax({
      type : "POST",  
      url : "/exhibition/AjaxAirpassController.do",
      //url : "//m.3dbank.xyz/Ajax3DWorldController.do",
      data : jsondata,
      success : function(result) {        
        if (result.retcode == "000") {
          AIRPASS.exhViewInfo = result;
          setExhibitionViewInfo();
        } else {
          alert(result.retmsg);
        }
      }
    });
  }

  function readExhibitionViewInfo() {
    let jsonParam = {
      //service_tp: "tmpl_info",
      service_tp: "exh_view_info",
      //service_tp: "get_3DConts_info",
      crud_tp: 'r',
      exh_uid: '<%=exh_uid%>',
      //exh_tmpl_uid: '1',
    }
    if (jsonParam.exh_uid) {
      doCommunication(jsonParam);
    } else {
      alert("전시회 uid가 없습니다.");
    }
  }

</script>

<body id="page-top">
  <div id="wrapper">
    <%@ include file="../include/header.jsp" %>
      <div class="container-fluid" id="container-wrapper">
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
          <h1 class="h3 mb-0 text-gray-800">전시관 상세조회</h1>
          <ol class="breadcrumb">
            <li class="breadcrumb-item">3D전시회 관리</li>
            <li class="breadcrumb-item"><a href="index.php">전시회 목록</a></li>
            <li class="breadcrumb-item active" aria-current="page">전시관 상세조회</li>
          </ol>
        </div>

        <div class="row">
          <div class="col-lg-12 mb-4">
            <div class="card layout-write">
              <form name="" action="" method="">
                <div class="section d-flex area-img">
                  <div class="col-6">
                    <div id="_exh-thumb-img" class="thumb">
                      <!--<img class="_thumb" src="/asia3d/img/data/product/1/img_01.jpg" alt=""> -->
                    </div>
                    <div id="_exh-file-img"class="box-img mt-3">
                      <!--<div class="item">
                        <img class="_thumb_s" src="/asia3d/img/data/product/1/img_01.jpg" alt="">
                      </div> -->
                    </div>
                  </div>
                  <div id="_tmpl-structure"class="col-6 img-single">
                    <!--<img src="/asia3d/img/data/product/1/img_str.png" alt=""> -->
                  </div>
                </div>

                <div class="section box-input">
                  <h6>전시 제품</h6>
                  <div id="_conts-img"class="box-item d-flex">
                    <!--<div class="item">
                      <div class="thumb" style="background-image:url('/asia3d/img/data/product/1/01_01/img_01.jpg')"></div>
                      <div class="text d-flex">
                        <p class="tit">위치 1 : XR 스포츠 체험</p>
                      </div>
                    </div> -->
                  </div>
                </div>

              </form>
            </div>
          </div>
        </div>
      </div>
    </div> <!-- div#content end -->
<%@ include file="../include/footer.jsp" %>
</body>
</html>
<script>
  $('._thumb_s').css('cursor', 'pointer').on('click', function(){
    $('._thumb').attr('src', $(this).attr('src'));
  });
</script>
