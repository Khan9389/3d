<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ include file="../include/head.jsp" %>



<script type="text/javascript"> 

var userUid = window.USER_INFO.user_uid;

<% String conts_uid = request.getParameter("conts_uid") == null ? "" : request.getParameter("conts_uid"); %>

var arrContsFile = new Array();
var arrFirstContsFileName = new Array();

$(document).ready(function() {
  readContents();
  
  // 파일 추가 버튼
  $('#conts_file').change(function() {
    for (var i=0; i<this.files.length; i++) {
      if (this.files && this.files[i]) {
        readFile(this.files, i);
      }
    }
  });

  $('.custom-radio').change(function() {
    const contsTp = $(this).find('input:radio[name=category]').attr('id');
    let acceptFlTp, img, video, conts;
    switch (contsTp) {
      case '_contsTp_1':
        img = '';
        AIRPASS.fileTp.ext_img.forEach(el => {
          img += el + ', ';
        });
        $('#_fl-tp').text(img);
        break;
      case '_contsTp_2':
        video = '';
        acceptFlTp = AIRPASS.fileTp.ext_video;
        acceptFlTp = acceptFlTp.concat(AIRPASS.fileTp.ext_img);
        acceptFlTp.forEach(el => {
          video += el + ', ';
        });
        $('#_fl-tp').text(video);
        break;
      case '_contsTp_3':
        conts = '';
        acceptFlTp = AIRPASS.fileTp.ext_3d;
        acceptFlTp = acceptFlTp.concat(AIRPASS.fileTp.ext_img);
        acceptFlTp.forEach(el => {
          video += el + ', ';
        });
        acceptFlTp.forEach(el => {
          conts += el + ', ';
        });
        $('#_fl-tp').text(conts);
        break;
    }
  });

  $(".box-file").on('dragenter', function(e) {
    e.stopPropagation();
    e.preventDefault();

    $(this).css('background-color', '#eee')
  });


  $(".box-file").on('dragleave', function(e) {
    e.stopPropagation();
    e.preventDefault();

    $(this).css('background-color', '#fff')
  });


  $(".box-file").on('dragover', function(e) {
    e.stopPropagation();
    e.preventDefault();

    $(this).css('background-color', '#eee')
  });


  // 파일 드래그 다운
  $(".box-file").on("drop", function(event) {
    event.stopPropagation();
    event.preventDefault();
      
    var arrayFile = event.originalEvent.dataTransfer.files;
    for (var i=0; i<arrayFile.length; i++) {
      if (arrayFile && arrayFile[i]) {
        readFile(arrayFile, i);
      }
    }

    $(".box-file").css('background-color', '#fff');
  });

});


//상품 이미지파일 멀티등록을 위한 FileReader 생성 함수
function readFile(files, idx) {
  let file = files[idx];
  let size = file.size; //(file.size / 1024 / 1024).toFixed(2)
  let fileName = file.name;

  if (!checkFilename(fileName))
    return;

  var reader = new FileReader();
  reader.readAsDataURL(file);

  reader.onload = function (e) {
    if (arrContsFile.length + arrFirstContsFileName.length >= 30) {
      alert("최대 30개 까지 등록할 수 있습니다.");
      return;
    }
    arrContsFile.push(file);

    let $tmpHtml = $( 
    '<div class="item _item" file-idx="0">' +
      '<div style="position:absolute">' +
        '<input type="radio" name="thumb" style="margin:10px;width:20px;height:20px">' +
      '</div>' +
      '<p class="btn _delete">' +
        '<i class="fas fa-times" style="color:	#800000"></i>' +
      '</p>' +
      '<div class="thumb _thumb" style="background-image:url(' + e.target.result + ')"></div>' +
      '<div class="text _fl-name">'+ fileName +'</div>' +
    '</div>');

    $tmpHtml.find('._delete').on('click', clickDeleteFile);

    $('._box-item').append($tmpHtml);
    
    $tmpHtml.find('._thumb').lazyload({
      effect: "fadeIn",
    });

    $('._item').on('click', function(){
      $(this).find('div > input:radio[name=thumb]').prop('checked', true);
    });

  }
  
}


