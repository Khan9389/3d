<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ include file="../include/head.jsp" %>
<link href="/asia3d/vendor/bootstrap-datepicker/css/bootstrap-datepicker.min.css" rel="stylesheet" >

<style> 

  *, *:before, *:after {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  html, body {
    height: 100%;
  }

  body {
    font: 14px/1 'Open Sans', sans-serif;
    color: #555;
    background: #eee;
  }

  #tsum-tabs h1 {
    padding: 50px 0;
    font-weight: 400;
    text-align: center;
  }

  #tsum-tabs p {
    margin: 0 0 20px;
    line-height: 1.5;
  }

  #tsum-tabs main {
    min-width: 320px;
    max-width: 800px;
    padding: 0px;
    margin: 0 auto;
    background: #fff;
  }

  #tsum-tabs section {
    display: none;
    padding: 20px 0 0;
    border-top: 1px solid #ddd;
  }

  #tsum-tabs input {
    display: none;
  }

  #tsum-tabs label {
    display: inline-block;
    margin: 0 0 -1px;
    padding: 13px;
    font-weight: 600;
    text-align: center;
    color: #bbb;
    border: 1px solid transparent;
  }

  #tsum-tabs input:checked + label {
    color: #555;
    border: 1px solid #ddd;
    border-top: 2px solid #6777ef;
    border-bottom: 1px solid #fff;
  }

</style>

