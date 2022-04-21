<%@ 
	page language="java" 
	contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"
%>

<%@ include file="../include/head.jsp" %>



<body id="page-top">

<script type="text/javascript"> 

  var userUid = window.USER_INFO.user_uid;
  var mArrayContsFile = new Array();

  $(document).ready(function() {

    setFileTp();

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
        case 'conts_tp_1':
          img = '';
          AIRPASS.fileTp.ext_img.forEach(el => {
            img += el + ', ';
          });
          $('#_fl-tp').text(img);
          break;
        case 'conts_tp_2':
          video = '';
          acceptFlTp = AIRPASS.fileTp.ext_video;
          acceptFlTp = acceptFlTp.concat(AIRPASS.fileTp.ext_img);
          acceptFlTp.forEach(el => {
            video += el + ', ';
          });
          $('#_fl-tp').text(video);
          break;
        case 'conts_tp_3':
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

  function setFileTp() {
    let conts = '';
    let acceptFlTp = AIRPASS.fileTp.ext_3d;
    acceptFlTp = acceptFlTp.concat(AIRPASS.fileTp.ext_img);
    acceptFlTp.forEach(el => {
      conts += el + ', ';
    });
    $('#_fl-tp').text(conts);
  }

  //상품 이미지파일 멀티등록을 위한 FileReader 생성 함수
	function readFile(files, idx) {
		var file = files[idx];
		var size = file.size; //(file.size / 1024 / 1024).toFixed(2) ;
		var fileName = file.name;
		
		if (!checkFilename(fileName))
			return;
		
		var reader = new FileReader();
		reader.readAsDataURL(file);
		reader.onload = function (e) {

			if (mArrayContsFile.length >= 30) {
				alert("최대 30개 까지 등록할 수 있습니다.");
				return;
			}
			mArrayContsFile.push(file);
	   		
      // var $tmpHtml = $(
      //   '<div class="item">' +
      //     '<p class="btn">'  +
      //       "<input type='button' name='sch_button3' value='x' class='btn btn-danger btn-sm' onclick='clickDeleteFile(this)' />" +
      //     '</p>' +
      //     '<div class="_thumb thumb" style="background-image:url(' + e.target.result + ')"></div>' +
      //     '<div class="_text text"><input type="radio" name="thumb" style="margin-right:5px">' + fileName + '</div>' +
      //   '</div>'
      // ).on('click', function(){
      //   $(this).find('input:radio[name=thumb]').prop('checked', true);
      // });

      var $tmpHtml = $('._item:not(._smp)').clone().addClass('_smp').show().on('click', function(){
        $(this).find('div > input:radio[name=thumb]').prop('checked', true);
      });
      $tmpHtml.find('._thumb').css({ 'background-image': 'url(' + e.target.result + ')' });
      $tmpHtml.find('._span').text(fileName);
      $tmpHtml.find('._close').on('click', clickDeleteFile);

      $('.box-item').append($tmpHtml);
      
      $('.box-item div > .thumb').lazyload({
        effect: "fadeIn",
      });
		}

	}


  //파일명 중복체크
	function checkFilename(tmpFilename) {
    let acceptFlTp;
    const fileTp = $('.custom-control').find('input:radio[name=category]:checked').attr('id');
    let inputFileTp = fileTp == 'conts_tp_1' ?  'ext_img' : fileTp == 'conts_tp_2' ? 'ext_video' : 'ext_3d';
    if(fileTp != 'conts_tp_1') acceptFlTp = AIRPASS.fileTp[inputFileTp].concat(AIRPASS.fileTp.ext_img);
    else acceptFlTp = AIRPASS.fileTp[inputFileTp];
		let fileExt = tmpFilename.substr(tmpFilename.lastIndexOf('.') + 1).toLowerCase();

    if (acceptFlTp.indexOf(fileExt) < 0) {
      alert('[' + fileExt + '] 형식의 파일은 등록할 수 없습니다.');				
      return false;
    }

		for (var i=0; i < mArrayContsFile.length; i++) {
			if (mArrayContsFile[i] && mArrayContsFile[i].name == tmpFilename) {
				alert("동일한 콘텐츠 파일명이 있습니다.");				
				return false;
			}
		}

		return true;
	}


  // 이미지파일삭제 버튼 클릭
	function clickDeleteFile(e) {
    e.stopImmediatePropagation();

    var obj = e.currentTarget;

		var tmpIdx = $('.box-item ._smp').index($(obj).closest('._smp'));
    console.log(tmpIdx);
    //tmpIdx++;
		$(".box-item > ._smp:eq(" + tmpIdx + ")").remove();
    mArrayContsFile.splice(tmpIdx, 1);
    console.log('aaaaa', e);
	}


  // 저장버튼 클릭
	function clickBtnSave() { 

    let conts_name = $('#conts_name').val();
    conts_name = $.trim(conts_name);
    let conts_tp = $("#conts_tp_1").is(":checked") ? 1 : $("#conts_tp_2").is(":checked") ? 2 : $("#conts_tp_3").is(":checked") ? 3 : 0;
    let conts_desc = $('#conts_desc').val();
    let thumbCheck = $('.box-item ._smp input:radio[name=thumb]').is(":checked");
    let useYN = $("#yes").is(":checked") ? 'Y' : 'N';

    if(conts_tp != 1) {
      let glbTpCnt = 0;
      let mp4TpCnt = 0;
      mArrayContsFile.forEach(el => {
        let fileExt = el.name.substr(el.name.lastIndexOf('.') + 1).toLowerCase();
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

    if (mArrayContsFile.length == 0) {
		  alert("업로드할 파일을 선택 또는 드래그해주세요.");
		  return;
	  }


    var paramJson = new Object();
    paramJson.service_tp = "conts_info_reg";
    paramJson.crud_tp = "c";
    paramJson.conts_name = conts_name;
    paramJson.conts_tp = conts_tp;
    paramJson.conts_desc = conts_desc;
    paramJson.use_yn = useYN;
    paramJson.user_uid = userUid;

    // thumb 인덱스
    var $radioButtons = $('.box-item ._smp input:radio[name=thumb]');
    var selectedIndex = $radioButtons.index($("input:radio[name=thumb]:checked"));

	  // 콘텐츠이미지 파라미터 세팅
	  var arrContsFile = new Array();
	  for (var i=0; i<mArrayContsFile.length; i++) {
		  if (!mArrayContsFile[i]) {
			  continue;
		  }
		  var objContsFile = new Object();
		  objContsFile.file_name = mArrayContsFile[i].name;
      objContsFile.file_size = mArrayContsFile[i].size;
      objContsFile.isThumb = i === selectedIndex;
		  arrContsFile.push(objContsFile);
	  }
	  paramJson.arr_conts_file = arrContsFile;

    doMultipart(paramJson);
	}

  // Multipart 통신 및 Callback
  function doMultipart(tmpJson) {
    printLog("send JSON", JSON.stringify(tmpJson));

    var formData = new FormData();
    for (var i=0; i<mArrayContsFile.length; i++) {
		  if (mArrayContsFile[i]) formData.append("file[]", mArrayContsFile[i]);
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
          alert("저장완료 되었습니다.");
          location.href = "/exhibition/product/index.do";
        } else {
          alert(result.retmsg);
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

</script>


  <div id="wrapper">
    <%@ include file="../include/header.jsp" %>
     <div class="container-fluid" id="container-wrapper">
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
          <h1 class="h3 mb-0 text-gray-800">전시 콘텐츠 등록</h1>
          <ol class="breadcrumb">
            <li class="breadcrumb-item">전시 콘텐츠 관리</li>
            <li class="breadcrumb-item active" aria-current="page">전시 콘텐츠 등록</li>
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
                      <input type="radio" id="conts_tp_1" name="category" class="custom-control-input">
                      <label class="custom-control-label" for="conts_tp_1">사진</label>
                    </div>
                    <div class="custom-control custom-radio mr-3">
                      <input type="radio" id="conts_tp_2" name="category" class="custom-control-input">
                      <label class="custom-control-label" for="conts_tp_2">동영상</label>
                    </div>
                    <div class="custom-control custom-radio mr-3">
                      <input type="radio" id="conts_tp_3" name="category" class="custom-control-input" checked>
                      <label class="custom-control-label" for="conts_tp_3">3D 콘텐츠</label>
                    </div>
                  </div>
                  
                  <div class="box-file">
                    <i class="fas fa-cloud-upload-alt"></i>
                    <p class="main">업로드할 파일을 <span class="text-primary">선택</span> 또는 <span class="text-primary">드래그</span>해주세요</p>
                    <input id="conts_file" type="file" class="form-control" name="file" enctype='multipart/form-data' multiple>
                    <p class="sub">*<span id="_fl-tp" class="text-primary"></span> 파일을 선택해주세요 (최대 30개까지 업로드 가능)</p>
                  </div>
                  
                  <div class="box-item">
                    <div class="_item item" style="display:none">
                      <div style="position:absolute">
                        <input type="radio" name="thumb" style="margin:10px;width:20px;height:20px">
                      </div>
                      <p class="_close btn">
                        <i class="fas fa-times" style="color:	#800000"></i>
                      </p>
                      <div class="_thumb thumb" style="background-image:url('')"></div>
                      <div class="text">
                        <span class="_span">testtesttest.ply</span>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="section box-input">
                  <h6>콘텐츠 정보</h6>
                  <div class="row column-input column-input-bar">
                    <label class="field d-flex col-sm-6" style="max-width:600px">
                      <p>콘텐츠 명</p>
                      <input id="conts_name" type="text" class="form-control">
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
                    <textarea id="conts_desc" class="form-control" rows="5"></textarea>
                  </div>
                </div>
                <div class="d-flex justify-content-end mt-5">
                  <button type="button" class="btn btn-lg btn-secondary mr-2" onclick="location.href='/exhibition/product/index.do'">목록</button>
                  <button type="submit" class="btn btn-lg btn-primary" onclick="clickBtnSave()">저장</button>
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