//파일명 중복체크
function checkFilename(tmpFilename) {
  let acceptFlTp;
  const fileTp = $('.custom-control').find('input:radio[name=category]:checked').attr('id');
  let inputFileTp = fileTp == '_contsTp_1' ?  'ext_img' : fileTp == '_contsTp_2' ? 'ext_video' : 'ext_3d';
  if(fileTp != '_contsTp_1') acceptFlTp = AIRPASS.fileTp[inputFileTp].concat(AIRPASS.fileTp.ext_img);
  else acceptFlTp = AIRPASS.fileTp[inputFileTp];
  let fileExt = tmpFilename.substr(tmpFilename.lastIndexOf('.') + 1).toLowerCase();
  if (acceptFlTp.indexOf(fileExt) < 0) {
    alert('[' + fileExt + '] 형식의 파일은 등록할 수 없습니다.');				
    return false;
  }

  for (var i=0; i < arrContsFile.length; i++) {
    if (arrContsFile[i] && arrContsFile[i].name == tmpFilename) {
      alert("동일한 콘텐츠 파일명이 있습니다.");				
      return false;
    }
  }

  return true;
}


function readContents() {

	var jsonParam = new Object();
	jsonParam.service_tp = "conts_info_reg";
	jsonParam.crud_tp = 'r';
	jsonParam.conts_uid = '<%=conts_uid%>';
  jsonParam.user_uid = userUid;
	doMultipart(jsonParam);

}

function doMultipart(tmpJson) {
  console.log("ajax send (CrudTP, arrContsFile.length, tmpJson)", tmpJson.crud_tp, arrContsFile.length ? arrContsFile : [], tmpJson);

  let formData = new FormData();

	for (let i = 0; i < arrContsFile.length; i++) {
		let file = arrContsFile[i];
		if (file) {
      formData.append("file[]", file);
		}
	}

	formData.append("jsondata", JSON.stringify(tmpJson));

  $.ajax({
        url: '/exhibition/AjaxAirpassMultipartController.do',
        processData: false,
        contentType: false,
        data: formData,
        type: 'POST',
        success: function(result) {
          printLog(JSON.stringify(result));
          
          if (result.retcode == "000") {
            if (tmpJson.crud_tp == "u") {
              alert("저장완료 되었습니다.");
              // 미리보기일경우 사용자 화면으로 이동
              location.href = "/exhibition/product/index.do";
            } else if (tmpJson.crud_tp == "r") {
              AIRPASS.contsList = result;
              mCrudTp = "u";
              setContentsInfo();
              setContsFileInfo();
            } else if (tmpJson.crud_tp == "d") {
              alert("정상적으로 삭제 되었습니다.");
              // 미리보기일경우 사용자 화면으로 이동
              location.href = "/exhibition/product/index.do";
            }
          } else {
            alert(result.retmsg);
            location.href = "/exhibition/product/index.do";
          }
        },
        beforeSend:function() {
          $('#progress').show();
        },
        complete:function(){
          $('#progress').hide();
        }
  });
}


//콘텐츠 정보 세팅
function setContentsInfo() {

  let contsList = AIRPASS.contsList;
  let acceptFlTp, img, video, conts;
  // 콘텐츠 종류 set
  switch(contsList.conts_tp){
    case 1:
      $("#_contsTp_1").prop('checked', true);
      img = '';
      AIRPASS.fileTp.ext_img.forEach(el => {
        img += el + ', ';
      });
      $('#_fl-tp').text(img);
      break;
    case 2:
      $("#_contsTp_2").prop('checked', true);
      video = '';
      acceptFlTp = AIRPASS.fileTp.ext_video;
      acceptFlTp = acceptFlTp.concat(AIRPASS.fileTp.ext_img);
      acceptFlTp.forEach(el => {
        video += el + ', ';
      });
      $('#_fl-tp').text(video);
      break;
    case 3:
      $("#_contsTp_3").prop('checked', true);
      conts = '';
      acceptFlTp = AIRPASS.fileTp.ext_3d;
      acceptFlTp = acceptFlTp.concat(AIRPASS.fileTp.ext_img);
      acceptFlTp.forEach(el => {
        video += el + ', ';
      });
      acceptFlTp.forEach(el => {
        conts += el + ', ';
      });
      $('#_fl-tp').text(conts);
      break;     
  }

  // 콘텐츠 정보 세팅
  $('#_contsName').val(contsList.conts_name);
  contsList.use_yn == 'Y' ? $('#yes').attr('checked', true) : $('#no').attr('checked', true);
  $('#_contsDesc').val(contsList.conts_desc);
}