<script type="text/javascript"> 
  var userUid = window.USER_INFO.user_uid;
  <% String exh_uid = request.getParameter("exh_uid") == null ? "" : request.getParameter("exh_uid"); %>
  <% String page_num = request.getParameter("page_num"); %>
  var mPage = (<%=page_num%>) ? <%=page_num%> : 1;
  var mainContsLoc, apiDataTp;

  var api3DbankReq = {
    age_cd: "ALL",
    conts_major: "ALL",
    conts_minor: "ALL",
    conts_word: "",
    filter_orderby_tp: 1,
    filter_reg_tp: "",
    max_ret_count: "18",
    page_num: "1",
    pay_tp: null,
    service_tp: "conts_3d_model_list",
    token_uuid: ""
  };

  var reqParam = new Object();
  reqParam.service_tp = "conts_info_list";
  reqParam.max_ret_count = '18';
  reqParam.conts_word = '';
  reqParam.use_yn = 'Y';

  var oldExhFileName = new Array();
  var newExhFileList = new Array();
  var newMainContsList = new Array();
  var updateMainContsList = new Array();
  var delMainContsList = new Array();

  $(document).ready(function() {

    readExhibitionInfo();

    // 파일 추가 버튼
    $('#_exh-file').change(function() {
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


    $('label[for=_conts-tab1]').click(function() {

      $('#srchContsWord').val('');
      
      reqParam.conts_word = '';
      reqParam.page_num = '1';
      apiDataTp = 1;
      AIRPASS.pageInfo.rangePage = 1;
      AIRPASS.pageInfo.pageNum = 1;
      
      doCommunication(reqParam);
    });

    $('label[for=_conts-tab2]').click(function() {

      $('#srchContsWord').val('');
      $('#_tbody-conts-list').empty();

      api3DbankReq.conts_word = '';
      api3DbankReq.page_num = '1';
      AIRPASS.pageInfo.rangePage = 1;
      AIRPASS.pageInfo.pageNum = 1;
      
      doCommunicationWith3DBankApi(api3DbankReq);
    });

    $('body').on("click", ".paging a", function(){
      var pageId = $(this)[0].id;

      AIRPASS.pageInfo.rangePage = pageId.slice(4);//parseInt(pageId.slice(4));		
      AIRPASS.pageInfo.pageNum = parseInt(pageId.slice(4));
      api3DbankReq.page_num = AIRPASS.pageInfo.rangePage;
      reqParam.page_num = AIRPASS.pageInfo.rangePage;

      $('#_tbody-conts-list').empty();
      if(apiDataTp == '1'){
        doCommunication(reqParam);
      } else if('2'){
        doCommunicationWith3DBankApi(api3DbankReq);
      }

      //$(window).scrollTop(0);
    });


  });


  function doCommunicationWith3DBankApi(api3DbankReq) {
    apiDataTp = 2;

    $.ajax({
      type : "POST",  
      url : "//m.3dbank.xyz/Ajax3DWorldController.do",
      data : { jsondata : JSON.stringify(api3DbankReq) },
      success : function(result) {
        AIRPASS.foreignApiData = result;
        setContsInfo();
      }    
      /*beforeSend:function() {
        $('#_modal03-progress').show();
      },
      complete:function(){
        $('#_modal03-progress').hide();
      }*/
    });
  }


  // 이미지파일삭제 버튼 클릭
  function clickDeleteFile(e) {
    e.stopImmediatePropagation();
    const obj = e.currentTarget;

    const tmpIdx = $('#_tbody-file ._fl-row').index($(obj).closest('._fl-row'));
    $("#_tbody-file > ._fl-row:eq(" + tmpIdx + ")").remove();

    if (tmpIdx < oldExhFileName.length) {
      oldExhFileName.splice(tmpIdx, 1);
    } else {
      newExhFileList.splice(tmpIdx - oldExhFileName.length, 1);
    }

  }


  //파일명 중복체크
  function checkFilename(tmpFilename) {
    
    const fileExt = tmpFilename.substr(tmpFilename.lastIndexOf('.') + 1).toLowerCase();

    if (AIRPASS.mainExh.ext_img.indexOf(fileExt) < 0) {
      alert('[' + fileExt + '] 형식의 파일은 등록할 수 없습니다.');				
      return false;
    }

    for (let i=0; i < newExhFileList.length; i++) {
      if (newExhFileList[i] && newExhFileList[i].name == tmpFilename) {
        alert("동일한 콘텐츠 파일명이 있습니다.");				
        return false;
      }
    }

    return true;
  }


  // 전시회 이미지파일 멀티등록을 위한 FileReader 생성 함수
  function readFile(files, idx) {
    let file = files[idx];
    let size = file.size;
    let fileName = file.name;

    if (!checkFilename(fileName))
      return;

    let reader = new FileReader();
    reader.readAsDataURL(file);

    reader.onload = function(e) {

      if (newExhFileList.length + oldExhFileName.length >= 30) {
        alert("최대 30개 까지 등록할 수 있습니다.");
        return;
      }

      newExhFileList.push(file);
      let i = Math.floor(Math.random() * 1000000000); 
      let $tmpHtml = $(
        '<tr class="_fl-row">' +
          '<td>' +
            '<div class="custom-control custom-radio _rdBtn">' +
              '<input type="radio" id="thumb'+ i +'" name="thumb" class="custom-control-input">' +
              '<label class="custom-control-label" for="thumb'+i+'"></label>' +
            '</div>' +
          '</td>' +
          '<td>' +
            '<img class="_thumb-img" src="'+ e.target.result +'" alt="사진이 없습니다.">' +
          '</td>' +
          '<td>'+ fileName +'</td>' +
          '<td>Just Now!</td>' +
          '<td>' +
            '<button class="btn btn-danger btn-sm _delFl">' +
              '<i class="fas fa-trash"></i>' +
            '</button>' +
          '</td>' +
        '</tr>'
      );

      $tmpHtml.find('._delFl').on('click', clickDeleteFile);

      $('#_tbody-file').append($tmpHtml);

      $tmpHtml.find('._thumb-img').lazyload({
        effect: "fadeIn",
      });

      /*$tmpHtml.find('._rdBtn').on('click', function(){
        $(this).find('input:radio[name=thumb]').prop('checked', true);
      });*/

    }

  }


  // 전시회 정보 세팅
  function setExhibitionInfo() {
    let exhInfo = AIRPASS.exhInfo;
    let thumbImgName = exhInfo.tmpl_thumb_name;
    let imgUrl = '/exhibition/downThumbImg.do?tmpl_uid='+ exhInfo.exh_tmpl_uid +'&file='+ thumbImgName +'&dir=tmpl';
    
    $('#_tmpl-name').val(exhInfo.tmpl_name);
    $('#_tmpl-name').attr('tmpl-uid', exhInfo.exh_tmpl_uid);
    $('#_tmpl-tp').text(exhInfo.tmpl_tp == '1' ? '체험관' : '박물관');
    $('#_exh-name').val(exhInfo.exh_name);
    $('#_tmpl-conts-cnt').text(exhInfo.conts_cnt);
    $('#_start-date').val(exhInfo.exh_start_period);
    $('#_end-date').val(exhInfo.exh_end_period);
    $('#_exh-desc').val(exhInfo.exh_desc);
    if(thumbImgName) $('#_tmpl-structure').attr('src', imgUrl); 

  }


  // 파일 정보 세팅
  function setExhFileInfo() {
    let exhThumbFileSeq = AIRPASS.exhInfo.exh_thumb_file_seq;
    let exhFileList = AIRPASS.exhInfo.exh_file;
    if(!exhFileList) return;

    for (let i = 0; i < exhFileList.length; i++) {
      let file = exhFileList[i];
      oldExhFileName.push(file.exh_save_name);

      let j = Math.floor(Math.random() * 1000000000);
      let $tmpHtml = $(
        '<tr class="_fl-row">' +
          '<td>' +
            '<div class="custom-control custom-radio _rdBtn">' +
              '<input type="radio" file-seq="'+ file.exh_file_seq +'" id="thumb'+j+'" name="thumb" class="custom-control-input">' +
              '<label class="custom-control-label" for="thumb'+j+'"></label>' +
            '</div>' +
          '</td>' +
          '<td>' +
            '<img class="_thumb-img" src="/exhibition/downThumbImg.do?exh_uid='+ file.exh_uid +'&file=' + file.exh_save_name + '&dir=exh' +'" alt="사진이 없습니다.">' +
          '</td>' +
          '<td>'+ file.exh_file_name +'</td>' +
          '<td>'+ file.upt_dttm +'</td>' +
          '<td>' +
            '<button class="btn btn-danger btn-sm _delFl">' +
              '<i class="fas fa-trash"></i>' +
            '</button>' +
          '</td>' +
        '</tr>'
      );

      $tmpHtml.find('._delFl').on('click', clickDeleteFile);

      $('#_tbody-file').append($tmpHtml);

      $tmpHtml.find('._thumb-img').lazyload({
        effect: "fadeIn",
      });

      if (exhThumbFileSeq == file.exh_file_seq) {
        $tmpHtml.find('div > input:radio[name=thumb]').prop('checked', true);
      }

      /*$tmpHtml.find('._rdBtn').on('click', function(){
        $(this).find('input:radio[name=thumb]').prop('checked', true);
      });*/

    }
  }


  function selectConts(obj) {
    const sel = $(obj).attr('main-conts-loc');
    const contsUid = $(obj).attr('conts-uid');
    const contsName = $(obj).attr('conts-name');
    const rootTp = $(obj).attr('root-tp');
    $('#_tbody-conts').find('#name'+sel).html(contsName);
    const checkUid = $('#_tbody-conts').find('#name'+sel).attr('conts-uid');
    if(checkUid) {
      $('#_tbody-conts').find('#name'+sel).attr('old-uid', checkUid);
    }
    $('#_tbody-conts').find('#name'+sel).attr('conts-uid', contsUid);
    $('#_tbody-conts').find('#name'+sel).attr('root-tp', rootTp);
    $('#modal03').modal('hide');
  }


  function setContsInfo() {
    let contsList;
    const sel = mainContsLoc;
    let imgUrl = '';
    let conts_tp = '';

    if(apiDataTp == '1') {
      if (AIRPASS.contsList == undefined) return;
      contsList = AIRPASS.contsList.conts_list;
      AIRPASS.pageInfo.totalCount = AIRPASS.contsList.total_count;
    } else if(apiDataTp == '2') {
      if (AIRPASS.foreignApiData.contents3dmodel_list == undefined) return;
      contsList = AIRPASS.foreignApiData.contents3dmodel_list;
      AIRPASS.pageInfo.totalCount = AIRPASS.foreignApiData.total_count;
    }

    $('#_tbody-conts-list').empty();
    let idx = (AIRPASS.pageInfo.pageNum-1)*18+1;

    for (let i=0; i < contsList.length; i++, idx++) {
      let contsInfo = contsList[i];

      if(apiDataTp == '1') conts_tp = contsInfo.conts_tp == 1 ? '사진' : contsInfo.conts_tp == 2 ? '동영상' : "3D 콘텐츠";
      else conts_tp = "3D 콘텐츠";

      imgUrl = apiDataTp == '1' ? '/exhibition/downThumbImg.do?conts_uid='+ contsInfo.conts_uid +'&file='+ contsInfo.conts_save_name : contsInfo.thumnail;

      let tmpHtml = 
        '<tr root-tp="'+apiDataTp+'" conts-name="'+ contsInfo.conts_name +'" main-conts-loc="'+ sel +'" conts-uid="'+ contsInfo.conts_uid +'" onclick="selectConts(this)">' +
          '<td>'+ idx +'</td>' +
          '<td>'+ conts_tp +'</td>' +
          '<td>'+ contsInfo.conts_name +'</td>' +
          '<td><img class="_thumbImg" src="'+ imgUrl +'"></td>' +
        '</tr>';

      $('#_tbody-conts-list').append(tmpHtml);
      $('#_tbody-conts-list').find('._thumbImg').lazyload({
        effect: "fadeIn",
      });
    }

    pagination(AIRPASS.pageInfo);
  }


  function readTmplInfo(tmplUid) {
    let paramJson = new Object();
    paramJson.service_tp = "exh_tmpl_reg";
    paramJson.crud_tp = "r";
    paramJson.exh_tmpl_uid = tmplUid;
    doCommunication(paramJson);
  }

  function setTmplInfo(obj) {
    let tmplUid = $(obj).attr('tmpl-idx');
    $('#_tmpl-name').attr('tmpl-uid', tmplUid);
    readTmplInfo(tmplUid);
    $('#modal01').modal('hide');
  }


  // tmpl 리스트 세팅
  function setTmplList() {
    if (AIRPASS.tmplList.exh_tmpl_list == undefined) return;

    $('#_tbody-tmpl-list').empty();

    for (let i=0; i < AIRPASS.tmplList.exh_tmpl_list.length; i++) {
      let tmplInfo = AIRPASS.tmplList.exh_tmpl_list[i];
      let tmpl_tp = (tmplInfo.tmpl_tp == "1") ? "체험관" : "박물관";

      let tmpHtml =
        "<tr tmpl-idx='" + tmplInfo.exh_tmpl_uid + "' onclick='setTmplInfo(this)'>" +
          "<td>" + parseInt((mPage-1) * 18 + (i+1)) + "</td>" +
          "<td>" + tmplInfo.tmpl_name + "</td>" +
          "<td>"+ tmpl_tp +"</td>" +
          "<td>" + tmplInfo.prod_cnt + "</td>" +
        "</tr>";

      $('#_tbody-tmpl-list').append(tmpHtml);
    }
    //setPaging(mPage, mListInfo.total_cnt);
  }


  function setExhStructureImg() {
    let save_name = '';
    const tmplFileList = AIRPASS.tmplInfo.list_tmpl_file;
    for (let i=0; i < tmplFileList.length; i++) {
      fileInfo = tmplFileList[i];
      if (fileInfo.file_tp == 3) {
        save_name = fileInfo.save_name;
        break;
      }
    }
    if (save_name != '') {
      let imgUrl = '/exhibition/downThumbImg.do?tmpl_uid='+ AIRPASS.tmplInfo.exh_tmpl_uid +'&file='+ save_name +'&dir=tmpl';
      $('#_tmpl-structure').attr('src', imgUrl); 
    } else {
      $('#_tmpl-structure').attr('src', '');
      $('#_tmpl-structure').attr('alt', '전시관 구조 사진이 없습니다!');
    }
  }


  function setExhConts() {
    let exhContsList = AIRPASS.tmplInfo.list_tmpl_prod;
    if(!exhContsList) return;
    $('#_tbody-conts').empty();
    //alert('in 343');
    let tmpHtml = '';
    let conts_tp = '';
    let j = 1;
    for (let i=0; i < exhContsList.length; i++) {
      const exhContInfo = exhContsList[i];
      conts_tp = exhContInfo.prod_tp == 1 ? '2D콘텐츠-프레임에 사이즈 맞춤(모니터 등)' : exhContInfo.prod_tp == 2 ? '2D콘텐츠-이미지에 사이즈 맞춤(벽면 등)' : "3D 콘텐츠";
      (j % 2) !== 0 ?  tmpHtml += '<tr>' : '';
      tmpHtml += 
        '<td class="_loc">'+ exhContInfo.prod_loc +'</td>' +
        '<td class="_contsTp" id="tp'+ exhContInfo.exh_tmpl_prod_uid +'" cont-tp="'+ exhContInfo.prod_tp +'">'+ conts_tp +'</td>' +
        '<td class="_conts-info" tmpl-st="new" id="nametp'+ exhContInfo.exh_tmpl_prod_uid +
          '" conts-uid="" root-tp="" data-loc="'+ exhContInfo.prod_loc +'" update-tp="" old-uid="" conts-tp="'+ exhContInfo.prod_tp +'"></td>' +
        '<td class="text-center">' +
          '<button data-tp="tp'+exhContInfo.exh_tmpl_prod_uid+'" type="button" data-toggle="modal" data-target="#modal03" class="btn btn-outline-success" onclick="readContsList(this)">선택</button>' +
        '</td>';
      (j % 2) === 0 ?  tmpHtml += '</tr>' : '';
      j++;
    }

    (j % 2) === 0 ?  tmpHtml += '</tr>' : '';
    $('#_tbody-conts').append(tmpHtml);

    setExhStructureImg();
  }

  function setTmplInfoTag() {
    let tmplInfo = AIRPASS.tmplInfo;
    let tmpl_tp = (tmplInfo.tmpl_tp == "1") ? "체험관" : "박물관";
    $('#_tmpl-name').val(tmplInfo.tmpl_name);
    $('#_tmpl-tp').html(tmpl_tp);
    $('#_tmpl-conts-cnt').html(tmplInfo.prod_cnt);
    setExhConts();
  }


  function doCommunication(jsonParam) {
    apiDataTp = 1;
    if (jsonParam.sel != undefined) mainContsLoc = jsonParam.sel;

    let jsondata = "jsondata=" + JSON.stringify(jsonParam);
    let tmpUrl = jsonParam.service_tp == "exh_tmpl_reg" ? "/exhibition/AjaxAirpassMultipartController.do" : "/exhibition/AjaxAirpassController.do";

    $.ajax({
      type : "POST",  
      url : tmpUrl,
      data : jsondata,
      success : function(result) {
        printLog("response data", JSON.stringify(result));       
        if (result.retcode == "000" && result.service_tp == "exh_tmpl_list") {
          AIRPASS.tmplList = result;
          setTmplList();
        } else if(result.retcode == "000" && result.service_tp == "exh_tmpl_reg") {
          AIRPASS.tmplInfo = result;
          setTmplInfoTag();
        } else if(result.retcode == "000" && result.service_tp == "conts_info_list") {
          AIRPASS.contsList = result;
          setContsInfo();
        }else {
          alert(result.retmsg);
          if(result.service_tp == "conts_info_list") {
            $('#_tbody-conts-list').empty();
          }
        }
      }
    });
  }


  function readContsList(obj){
    let index = $(obj).attr('data-tp');
    let tp = $('#_tbody-conts').find('#'+index+'').attr('cont-tp');

    if(tp == '3'){
      $('#_conts-tab1').prop('checked', true);
      $('#_conts-tab2').css('display','');
      $('label[for=_conts-tab2]').css('display','');
    } else {
      $('#_conts-tab1').prop('checked', true);
      $('#_conts-tab2').css('display','none');
      $('label[for=_conts-tab2]').css('display','none');
    }
    
    reqParam.page_num = '1';
    reqParam.conts_tp = tp;
    reqParam.sel = index;
    AIRPASS.pageInfo.rangePage = 1;
    AIRPASS.pageInfo.pageNum = 1;

    doCommunication(reqParam);
  }


  function setExhContsInfo() {
    let contsList = AIRPASS.exhInfo.tmpl_conts_list;
    let mainContsList = AIRPASS.exhInfo.exh_conts;
    if(!contsList) return;
    //alert('in 433');
    let tmpHtml = ''; 
    let contsTp = '';
    let contsName = '';
    let contsUid = '';
    let mainContsUid = '';
    let updateTp = '';
    let rootTp = '';
    let i = 1;
    for (let j=0; i <= contsList.length; i++, j++) {
      contsTp = contsList[j].prod_tp == 1 ? '2D콘텐츠-프레임에 사이즈 맞춤(모니터 등)' : contsList[j].prod_tp == 2 ? '2D콘텐츠-이미지에 사이즈 맞춤(벽면 등)' : '3D 콘텐츠';

      contsName = '';
      contsUid = '';
      mainContsUid = '';
      updateTp = 'new'
      rootTp = '';
      for (let idx=0; idx < mainContsList.length; idx++) {
        if(contsList[j].prod_loc == mainContsList[idx].main_conts_loc) {
          contsName = mainContsList[idx].main_conts_name;
          contsUid = mainContsList[idx].conts_uid;
          mainContsUid = mainContsList[idx].main_conts_uid;
          rootTp = mainContsList[idx].root_tp;
          updateTp = 'old';
          break;
        }        
      }

      (i % 2) !== 0 ?  tmpHtml += '<tr>' : '';
      tmpHtml += 
        '<td>'+ contsList[j].prod_loc +'</td>' +
        '<td class="_conts-tp" id="tp'+ contsList[j].exh_tmpl_prod_uid +'" cont-tp="'+ contsList[j].prod_tp +'">'+ contsTp +'</td>' +
        '<td class="_conts-info" tmpl-st="" id="nametp'+ contsList[j].exh_tmpl_prod_uid +
        '" conts-uid="'+ contsUid +'" main-conts-uid="'+ mainContsUid +'" root-tp="'+ rootTp +'" update-tp="'+ updateTp +'" old-uid="" data-loc="'+ contsList[j].prod_loc +'" conts-tp="'+ contsList[j].prod_tp +'">'+ contsName +'</td>' +
        '<td class="text-center">' +
          '<button data-tp="tp'+ contsList[j].exh_tmpl_prod_uid +'" type="button" data-toggle="modal" data-target="#modal03" class="btn btn-outline-success" onclick="readContsList(this)">선택</button>' +
        '</td>';
      (i % 2) === 0 ?  tmpHtml += '</tr>' : '';
    }

    (i % 2) === 0 ?  tmpHtml += '</tr>' : '';

    $('#_tbody-conts').append(tmpHtml);
  }


  function doMultipart(tmpJson) {
    console.log("ajax send (CrudTP, newExhFileList.length, tmpJson)", tmpJson.crud_tp, newExhFileList.length ? newExhFileList : [], tmpJson);

    let formData = new FormData();

    for (let i = 0; i < newExhFileList.length; i++) {
      let file = newExhFileList[i];
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
                location.href = "/exhibition/exhibition/index.do";
              } else if (tmpJson.crud_tp == "r") {
                AIRPASS.exhInfo = result;
                mCrudTp = "u";
                setExhibitionInfo();
                setExhFileInfo();
                setExhContsInfo();
              } else if(tmpJson.crud_tp == 'd') {
                alert('정상적으로 삭제 되었습니다.');
                location.href = "/exhibition/exhibition/index.do";
              }
            } else {
              alert(result.retmsg);
              location.href = "/exhibition/exhibition/index.do";
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

  function readExhibitionInfo() {
    let jsonParam = new Object();
    jsonParam.service_tp = "exh_info_reg";
    jsonParam.crud_tp = 'r';
    jsonParam.exh_uid = '<%=exh_uid%>';
    jsonParam.user_uid = userUid;

    if (jsonParam.exh_uid) {
      doMultipart(jsonParam);
    } else {
      alert("전시회 uid가 없습니다.");
    }
  }

  function readTmpl() {
    let jsonParam = new Object();
    jsonParam.service_tp = "exh_tmpl_list";
    jsonParam.use_yn = 'Y';
    jsonParam.page_num = "" + mPage;

    doCommunication(jsonParam);
  }


  function clickBtnSave(exhTp) { 

    const tmplName = $('#_tmpl-name').val();
    const exhName = $('#_exh-name').val();
    const startDate = $('#_start-date').val();
    const endDate = $('#_end-date').val();


    if (tmplName.length == 0) {
      alert("전시관명을 선택해주세요.");
      return;
    }

    if (exhName.length == 0) {
      alert("전시회명을 입력해주세요.");
      return;
    }

    if (startDate.length == 0 || endDate.length == 0) {
      alert("전시기간을 선택해주세요.");
      return;
    }


    let checkName = false;
    let main_conts_name = '';
    let updateTp = '';
    let oldUid = '';
    let deleteContsTp = false;
    $('#_tbody-conts ._conts-info').each(function() { 
      main_conts_name = $(this).html();
      updateTp = $(this).attr('update-tp');
      oldUid = $(this).attr('old-uid');
      tmplSt = $(this).attr('tmpl-st');

      if(tmplSt == 'new') {
        deleteContsTp = true;
      }
      
      if (main_conts_name.length != 0 && (updateTp == 'new' || tmplSt == 'new')) {

        let objMainContsInfo = new Object();
        objMainContsInfo.main_conts_loc = $(this).attr('data-loc');
        objMainContsInfo.main_conts_tp = $(this).attr('conts-tp');
        objMainContsInfo.main_conts_name = main_conts_name;
        objMainContsInfo.conts_uid = $(this).attr('conts-uid');
        objMainContsInfo.root_tp = $(this).attr('root-tp');
        newMainContsList.push(objMainContsInfo);

      } else if(main_conts_name.length != 0 && updateTp == 'old' && oldUid) {

        let objMainConts = new Object();
        objMainConts.main_conts_loc = $(this).attr('data-loc');
        objMainConts.main_conts_tp = $(this).attr('conts-tp');
        objMainConts.main_conts_name = main_conts_name;
        objMainConts.conts_uid = $(this).attr('conts-uid');
        objMainConts.root_tp = $(this).attr('root-tp');
        objMainConts.main_conts_uid = $(this).attr('main-conts-uid');
        updateMainContsList.push(objMainConts);

      }

      if(main_conts_name.length != 0) checkName = true;
    });

    if(deleteContsTp) {
      const mainConts = AIRPASS.exhInfo.exh_conts;
      for (let i = 0; i < mainConts.length; i++) {
        const mainContsInfo = mainConts[i];
        delMainContsList.push(mainContsInfo.main_conts_uid);
      }
    }

    if (!checkName) {
      alert("전시회 상품 등록을 선택해주세요.");
      return;
    }

    let exhThumbFileSeq = AIRPASS.exhInfo.exh_thumb_file_seq ? AIRPASS.exhInfo.exh_thumb_file_seq : 0;
    let paramJson = new Object();
    paramJson.exh_uid = AIRPASS.exhInfo.exh_uid;
    paramJson.use_yn = exhTp == '1' ? 'Y' : 'N';
    paramJson.service_tp = "exh_info_reg";
    paramJson.crud_tp = "u";
    paramJson.exh_tmpl_uid = $('#_tmpl-name').attr('tmpl-uid');
    paramJson.exh_name = exhName;
    paramJson.exh_thumb_file_seq = exhThumbFileSeq;
    paramJson.exh_start_period = startDate;
    paramJson.exh_end_period = endDate;
    paramJson.exh_desc = $('#_exh-desc').val();
    paramJson.newMainConts = newMainContsList;
    paramJson.updateMainConts = updateMainContsList;
    paramJson.delMainConts = delMainContsList;

    let $fileSeq = $('#_tbody-file ._fl-row input:radio[name=thumb]:checked').attr('file-seq');
    if($fileSeq && $fileSeq != paramJson.exh_thumb_file_seq) paramJson.exh_thumb_file_seq = $fileSeq;

    // thumb 인덱스
    let $radioButtons = $('#_tbody-file ._fl-row input:radio[name=thumb]');
    let selectedThumbIndex = $radioButtons.index($("input:radio[name=thumb]:checked"));

    if (selectedThumbIndex == -1) {
      alert("썸네일 이미지를 클릭해주세요.");
      return;
    }

    selectedThumbIndex -= oldExhFileName.length;
    // 전시회 이미지 파라미터 세팅
    let arrExhFileInfo = new Array();
    for (var i=0; i < newExhFileList.length; i++) {
      if (!newExhFileList[i]) {
        continue;
      }
      let objExhFile = new Object();
      objExhFile.file_name = newExhFileList[i].name;
      objExhFile.file_size = newExhFileList[i].size;
      objExhFile.isThumb = (i == selectedThumbIndex);
      arrExhFileInfo.push(objExhFile);
    }
    paramJson.newExhFileList = arrExhFileInfo;

    
    let arrInsName = new Array();
    let arrDelName = new Array();
    for (let i=0; i < newExhFileList.length; i++) {
      arrInsName.push(newExhFileList[i].name);
    }

    let fileList = AIRPASS.exhInfo.exh_file;
    let tmpFilesList = new Array();
    for (let i=0; i < fileList.length; i++) {
      if (fileList[i] && fileList[i].exh_save_name)
        tmpFilesList.push(fileList[i].exh_save_name);
    }
    for (let i=0; i < tmpFilesList.length; i++) {
      if (tmpFilesList[i] && oldExhFileName.indexOf(tmpFilesList[i]) == -1)
        arrDelName.push(tmpFilesList[i]);
    }

    if ((arrInsName.length + oldExhFileName.length) == 0) {
      alert("업로드할 파일을 선택 또는 드래그해주세요.");
      return;
    }

    paramJson.arrayInsName = arrInsName;
    paramJson.arrayDelName = arrDelName;

    //console.log('paramJson ==> ', paramJson);
    doMultipart(paramJson);

  }


  function clickBtnDelete() {
    let jsonParam = new Object();
    jsonParam.service_tp = "exh_info_reg";
    jsonParam.crud_tp = 'd';
    jsonParam.exh_uid = '<%=exh_uid%>';
    jsonParam.del_yn = 'Y';
    if (jsonParam.exh_uid) {
      doMultipart(jsonParam);
    } else {
      alert("전시회 uid가 없습니다.");
    }
  }


  function clickSrchContsWordBtn() {
    let srchWord = $('#srchContsWord').val();
    AIRPASS.pageInfo.pageNum = '1';
    AIRPASS.pageInfo.rangePage = 1;

    if(apiDataTp == '1') {
      reqParam.page_num = '1';
      reqParam.conts_word = srchWord;
      doCommunication(reqParam);
    } else if (apiDataTp == '2') {
      api3DbankReq.page_num = '1';
      api3DbankReq.conts_word = srchWord;
      doCommunicationWith3DBankApi(api3DbankReq);
    }
  }

</script>

<body id="page-top">
  <div id="wrapper">
    <%@ include file="../include/header.jsp" %>
      <div class="container-fluid" id="container-wrapper">
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
          <h1 class="h3 mb-0 text-gray-800">전시회 수정</h1>
          <ol class="breadcrumb">
            <li class="breadcrumb-item">3D전시회 관리</li>
            <li class="breadcrumb-item"><a href="/exhibition/exhibition/index.do">전시회 목록</a></li>
            <li class="breadcrumb-item active" aria-current="page">전시회 수정</li>
          </ol>
        </div>

        <div class="row">
          <div class="col-lg-12 mb-4">
            <div class="card layout-write">
              <form name="" action="" method="">
                <div class="section">
                  <h6>기본 정보</h6>
                  <div class="table-responsive">
                    <table class="table table-vertical align-items-center">
                      <colgroup>
                        <col width="110px">
                        <col>
                        <col width="140px">
                      </colgroup>
                      <tbody class="thead-light">
                        <tr>
                          <th>전시관</th>
                          <td>
                            <div class="d-flex">
                              <input id="_tmpl-name" tmpl-uid="" type="text" class="form-control" style="width:auto" readonly>
                              <button type="button" class="btn btn-outline-light ml-3" data-toggle="modal" data-target="#modal01" onclick="readTmpl()">선택</button>
                            </div>
                          </td>
                          <th>전시관 종류</th>
                          <td id="_tmpl-tp"></td>
                        </tr>
                        <tr>
                          <th>전시회명</th>
                          <td><input id="_exh-name" type="text" class="form-control"></td>
                          <th>전시상품</th>
                          <td id="_tmpl-conts-cnt"></td>
                        </tr>
                        <tr>
                          <th>전시기간</th>
                          <td colspan="3" class="date-group">
                            <div class="d-flex align-items-center">
                              <div class="input-group date" id="simple-date1">
                                <div class="input-group-prepend">
                                  <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                </div>
                                <input id="_start-date" type="text" class="form-control" value="">
                              </div>
                              <p>~</p>
                              <div class="input-group date" id="simple-date2">
                                <div class="input-group-prepend">
                                  <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                </div>
                                <input id="_end-date" type="text" class="form-control" value="">
                              </div>
                            </div>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>

                <div class="section">
                  <h6>전시관 이미지</h6>
                  <div class="box-file">
                    <i class="fas fa-cloud-upload-alt"></i>
                    <p class="main">업로드할 파일을 <span class="text-primary">선택</span> 또는 <span class="text-primary">드래그</span>해주세요</p>
                    <input id="_exh-file" type="file" class="form-control" name="file" accept="image/*" enctype='multipart/form_data' multiple>
                    <p class="sub">*<span class="text-primary">jpg, png</span> 파일을 선택해주세요 (최대 30개까지 업로드 가능)</p>
                  </div>

                  <div class="table-responsive">
                    <table class="table align-items-center table-flush text-center">
                      <colgroup>
                        <col width="120px">
                        <col width="150px">
                        <col>
                        <col width="150px">
                        <col width="100px">
                      </colgroup>
                      <thead class="thead-light">
                        <tr>
                          <th>대표구분</th>
                          <th>이미지</th>
                          <th>파일명</th>
                          <th>업로드 날짜</th>
                          <th>삭제</th>
                        </tr>
                      </thead>
                      <tbody id="_tbody-file">
                        <!--<tr>
                          <td>
                            <div class="custom-control custom-radio">
                              <input type="radio" id="thumb1" name="thumb" class="custom-control-input">
                              <label class="custom-control-label" for="thumb1"></label>
                            </div>
                          </td>
                          <td>
                            <img src="/asia3d/img/data/product/1/img_01.jpg" alt="">
                          </td>
                          <td>전시관대표이미지.jpg</td>
                          <td>2021-10-10</td>
                          <td>
                            <button class="btn btn-danger btn-sm">
                              <i class="fas fa-trash"></i>
                            </button>
                          </td>
                        </tr> -->
                      </tbody>
                    </table>
                  </div>
                </div>

                <div class="section">
                  <h6>전시회 설명</h6>
                  <textarea id="_exh-desc" class="form-control" rows="10">
                  </textarea>
                  <button type="button" class="btn btn-outline-primary mt-4" data-toggle="modal" data-target="#modal02">전시관구조 보기</button>
                </div>

                <div class="section">
                  <h6>전시회 상품 등록</h6>
                  <div class="table-responsive">
                    <table class="table align-items-center table-vertical table-flush">
                      <colgroup>
                        <col width="80px">
                        <col width="140px">
                        <col width="200px">
                        <col width="110px">
                        <col width="80px">
                        <col width="140px">
                        <col width="200px">
                        <col width="110px">
                      </colgroup>
                      <thead class="thead-light">
                        <tr>
                          <th>위치</th>
                          <th>콘텐츠종류</th>
                          <th>콘텐츠 명</th>
                          <th></th>
                          <th>위치</th>
                          <th>콘텐츠종류</th>
                          <th>콘텐츠 명</th>
                          <th></th>
                        </tr>
                      </thead>
                      <tbody id="_tbody-conts">
                        <!--<tr>
                          <td>1</td>
                          <td>동영상</td>
                          <td></td>
                          <td class="text-center">
                            <button type="button" data-toggle="modal" data-target="#modal03" class="btn btn-outline-success">선택</button>
                          </td>
                          <td>2</td>
                          <td>동영상</td>
                          <td></td>
                          <td class="text-center">
                            <button type="button" data-toggle="modal" data-target="#modal03" class="btn btn-outline-success">선택</button>
                          </td>
                        </tr>-->                        
                      </tbody>
                    </table>
                  </div>
                </div>

                <div class="d-flex justify-content-end mt-5">
                  <button type="button" class="btn btn-lg btn-secondary mr-2" onclick="clickBtnDelete()">삭제</button>
                  <button type="button" class="btn btn-lg btn-secondary mr-2" onclick="clickBtnSave('2')">비공개</button>
                  <button type="button" class="btn btn-lg btn-primary" onclick="clickBtnSave('1')">공개</button>
                </div>

              </form>
            </div>
          </div>
        </div>
      </div>
    </div> <!-- div#content end -->
<%@ include file="../include/footer.jsp" %>

<!-- 전시관 목록 팝업 -->
<div class="modal fade" id="modal01" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" 
    role="document" style="max-width:700px">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">전시관 템플릿 목록</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="d-flex justify-content-end">
          <div class="input-group bar-search" style="max-width:300px;">
            <input type="text" class="form-control bg-light border-1 small" placeholder="검색어를 입력하세요" aria-label="Search" aria-describedby="basic-addon2" style="border-color: #3f51b5;">
            <div class="input-group-append">
              <button class="btn btn-primary" type="button">
                <i class="fas fa-search fa-sm"></i>
              </button>
            </div>
          </div>
        </div>
        <table class="table align-items-center table-flush table-hover mt-3">
          <thead class="thead-light">
            <tr>
              <th>No</th>
              <th>템플릿 전시관명</th>
              <th>전시관 종류</th>
              <th>최대 상품 수</th>
            </tr>
          </thead>
          <tbody id="_tbody-tmpl-list">
            <!--<tr>
              <td>1</td>
              <td>에어패스 체험관</td>
              <td>체험관</td>
              <td>10</td>
            </tr>-->
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<!-- 전시관구조 보기 팝업 -->
<div class="modal fade" id="modal02" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-img" 
    role="document" style="max-width:700px">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">전시관 구조</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <img id="_tmpl-structure" src="" alt="사진이 없습니다.">
      </div>
    </div>
  </div>
</div>

<!-- 콘텐츠 목록 팝업 -->
<div class="modal fade" id="modal03" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" 
    role="document" style="max-width:700px">
    <div class="modal-content">
      <div class="modal-header" style="padding-bottom: 0;">
        <div id="tsum-tabs">  
          <main>
            <input id="_conts-tab1" type="radio" name="tabs" checked>
            <label for="_conts-tab1">Exhibition 3D콘텐츠</label>
    
            <input id="_conts-tab2" type="radio" name="tabs" style="display:none">
            <label style="display:none" for="_conts-tab2">3DBank 3D콘텐츠</label>
          </main>
        </div>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="d-flex justify-content-end">
          <div class="input-group bar-search" style="max-width:300px;">
            <input id="srchContsWord" type="text" class="form-control bg-light border-1 small" placeholder="검색어를 입력하세요" 
            aria-label="Search" aria-describedby="basic-addon2" style="border-color: #3f51b5;" onkeypress="if(event.keyCode==13) {$('#btnSrchWord').trigger('click'); return false;}">
            <div class="input-group-append">
              <button id="btnSrchWord" class="btn btn-primary" type="button" onclick="clickSrchContsWordBtn()">
                <i class="fas fa-search fa-sm"></i>
              </button>
            </div>
          </div>
        </div>
        <table class="table align-items-center table-flush table-hover mt-3 text-center">
          <colgroup>
            <col width="50px">
            <col width="130px">
            <col>
            <col width="120px">
          </colgroup>
          <thead class="thead-light">
            <tr>
              <th>No</th>
              <th>콘텐츠 종류</th>
              <th>콘텐츠 명</th>
              <th>사진</th>
            </tr>
          </thead>
          <tbody id="_tbody-conts-list">
            <!--<tr>
              <td>1</td>
              <td>동영상</td>
              <td>XR 스포츠 체험</td>
              <td><img src="/asia3d/img/data/product/1/01_01/img_01.jpg" alt=""></td>
            </tr>-->
          </tbody>
        </table>
        <div class="card-footer paging"></div>
      </div>
    </div>
  </div>
</div>

<script src="/asia3d/vendor/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
<script>
$('#simple-date1, #simple-date2').datepicker({
  format: 'yyyy/mm/dd',
  todayBtn: 'linked',
  todayHighlight: true,
  autoclose: true,        
});
</script>

<div id="progress" style="position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; line-height: 100vh; text-align:center; background-color: rgba(255,255,255,0.5); z-index: 99; display: none;">
  <img src="/asia3d/img/progress.gif" style="position:absolute; max-width:100%; max-height:100%; width:75px; height:auto; margin:auto; top:0; bottom:0; left:0; right:0">
</div>
</body>
</html>