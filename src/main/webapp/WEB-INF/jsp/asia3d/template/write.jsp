
<%@ 
	page language="java" 
	contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"
%>


<%@ include file="../include/head.jsp" %>

<!--  <link rel="stylesheet" type="text/css" media="screen" href="/asia3d/jquery-ui/jquery-ui.css" /> -->
<script src="/asia3d/jquery-ui/jquery-ui.js" type="text/javascript"></script>
<script src="/asia3d/js/jquery.lazyload.min.js" type="text/javascript"></script>

<body id="page-top">

<script type="text/javascript">

  var userUid = window.USER_INFO.user_uid;
	var mArrayContsFile = new Array();

	$(document).ready(function() {
		// 파일추가	
		$('#ex_file').change(function() {
			for (var i=0; i<this.files.length; i++) {
				if (this.files && this.files[i]) {
					readFile(this.files, i);
				}
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
	
	

	
	// 이미지파일 멀티등록을 위한 FileReader 생성 함수
	function readFile(files, idx) {
		var file = files[idx];
		var size = file.size; //(file.size / 1024 / 1024).toFixed(2) ;
		var fileName = file.name;
		
		if (!checkFilename(fileName))
			return;
		
		var reader = new FileReader();
		reader.readAsDataURL(file);
		reader.onload = function (e) {


			if (mArrayContsFile.length >= 3) {
				alert("최대 3개 까지 등록할 수 있습니다.");
				return;
			}
			mArrayContsFile.push(file);
	   		
	   		var tmpHtml =
	   			"<tr>" + 
	   				'<td><select class="form-control cont_type"><option value="1" selected>3D 전시관</option><option value="2">대표 이미지</option><option value="3">전시관 구조도</option> </select></td>' + 
	        		"<td>" + fileName + "</td>" + 
	        		"<td>" + size + "</td>" +
	        		"<td>Last Updated : Just Now</td>" + 
	        		"<td><input type='button' name='sch_button3' value='x' class='btn btn-danger btn-sm' onclick='clickDeleteFile(this)' /></td>"
				"</tr>";
	   		$('#tbody_file').append(tmpHtml);
		}
	}
	
	
	// 이미지파일삭제 버튼 클릭
	function clickDeleteFile(obj) {
		var tmpIdx = $('#tbody_file tr').index($(obj).parent().parent());
		$("#tbody_file > tr:eq(" + tmpIdx + ")").remove();
		
    mArrayContsFile.splice(tmpIdx, 1);
	}
	
	
	//파일명 중복체크
	function checkFilename(tmpFilename) {

		let fileExt = tmpFilename.substr(tmpFilename.lastIndexOf('.') + 1).toLowerCase();

    if (AIRPASS.exhibition.ext_img.indexOf(fileExt) < 0) {
      alert('[' + fileExt + '] 형식의 파일은 등록할 수 없습니다.');				
      return false;
    }

		for (var i=0; i<mArrayContsFile.length; i++) {
			if (mArrayContsFile[i] && mArrayContsFile[i].name == tmpFilename) {
				alert("동일한 콘텐츠 파일명이 있습니다.");				
				return false;
			}
		}

		return true;
	}
	

  // 전시상품 수 클릭
  function clickExhProductSet() {

    let productCnt = $('#exh_product_cnt').val();
    let tmpHtml = ''; 
    $('#exh_product_list').empty();
    let i = 1;
    for ( ; i <= productCnt; i++) {
      (i % 2) !== 0 ?  tmpHtml += '<tr>' : '';
      tmpHtml += 
        '<td class="_loc" prod-loc="'+i+'">' + i + '</td>' +
        '<td>' +
          '<select class="form-control exh" name="">' +
            '<option value="1" selected>2D콘텐츠-프레임에 사이즈 맞춤(모니터 등)</option>' +
            '<option value="2">2D콘텐츠-이미지에 사이즈 맞춤(벽면 등)</option>' +
            '<option value="3">3D 콘텐츠</option>' +
          '</select>' +
        '</td>';
      (i % 2) === 0 ?  tmpHtml += '</tr>' : '';
    }

    (i % 2) === 0 ?  tmpHtml += '</tr>' : '';

    $('#exh_product_list').append(tmpHtml);

  }
	
	// 저장버튼 클릭
	function clickBtnSave() { 

    let exh_name = $('#exh_name').val();
    exh_name = $.trim(exh_name);
    let exh_type = $('#exh_type').find('option:selected').val();
    let exh_product_cnt = $('#exh_product_cnt').val().replace(/\D/g, "");
    let useYN = $("#yes").is(":checked") ? 'Y' : 'N';

    let checkFileTp = true;
    for (let i = 0; i < mArrayContsFile.length; i++) {
      let fileName = mArrayContsFile[i].name;
      let fileExt = fileName.substr(fileName.lastIndexOf('.') + 1).toLowerCase();
      if(fileExt == 'glb') {checkFileTp = false; break; }
    }

    if (checkFileTp) {
		  alert("GLB 파일을 입력해주세요.");
		  return;
	  }

    if (exh_name.length == 0) {
		  alert("3D 전시관명을 입력해주세요.");
		  return;
	  }

    if (exh_product_cnt == '') {
		  alert("전시상품 수을 입력해주세요.");
		  return;
	  }

    let tmplProdList = new Array();
    let tmplContsInfo = new Object();
    $('#exh_product_list tr').each(function() {
      var row = $(this);
      if (row.children('td').length > 2) { 
        //exh_product_val_list.push($(this).find(".exh").eq(0).find('option:selected').val());
        //exh_product_val_list.push($(this).find(".exh").eq(1).find('option:selected').val());
        tmplContsInfo = new Object();
        tmplContsInfo.tmpl_prod_loc = $(this).find("._loc").eq(0).attr('prod-loc');
        tmplContsInfo.prod_tp = $(this).find(".exh").eq(0).find('option:selected').val();
        tmplProdList.push(tmplContsInfo);
        tmplContsInfo = new Object();
        tmplContsInfo.tmpl_prod_loc = $(this).find("._loc").eq(1).attr('prod-loc');
        tmplContsInfo.prod_tp = $(this).find(".exh").eq(1).find('option:selected').val();
        tmplProdList.push(tmplContsInfo);
      } else {
        tmplContsInfo = new Object();
        tmplContsInfo.tmpl_prod_loc = $(this).find("._loc").eq(0).attr('prod-loc');
        tmplContsInfo.prod_tp = $(this).find(".exh").eq(0).find('option:selected').val();
        tmplProdList.push(tmplContsInfo);
      }
    });

    // 콘텐츠 구분
    var file_tp = new Array();

    $('#tbody_file tr').each(function() {
      let value = $(this).find(".cont_type").eq(0).find('option:selected').val();
      if(value) file_tp.push(value);
    });


    var paramJson = new Object();
    paramJson.service_tp = "exh_tmpl_reg";
    paramJson.crud_tp = "c";
    paramJson.tmpl_name = exh_name;
    paramJson.tmpl_tp = exh_type;
    paramJson.tmplProdList = tmplProdList;
    paramJson.prod_cnt = exh_product_cnt;
    paramJson.use_yn = useYN;
    paramJson.user_uid = userUid;

    // Check File Type
    if (file_tp.indexOf('1') == -1) {
      alert("3D 전시관 파일을 선택 또는 드래그해주세요.");
      return;
    }
    if (file_tp.indexOf('2') == -1) {
      alert("대표 이미지 파일을 선택 또는 드래그해주세요.");
      return;
    }
    if (file_tp.indexOf('3') == -1) {
      alert("전시관 구조도 파일을 선택 또는 드래그해주세요.");
      return;
    }

	  // 전시이미지 파라미터 세팅
	  var arrayExhFile = new Array();
    let glbCnt = 0;
	  for (var i=0; i<mArrayContsFile.length; i++) {
		  if (!mArrayContsFile[i]) {
			  continue;
		  }
      let fileName = mArrayContsFile[i].name;
      let fileExt = fileName.substr(fileName.lastIndexOf('.') + 1).toLowerCase();
      if(fileExt == 'glb') glbCnt++;
      if ((fileExt == 'glb' && file_tp[i] != '1') || (fileExt != 'glb' && file_tp[i] == '1')) {
        alert("3D 전시관 파일은 GLB 포맷만 가능합니다. (Error: " + mArrayContsFile[i].name + ")");
        return;
      }
		  let objExhFile = new Object();
		  objExhFile.file_tp = file_tp[i];
		  objExhFile.file_name = fileName;
      objExhFile.file_size = mArrayContsFile[i].size;
		  arrayExhFile.push(objExhFile);
	  }
    if(glbCnt > 1) {
      alert("GLB 파일은 한 개 이상 입력할 수 없습니다.");
      return;
    }
	  paramJson.exh_tmpl_file = arrayExhFile;

    //console.log(paramJson);
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
        		location.href = "/exhibition/template/index.do";
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
        /*xhr: function() {
          myXhr = $.ajaxSettings.xhr();
          if(myXhr.upload){
              myXhr.upload.addEventListener('progress', showPercent, false);
          } else {
              console.log("Upload is not supported.");
          }
          return myXhr;
        }*/

	    });

  }


</script>
  <div id="wrapper">
    <%@ include file="../include/header.jsp" %>
      <div class="container-fluid" id="container-wrapper">
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
          <h1 class="h3 mb-0 text-gray-800">전시관 템플릿 등록</h1>
          <ol class="breadcrumb">
            <li class="breadcrumb-item">전시관 관리</li>
            <li class="breadcrumb-item active" aria-current="page">전시관 등록</li>
          </ol>
        </div>

        <div class="row">
          <div class="col-lg-12 mb-4">
            <div class="card layout-write">
              <!--<form name="" action="" method=""> -->
                <div class="section">
                  <h6>전시관 업로드</h6>
                  <div class="box-file">
                    <i class="fas fa-cloud-upload-alt"></i>
                    <p class="main">업로드할 파일을 <span class="text-primary">선택</span> 또는 <span class="text-primary">드래그</span>해주세요</p>
                    <input id="ex_file" type="file" class="form-control" enctype='multipart/form-data' multiple="">
                    <p class="sub">*<span class="text-primary">jpg, png, gif, glb</span> 파일을 선택해주세요 (최대 3개까지 업로드 가능)</p>
                  </div>
                  <div class="table-responsive">
                    <table class="table align-items-center table-flush text-center">
                      <tbody id="tbody_file" class="thead-light">
                        <tr>
                          <th>콘텐츠 구분</th>
                          <th>파일명</th>
                          <th>사이즈</th>
                          <th>업로드 일자</th>
                          <th>삭제</th>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>

                <div class="section box-input">
                  <h6>전시관 정보</h6>
                  <label class="field d-flex mb-3">
                    <p style="width:96px">전시관명</p>
                    <input id="exh_name" type="text" class="form-control">
                  </label>
                  <div class="row column-input">
                    <label class="field d-flex col-sm-6">
                      <p style="width:96px">전시관 종류</p>
                      <select class="form-control" id="exh_type">
                        <option value="1" selected>체험관</option>
                        <option value="2">박물관</option>
                      </select>
                    </label>
                    <label class="field d-flex col-sm-6">
                      <p>전시상품 수</p>
                      <input class="form-control" style="width:100px" type="text" id="exh_product_cnt" onkeypress="if(event.keyCode==13) {$('#btn_exh_product_click').trigger('click'); return false;}" />
                      <button id="btn_exh_product_click" class="btn btn-success ml-2" onclick="clickExhProductSet()">위치 설정</button>
                    </label>
                    <div style="margin-top:15px" class="field d-flex col-sm-6">
                      <p class="mr-4" style="font-size:18px">전시회 등록여부</p>
                      <div class="custom-control custom-radio mr-3">
                        <input type="radio" id="yes" name="use-yn" class="custom-control-input" checked>
                        <label class="custom-control-label" for="yes">가능</label>
                      </div>
                      <div class="custom-control custom-radio mr-3">
                        <input type="radio" id="no" name="use-yn" class="custom-control-input">
                        <label class="custom-control-label" for="no">불가능</label>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="section mb-0">
                  <h6>전시관 위치설정</h6>
                  <div class="table-responsive">
                    <table class="table table-vertical align-items-center table-flush text-center">
                      <colgroup>
                        <col width="120px">
                        <col>
                        <col width="120px">
                        <col>
                      </colgroup>
                      <thead class="thead-light">
                        <tr>
                          <th>위치 순번</th>
                          <th>전시 콘텐츠 설정</th>
                          <th>위치 순번</th>
                          <th>전시 콘텐츠 설정</th>
                        </tr>
                      </thead>
                      <tbody id="exh_product_list">
                        <!--<tr>
                          <td>1</td>
                          <td>
                            <select class="form-control" name="">
                              <option value="사진" selected>사진</option>
                              <option value="동영상">동영상</option>
                              <option value="3D 콘텐츠">3D 콘텐츠</option>
                            </select>
                          </td>
                        </tr>
                      -->
                      </tbody>
                    </table>
                  </div>
                </div>

                <div class="d-flex justify-content-end mt-5">
                  <button type="button" class="btn btn-lg btn-secondary mr-2" onclick="location.href='/exhibition/template/index.do'">목록</button>
                  <button type="submit" class="btn btn-lg btn-primary" onclick="clickBtnSave()">저장</button>
                </div>

              <!--</form> -->
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