// 파일 정보 세팅
function setContsFileInfo() {
  let contsList = AIRPASS.contsList;
  let fileList = AIRPASS.contsList.conts_file;
  if(!fileList) return;

  for (let i = 0; i < fileList.length; i++) {
    let file = fileList[i];

    arrFirstContsFileName.push(file.conts_save_name);
    
    let $tmpHtml = $( 
      '<div class="item _item" file-idx="' + file.conts_file_seq + '">' +
        '<div style="position:absolute">' +
          '<input type="radio" name="thumb" style="margin:10px;width:20px;height:20px">' +
        '</div>' +
        '<p class="btn _delete">' +
          '<i class="fas fa-times" style="color:	#800000"></i>' +
        '</p>' +
        '<div class="thumb _thumb" style="background-image:url(\'/exhibition/downThumbImg.do?conts_uid='+ file.conts_uid +'&file=' + file.conts_save_name +'\')"></div>' +
        '<div class="text _fl-name">'+ file.conts_file_name +'</div>' +
      '</div>'
    );   //find('._delete').on('click', clickDeleteFile);

    $tmpHtml.find('._delete').on('click', clickDeleteFile);

    $('._box-item').append($tmpHtml);
    
    $tmpHtml.find('._thumb').lazyload({
      effect: "fadeIn",
    });

    if (contsList.thumbnail_file_seq == file.conts_file_seq) {
      $('._item').find('div > input:radio[name=thumb]').prop('checked', true);
    }

  }

  $('._item').on('click', function(){
    $(this).find('div > input:radio[name=thumb]').prop('checked', true);
  });
}

// 이미지파일삭제 버튼 클릭
function clickDeleteFile(e) {
  e.stopImmediatePropagation();
  var obj = e.currentTarget;

  var tmpIdx = $('.box-item ._item').index($(obj).closest('._item'));
  $(".box-item > ._item:eq(" + tmpIdx + ")").remove();


  if (tmpIdx < arrFirstContsFileName.length) {
		arrFirstContsFileName.splice(tmpIdx, 1);
  } else {
		arrContsFile.splice(tmpIdx - arrFirstContsFileName.length, 1);
  }
  
}

function clickBtnSave() {
  let conts_name = $('#_contsName').val();
  conts_name = $.trim(conts_name);
  let conts_tp = $("#_contsTp_1").is(":checked") ? 1 : $("#_contsTp_2").is(":checked") ? 2 : $("#_contsTp_3").is(":checked") ? 3 : 0;
  let conts_desc = $('#_contsDesc').val();
  let thumbCheck = $('.box-item ._item input:radio[name=thumb]').is(":checked");
  let thumbnail_file_seq = $('.box-item ._item input:radio[name=thumb]:checked').closest('._item').attr('file-idx');
  let useYN = $("#yes").is(":checked") ? 'Y' : 'N';

  if(conts_tp != 1) {
    let glbTpCnt = 0;
    let mp4TpCnt = 0;
    $('._box-item ._item').each(function() {
      let flName = $(this).find('._fl-name').text();
      let fileExt = flName.substr(flName.lastIndexOf('.') + 1).toLowerCase();
      if (fileExt == 'glb' ) glbTpCnt++;
      if (fileExt == 'mp4' ) mp4TpCnt++;
    });
    if((conts_tp == 3 && (glbTpCnt > 1 || glbTpCnt < 1)) || (conts_tp == 2 && (mp4TpCnt > 1 || mp4TpCnt < 1))) {
      alert("핵심 파일은 반드시 필요하며, 두 개 이상일 수 없습니다.");
      return;
    }
  }

  if (!thumbCheck) {
    alert("썸네일 이미지를 클릭해주세요.");
    return;
  }

  if (conts_name.length == 0) {
    alert("콘텐츠명을 입력해주세요.");
    return;
  }

  if (conts_tp == 0) {
    alert("콘텐츠 종류을 입력해주세요.");
    return;
  }

  var paramJson = new Object();
  paramJson.service_tp = "conts_info_reg";
  paramJson.conts_uid = AIRPASS.contsList.conts_uid;
  paramJson.crud_tp = "u";
  paramJson.conts_name = conts_name;
  paramJson.conts_tp = conts_tp;
  paramJson.conts_desc = conts_desc;
  paramJson.thumbnail_file_seq = thumbnail_file_seq;
  paramJson.use_yn = useYN;


  // thumb 인덱스
  let $radioButtons = $('.box-item ._item input:radio[name=thumb]');
  let selectedIndex = $radioButtons.index($("input:radio[name=thumb]:checked"));
  selectedIndex -= arrFirstContsFileName.length;

  // 콘텐츠이미지 파라미터 세팅
  var arrContsFileTmp = new Array();
  for (var i=0; i<arrContsFile.length; i++) {
    if (!arrContsFile[i]) {
      continue;
    }
    var objContsFile = new Object();
    objContsFile.file_name = arrContsFile[i].name;
    objContsFile.file_size = arrContsFile[i].size;
    objContsFile.isThumb = i === selectedIndex;
    arrContsFileTmp.push(objContsFile);
  }
  paramJson.arr_conts_file = arrContsFileTmp;

  let arrayInsName = new Array();
  let arrayDelName = new Array();

  for (let i=0; i < arrContsFile.length; i++) {
    arrayInsName.push(arrContsFile[i].name);
  }

  let fileList = AIRPASS.contsList.conts_file;
  let tmpFilesList = new Array();
  for (let i=0; i < fileList.length; i++) {
    if (fileList[i] && fileList[i].conts_save_name)
      tmpFilesList.push(fileList[i].conts_save_name);
  }
  for (let i=0; i < tmpFilesList.length; i++) {
    if (tmpFilesList[i] && arrFirstContsFileName.indexOf(tmpFilesList[i]) == -1)
      arrayDelName.push(tmpFilesList[i]);
  }

  paramJson.arrayInsName = arrayInsName;
  paramJson.arrayDelName = arrayDelName;

  //console.log(paramJson);
  doMultipart(paramJson);
}


function deleteConts() {
  var paramJson = new Object();
  paramJson.conts_uid = '<%=conts_uid%>';
  paramJson.service_tp = 'conts_info_reg';
  paramJson.crud_tp = 'd';
  paramJson.del_yn = 'Y';
  doMultipart(paramJson);
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
        if(result.retmsg == 'false'){
          alert('사용중인 전시회가 있습니다. 전시회를 종료 후 삭제 하세요.');
        } else if(result.retmsg == 'true') {
          deleteConts();
        } else {
          alert(result.retmsg);
        }

      }
  });
}


function clickDelConts() {
  let jsonParam = new Object();
  jsonParam.service_tp = 'check_conts_delete';
  jsonParam.conts_uid = '<%=conts_uid%>';
  doCommunication(jsonParam);
}

</script>



<body id="page-top">
  <div id="wrapper">
    <%@ include file="../include/header.jsp" %>
      <div class="container-fluid" id="container-wrapper">
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
          <h1 class="h3 mb-0 text-gray-800">전시 콘텐츠 수정</h1>
          <ol class="breadcrumb">
            <li class="breadcrumb-item">전시 콘텐츠 관리</li>
            <li class="breadcrumb-item"><a href="index.php">전시 콘텐츠 목록</a></li>
            <li class="breadcrumb-item active" aria-current="page">전시 콘텐츠 수정</li>
          </ol>
        </div>

        <div class="row">
          <div class="col-lg-12 mb-4">
            <div class="card layout-write">
              <div class="section">
                <h6>기본 정보</h6>
                <div class="d-flex">
                  <p class="mr-4" style="font-size:18px">콘텐츠 종류</p>
                  <div class="custom-control custom-radio mr-3">
                    <input type="radio" id="_contsTp_1" name="category" class="custom-control-input">
                    <label class="custom-control-label" for="_contsTp_1">사진</label>
                  </div>
                  <div class="custom-control custom-radio mr-3">
                    <input type="radio" id="_contsTp_2" name="category" class="custom-control-input">
                    <label class="custom-control-label" for="_contsTp_2">동영상</label>
                  </div>
                  <div class="custom-control custom-radio mr-3">
                    <input type="radio" id="_contsTp_3" name="category" class="custom-control-input">
                    <label class="custom-control-label" for="_contsTp_3">3D 콘텐츠</label>
                  </div>
                </div>
                
                <div class="box-file">
                  <i class="fas fa-cloud-upload-alt"></i>
                  <p class="main">업로드할 파일을 <span class="text-primary">선택</span> 또는 <span class="text-primary">드래그</span>해주세요</p>
                  <input id="conts_file" type="file" class="form-control" name="file" enctype='multipart/form_data' multiple>
                  <p class="sub">*<span id="_fl-tp" class="text-primary"></span> 파일을 선택해주세요 (최대 30개까지 업로드 가능)</p>
                </div>
                
                <div class="box-item _box-item">
                  <!--<div class="item">
                    <p class="btn">
                      <i class="fas fa-times"></i>
                    </p>
                    <div class="thumb" style="background-image:url('/asia3d/img/data/product/1/01_01/img_01.jpg')"></div>
                    <div class="text">img_01.jpg</div>
                  </div>-->
                </div>
              </div>

              <div class="section box-input">
                <h6>콘텐츠 정보</h6>
                <div class="row column-input column-input-bar">
                  <label class="field d-flex col-sm-6" style="max-width:600px">
                    <p>콘텐츠 명</p>
                    <input type="text" id="_contsName" class="form-control" value="XR 스포츠 체험">
                  </label>
                    <div class="field d-flex col-sm-6">
                      <p>전시콘텐츠 등록여부</p>
                      <div class="custom-control custom-radio mr-3">
                        <input type="radio" class="custom-control-input" name="use-yn" id="yes" checked>
                        <label class="custom-control-label" for="yes">가능</label>
                      </div>
                      <div class="custom-control custom-radio mr-3">
                        <input type="radio" class="custom-control-input" name="use-yn" id="no">
                        <label class="custom-control-label" for="no">불가능</label>
                      </div>
                    </div>
                </div>
                <div class="field mt-3">
                  <p class="mb-2">콘텐츠 설명</p>
                  <textarea id="_contsDesc" class="form-control" rows="5">

                  </textarea>
                </div>
              </div>

              <div class="d-flex justify-content-end mt-5">
                <button type="button" class="btn btn-lg btn-secondary mr-2" onclick="clickDelConts()">삭제</button>
                <button type="submit" class="btn btn-lg btn-primary" onclick="clickBtnSave()">수정</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div> <!-- div#content end -->
<%@ include file="../include/footer.jsp" %>
	<div id="progress" style="position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; line-height: 100vh; text-align:center; background-color: rgba(255,255,255,0.5); z-index: 99; display: none;">
		<img src="/asia3d/img/progress.gif" style="position:absolute; max-width:100%; max-height:100%; width:75px; height:auto; margin:auto; top:0; bottom:0; left:0; right:0">
	</div>
</body>
</html>