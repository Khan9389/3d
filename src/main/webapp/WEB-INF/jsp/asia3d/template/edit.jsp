<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ include file="../include/head.jsp" %>


<style>
  *, *:before, *:after {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
  }
  .icon {
    background-color: transparent;
    border: 0;
    color: #557eef;
    cursor: pointer;
    display: block;
    font-size: 7px;
    background-color: #b1dae7;
    margin: 3em auto 0 auto;
    position: relative;
    width: 9em;
    height: 9em;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
  }
  .icon:focus {
    /* This may be anti-A11Y, but just for this demo suppresses the annoyance */
    outline: 0;
  }
  .icon div {
    position: absolute;
  }
  .cloud {
    transition: opacity 0.1s linear;
  }
  /* Cloud */
  .cloud {
    top: 0;
    width: 9em;
    height: 5.8em;
  }
  .puff, .cloud-core {
    background-color: #fff;
  }
  .puff {
    border-radius: 50%;
  }
  .puff-1 {
    top: 2.5em;
    left: 0;
    width: 3.3em;
    height: 3.3em;
  }
  .puff-2 {
    top: 1em;
    left: 1.2em;
    width: 3em;
    height: 3em;
  }
  .puff-3 {
    top: 0;
    left: 3em;
    width: 4.6em;
    height: 4.6em;
  }
  .puff-4 {
    top: 1.8em;
    left: 5em;
    width: 4em;
    height: 4em;
  }
  .puff-5 {
    top: 2.3em;
    left: 2.4em;
    width: 3.5em;
    height: 3.5em;
  }
  .puff-6 {
    top: 2.3em;
    left: 3em;
    width: 3.5em;
    height: 3.5em;
  }
  .puff-7 {
    top: 2.4em;
    left: 1em;
    width: 1.8em;
    height: 1.8em;
  }
  .puff-8 {
    top: 1.2em;
    left: 2.5em;
    width: 2em;
    height: 2em;
  }
  .puff-9 {
    top: 1.8em;
    left: 5.5em;
    width: 2em;
    height: 2em;
  }
  .puff-10 {
    top: 3.6em;
    left: 3.5em;
    width: 2.2em;
    height: 2.2em;
  }
  .cloud-core {
    top: 1.8em;
    left: 1.8em;
    width: 5em;
    height: 4em;
  }
  .check {
    top: 0;
    left: 1.6em;
    width: 5.8em;
    height: 5.8em;
    position: relative;
    transform: scale(0);
    z-index: -1;
  }
  .check:before, .check:after {
    background-color: currentColor;
    content: "";
    bottom: 0;
    display: block;
    left: 2.5em;
    position: absolute;
    width: 0.8em;
  }
  .check:before {
    height: 3em;
    transform: rotate(-55deg);
    transform-origin: 50% 2.6em;
  }
  .check:after {
    height: 5.5em;
    transform: rotate(35deg);
    transform-origin: 50% 5.1em;
  }
  /* Arrow */
  .arrow {
    top: 3em;
    left: 0;
    width: 9em;
    height: 5.3em;
  }
  .arrow div, .progress {
    border-radius: 0.4em;
  }
  .arrow div {
    background-color: currentColor;
  }
  .arrow-stem {
    bottom: 0;
    left: 4.1em;
    width: 0.8em;
    height: 5.3em;
    transform-origin: 50% 100%;
  }
  .arrow-l-tip, .arrow-r-tip {
    left: calc(50% - 0.4em);
    bottom: 0;
    width: 2.6em;
    height: 0.8em;
    transform-origin: 0.4em 50%;
  }
  .arrow-l-tip {
    transform: rotate(-135deg);
  }
  .arrow-r-tip {
    transform: rotate(-45deg);
  }
  .progress {
    background-color: #fff;
    bottom: 0;
    left: 0;
    width: 0;
    height: 0.8em;
  }

  /* Droplets */
  .preload, .drop {
    transition: all 0.2s linear;
  }
  .preload {
    animation: spin 1s linear infinite;
    opacity: 0;
    top: 2.9em;
    left: calc(50% - 1.25em);
    width: 2.5em;
    height: 2.5em;
    z-index: 1;
  }
  .drop {
    background-color: currentColor;
    background-image: radial-gradient(0.5em 0.5em at 30% 75%,rgb(255,255,255) 45%, rgba(255,255,255,0) 50%);
    border-radius: 50%;
    width: 100%;
    height: 100%;
  }
  .drop-1 {
    transform: scaleY(0.75) rotate(135deg);
  }
  .drop-2 {
    transform: rotate(120deg) scaleY(0.75) rotate(135deg);
  }
  .drop-3 {
    transform: rotate(240deg) scaleY(0.75) rotate(135deg);
  }

  /** Animation **/
  .waiting, .running {
    cursor: default;
  }
  /* Waiting */
  .waiting .cloud {
    opacity: 0.15;
  }
  .waiting .preload {
    opacity: 1;
  }
  .waiting .drop {
    border-radius: 0 50% 50% 50%;
  }
  .waiting .drop-1 {
    transform: translateY(2.5em) scaleY(0.75) rotate(135deg);
  }
  .waiting .drop-2 {
    transform: rotate(120deg) translateY(2.5em) scaleY(0.75) rotate(135deg);
  }
  .waiting .drop-3 {
    transform: rotate(240deg) translateY(2.5em) scaleY(0.75) rotate(135deg);
  }

  /* Running */
  .running .puff {
    animation-duration: 0.75s;
    animation-delay: 2.75s;
    animation-timing-function: cubic-bezier(.1,.8,.2,.95);
  }
  .running .puff-1 {
    animation-name: puff1;
  }
  .running .puff-2 {
    animation-name: puff2;
  }
  .running .puff-3 {
    animation-name: puff3;
  }
  .running .puff-4 {
    animation-name: puff4;
  }
  .running .puff-5 {
    animation-name: puff5;
  }
  .running .puff-6 {
    animation-name: puff6;
  }
  .running .puff-7 {
    animation-name: puff7;
  }
  .running .puff-8 {
    animation-name: puff8;
  }
  .running .puff-9 {
    animation-name: puff9;
  }
  .running .puff-10 {
    animation-name: puff10;
  }
  .running .cloud-core {
    animation: core 2.75s;
  }
  .running .check {
    animation: check 0.4s 2.75s;
  }
  .running .arrow {
    animation: arrow 0.125s;
  }
  .running .arrow-stem {
    animation: arrowStem 0.125s;
  }
  .running .arrow-l-tip {
    animation: arrowLTip 0.375s 0.125s;
  }
  .running .arrow-r-tip {
    animation: arrowRTip 0.375s 0.125s;
  }
  .running .progress {
    animation: filling 2s 0.75s;
  }
  .icon.running div {
    animation-fill-mode: forwards;
  }
  .icon.running .cloud-core, .icon.running .check, .icon.running .arrow, .icon.running .arrow div, .icon.running .progress {
    animation-timing-function: linear;
  }

  /* Keyframes */
  @keyframes puff1 {
    from {opacity: 1;transform: translate(0) scale(1)}
    to {opacity: 0;transform: translate(-4em,0) scale(0.1)}
  }
  @keyframes puff2 {
    from {opacity: 1;transform: translate(0) scale(1)}
    to {opacity: 0;transform: translate(-2em,-2em) scale(0.1)}
  }
  @keyframes puff3 {
    from {opacity: 1;transform: translate(0) scale(1)}
    to {opacity: 0;transform: translate(2em,-4em) scale(0.1)}
  }
  @keyframes puff4 {
    from {opacity: 1;transform: translate(0) scale(1)}
    to {opacity: 0;transform: translate(4em,0) scale(0.1)}
  }
  @keyframes puff5 {
    from {opacity: 1;transform: translate(0) scale(1)}
    to {opacity: 0;transform: translate(-3.5em,3.5em) scale(0.1)}
  }
  @keyframes puff6 {
    from {opacity: 1;transform: translate(0) scale(1)}
    to {opacity: 0;transform: translate(3.5em,3.5em) scale(0.1)}
  }
  @keyframes puff7 {
    from {opacity: 1;transform: translate(0) scale(1)}
    to {opacity: 0;transform: translate(-3em,-1.5em) scale(0.1)}
  }
  @keyframes puff8 {
    from {opacity: 1;transform: translate(0) scale(1)}
    to {opacity: 0;transform: translate(-0.5em,-2em) scale(0.1)}
  }
  @keyframes puff9 {
    from {opacity: 1;transform: translate(0) scale(1)}
    to {opacity: 0;transform: translate(2em,-2em) scale(0.1)}
  }
  @keyframes puff10 {
    from {opacity: 1;transform: translate(0) scale(1)}
    to {opacity: 0;transform: translate(0em,2.5em) scale(0.1)}
  }
  @keyframes core {
    from {visibility: visible}
    to {visibility: hidden}
  }
  @keyframes check {
    from {transform: scale(0)}
    30% {transform: scale(1.2)}
    60% {transform: scale(0.9)}
    to {transform: scale(1)}
  }
  @keyframes arrow {
    from {transform: translateY(0)}
    to {transform: translateY(0.7em)}
  }
  @keyframes arrowStem {
    from {height: 5.3em}
    to {height: 0.8em}
  }
  @keyframes arrowLTip {
    from {transform: rotate(-135deg)}
    50% {width: 2.6em;transform: rotate(-180deg)}
    to {width: 4.9em;transform: rotate(-180deg)}
  }
  @keyframes arrowRTip {
    from {transform: rotate(-45deg);}
    50% {width: 2.6em;transform: rotate(0deg)}
    to {width: 4.9em;transform: rotate(0deg)}
  }
  @keyframes filling {
    from {width: 0;}
    to {width: 100%;}
  }
  @keyframes spin {
    from {transform: rotate(0deg)}
    to {transform: rotate(1turn)}
  }
</style>


<script type="text/javascript"> 
var userUid = window.USER_INFO.user_uid;
<% String tmpl_id = request.getParameter("tmpl_id"); %>

var tmpl_id = <%=tmpl_id%>;


var mCrudTp = (tmpl_id == "null" || !tmpl_id) ? "c" : "r";
var mArrayContsFile = new Array();
var mArrayFirstFilesName = new Array();	// 업로드된 콘텐츠파일명
var mArrayFirstFilesUid = new Array();	// 업로드된 콘텐츠파일uid
var mArrayChngFlTp = new Array();	// 업로드된 콘텐츠파일타입


/*document.addEventListener("DOMContentLoaded",function(){
  this.querySelector(".icon").addEventListener("click",function(){
    alert('in');
    let waitClass = "waiting",
      runClass = "running",
      cl = this.classList;

    if (!cl.contains(waitClass) && !cl.contains(runClass)) {
      cl.add(waitClass);
      setTimeout(function(){
        cl.remove(waitClass);
        setTimeout(function(){
          cl.add(runClass);
          setTimeout(function(){
            cl.remove(runClass);
          }, 4000);
        }, 200);
      }, 1800);
    }
  });
});*/

$(document).ready(function() { 
  if (mCrudTp == "r") { readInfo(); }

  // 파일추가	
  $('#ex_file').change(function() {
    for (var i=0; i<this.files.length; i++) {
      if (this.files && this.files[i]) {
        readFile(this.files, i);
      }
    }
  });


  $(document).on('click', '.icon', function () {
    let waitClass = "waiting",
    runClass = "running",
    cl = this.classList;

    if (!cl.contains(waitClass) && !cl.contains(runClass)) {
      cl.add(waitClass);
      setTimeout(function(){
        cl.remove(waitClass);
        setTimeout(function(){
          cl.add(runClass);
          setTimeout(function(){
            cl.remove(runClass);
          }, 4000);
        }, 200);
      }, 1800);
    }
  });

  /*// 기분 파일 타입 수정	
  $('.fl_tp').change(function() {
    console.log('in');
    console.log(this);
  });*/

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


function readInfo() {
  var paramJson = new Object();
  paramJson.service_tp = "exh_tmpl_reg";
  paramJson.crud_tp = "r";
  paramJson.exh_tmpl_uid = tmpl_id;
  paramJson.user_uid = userUid;

  doMultipart(paramJson);
}



// 콘텐츠그룹정보 세팅
function setTamplInfo() {
	let mInfo = AIRPASS.mInfo;
	$('#tmpl_name').val(mInfo.tmpl_name);
  $('#tmpl_tp').val(mInfo.tmpl_tp);
	$('#prod_cnt').val(mInfo.prod_cnt);
  mInfo.use_yn == 'Y' ? $('#yes').attr('checked', true) : $('#no').attr('checked', true);
}


function getval(sel)
{
  var objChngFlTp = new Object();
  let flUid = $(sel).attr('data-idx');
  let flTp = sel.value;
  let checkUid = false;
  if(mArrayChngFlTp.length == 0) {
    objChngFlTp.tmpl_fl_uid = flUid;
    objChngFlTp.tmpl_fl_tp = flTp;
    mArrayChngFlTp.push(objChngFlTp);
  } else {
    for (let i = 0; i < mArrayChngFlTp.length; i++) {
      if (mArrayChngFlTp[i].tmpl_fl_uid == flUid) {
        mArrayChngFlTp[i].tmpl_fl_tp = flTp; 
        checkUid = true;
        break;
      }
    }
    if(!checkUid) {
      objChngFlTp.tmpl_fl_uid = flUid;
      objChngFlTp.tmpl_fl_tp = flTp;
      mArrayChngFlTp.push(objChngFlTp);
    }
  }
}


// 파일 세팅
function setFile() {  
  let fileList = AIRPASS.mInfo.list_tmpl_file;
  if(!fileList) return;

  for (let i = 0; i < fileList.length; i++) {
    let file = fileList[i];

    let hrefHtml = 'https://service.3dbank.xyz/exhibition/downThumbImg.do?tmpl_uid='+file.exh_tmpl_uid+'&dir=tmpl&file='+file.save_name+'&'+file.upt_date;

    let htmlText = '<a href="'+hrefHtml+'"><button type="button" class="icon">'+
                      '<div class="cloud">'+
                        '<div class="puff puff-1"></div>'+
                        '<div class="puff puff-2"></div>'+
                        '<div class="puff puff-3"></div>'+
                        '<div class="puff puff-4"></div>'+
                        '<div class="puff puff-5"></div>'+
                        '<div class="puff puff-6"></div>'+
                        '<div class="puff puff-7"></div>'+
                        '<div class="puff puff-8"></div>'+
                        '<div class="puff puff-9"></div>'+
                        '<div class="puff puff-10"></div>'+
                        '<div class="cloud-core"></div>'+
                        '<div class="check"></div>'+
                        '<div class="arrow">'+
                          '<div class="arrow-stem">'+
                            '<div class="arrow-l-tip"></div>'+
                            '<div class="arrow-r-tip"></div>'+
                          '</div>'+
                        '</div>'+
                      '</div>'+
                      '<div class="preload">'+
                        '<div class="drop drop-1"></div>'+
                        '<div class="drop drop-2"></div>'+
                        '<div class="drop drop-3"></div>'+
                      '</div>'+
                      '<div class="progress"></div>'+
                    '</button></a>';
    
    let tmpHtml = 
      "<tr>" +
        "<td>" +
          "<select data-idx='"+file.exh_tmpl_file_uid+"' id='tp_"+i+"' class='form-control _fl-tp' onchange='getval(this)'>" +
            "<option value='1'>3D 전시관</option>" +
            "<option value='2'>대표 이미지</option>" +
            "<option value='3'>전시관 구조도</option>" +
          "</select>" +
        "</td>" +
        "<td class='_file-name'>"+file.file_name+"</td>" +
        "<td>"+file.file_size+"</td>" +
        "<td>"+file.upt_dttm+"</td>" +
        "<td>"+htmlText+"</td>" +
        "<td><input type='button' name='sch_button3' value='x' class='btn btn-danger btn-sm' onclick='clickDeleteFile(this)' /></td>" +
      "</tr>";
    let sel = '#tp_' + i;
    $('#tbody_file').append(tmpHtml);
    $(sel).val(file.file_tp);
    mArrayFirstFilesName.push(file.save_name);   
    mArrayFirstFilesUid.push(file.exh_tmpl_file_uid);
  }
}

function setProd() {
    let prodList = AIRPASS.mInfo.list_tmpl_prod;
    if(!prodList) return;

    let tmpHtml = ''; 

    let i = 1;
    for ( let k=0; i <= prodList.length; i++, k++) {
      (i % 2) !== 0 ?  tmpHtml += '<tr>' : '';
      tmpHtml += 
        '<td data-idx="">' + prodList[k].prod_loc +'</td>' +
        '<td>' +
          '<select id="prod_tp_'+i+'" class="form-control exh tmpl">' +
            '<option value="1">2D콘텐츠-프레임에 사이즈 맞춤(모니터 등)</option>' +
            '<option value="2">2D콘텐츠-이미지에 사이즈 맞춤(벽면 등)</option>' +
            '<option value="3">3D 콘텐츠</option>' +
          '</select></td>';
      (i % 2) === 0 ?  tmpHtml += '</tr>' : '';
    }

    (i % 2) === 0 ?  tmpHtml += '</tr>' : '';

    $('#tbody_prod').append(tmpHtml);

    for (let j=0; j < prodList.length; j++) {
      let prod = prodList[j];
      let sel = '#prod_tp_' + (j+1);
      $(sel).val(prod.prod_tp);
    }
}


// 이미지파일삭제 버튼 클릭
function clickDeleteFile(obj) {
	var tmpIdx = $('#tbody_file tr').index($(obj).parent().parent());
	$("#tbody_file > tr:eq(" + tmpIdx + ")").remove();
	

	if (tmpIdx < mArrayFirstFilesName.length) {
		mArrayFirstFilesName.splice(tmpIdx, 1);
    mArrayFirstFilesUid.splice(tmpIdx, 1);
  } else {
		mArrayContsFile.splice(tmpIdx - mArrayFirstFilesName.length, 1);
  }

  console.log(mArrayFirstFilesName);
}


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


    if (mArrayContsFile.length + mArrayFirstFilesName.length >= 3) {
      alert("최대 3개 까지 등록할 수 있습니다.");
      return;
    }
    mArrayContsFile.push(file);
      
      var tmpHtml =
        "<tr>" + 
          '<td><select class="form-control cont_type _fl-tp"><option value="1" selected>3D 전시관</option><option value="2">대표 이미지</option><option value="3">전시관 구조도</option> </select></td>' + 
            "<td class='_file-name'>" + fileName + "</td>" + 
            "<td>" + size + "</td>" +
            "<td>Last Updated : Just Now</td>" + 
            "<td></td>" + 
            "<td><input type='button' name='sch_button3' value='x' class='btn btn-danger btn-sm' onclick='clickDeleteFile(this)' /></td>"
      "</tr>";
      $('#tbody_file').append(tmpHtml);
  }
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
  function clickProdSet() {

    let answer = window.confirm("이전에 등록된  전시 콘텐츠 위치설정이 모두 사진으로 초기화 됩니다. 설정을 변경 하시겠습니까?");
    if (!answer) return; 

    let productCnt = $('#prod_cnt').val();
    let tmpHtml = ''; 
    $('#tbody_prod').empty();

    let i = 1;
    for ( ; i <= productCnt; i++) {
      (i % 2) !== 0 ?  tmpHtml += '<tr>' : '';
      tmpHtml += 
        '<td class="_prod-loc" data-idx="">' + i + '</td>' +
        '<td>' +
          '<select class="form-control tmpl" name="">' +
            '<option value="1" selected>2D콘텐츠-프레임에 사이즈 맞춤(모니터 등)</option>' +
            '<option value="2">2D콘텐츠-이미지에 사이즈 맞춤(벽면 등)</option>' +
            '<option value="3">3D 콘텐츠</option>' +
          '</select>' +
        '</td>';
      (i % 2) === 0 ?  tmpHtml += '</tr>' : '';
    }

    (i % 2) === 0 ?  tmpHtml += '</tr>' : '';

    $('#tbody_prod').append(tmpHtml);

  }

// 저장버튼 클릭
function clickBtnSave() { 

  var tmpl_name = $('#tmpl_name').val();
  tmpl_name = $.trim(tmpl_name);
  var tmpl_tp = $('#tmpl_tp').find('option:selected').val();
  var prod_cnt = $('#prod_cnt').val().replace(/\D/g, "");
  let useYN = $("#yes").is(":checked") ? 'Y' : 'N';

  let checkFileTp = true;
  for (let i = 0; i < mArrayContsFile.length; i++) {
    let fileName = mArrayContsFile[i].name;
    let fileExt = fileName.substr(fileName.lastIndexOf('.') + 1).toLowerCase();
    if(fileExt == 'glb') {checkFileTp = false; break; }
  }

  for (let i = 0; i < mArrayFirstFilesName.length; i++) {
    let fileName = mArrayFirstFilesName[i];
    let fileExt = fileName.substr(fileName.lastIndexOf('.') + 1).toLowerCase();
    if(fileExt == 'glb') {checkFileTp = false; break; }
  }

  if (checkFileTp) {
    alert("GLB 파일을 입력해주세요.");
    return;
  }

  if (tmpl_name.length == 0) {
    alert("3D 전시관명을 입력해주세요.");
    return;
  }

  if (prod_cnt == '') {
    alert("전시상품 수을 입력해주세요.");
    return;
  }



  let prodList = new Array();
  let tmplContsInfo = new Object();
  $('#tbody_prod tr').each(function() {
    let row = $(this);
    if (row.children('td').length > 2) { 
      //prodList.push($(this).find(".tmpl").eq(0).find('option:selected').val());
      //prodList.push($(this).find(".tmpl").eq(1).find('option:selected').val());
      tmplContsInfo = new Object();
      tmplContsInfo.tmpl_prod_loc = $(this).find("._prod-loc").eq(0).html();
      tmplContsInfo.prod_tp = $(this).find(".tmpl").eq(0).find('option:selected').val();
      prodList.push(tmplContsInfo);
      tmplContsInfo = new Object();
      tmplContsInfo.tmpl_prod_loc = $(this).find("._prod-loc").eq(1).html();
      tmplContsInfo.prod_tp = $(this).find(".tmpl").eq(1).find('option:selected').val();
      prodList.push(tmplContsInfo);
    } else {
      tmplContsInfo = new Object();
      tmplContsInfo.tmpl_prod_loc = $(this).find("._prod-loc").eq(0).html();
      tmplContsInfo.prod_tp = $(this).find(".tmpl").eq(0).find('option:selected').val();
      prodList.push(tmplContsInfo);
    }
  });

  let originProdList = AIRPASS.mInfo.list_tmpl_prod;
  let uptProdList = new Array();
  for (let i = 0; i < prodList.length; i++) {
    let objProd = new Object();
    if (originProdList[i]) {
      objProd.prod_uid = originProdList[i].exh_tmpl_prod_uid;
      objProd.prod_tp = prodList[i].prod_tp;
    } else {
      objProd.prod_uid = 'newProd';
      objProd.prod_tp = prodList[i].prod_tp;
      objProd.tmpl_prod_loc = prodList[i].tmpl_prod_loc;
    }
    uptProdList.push(objProd);
  }

  let delProdList = new Array();
  let idx = prodList.length;
  if(originProdList.length > prodList.length) {
    for (let i = idx; i < originProdList.length; i++) {
      delProdList.push(originProdList[i].exh_tmpl_prod_uid); 
    }
  }

  // 콘텐츠 구분
  let file_tp = new Array();
  let checkFlTp = new Array();
  let tpCnt = 0;
  $('#tbody_file tr').each(function() {
    let value = $(this).find(".cont_type").find('option:selected').val();
    if(value) file_tp.push(value);
    let tp = $(this).find("._fl-tp").find('option:selected').val();
    checkFlTp.push(tp);
    let fileName = $(this).find("._file-name").html();
    let fileExt = fileName.substr(fileName.lastIndexOf('.') + 1).toLowerCase();
    if(fileExt == 'glb') tpCnt++;
    if(tpCnt > 1){
            alert("GLB 파일은 한 개 이상 입력할 수 없습니다.");
      return;
    }

    if((fileExt == 'glb' && tp != '1') || (fileExt != 'glb' && tp == '1')) {
      alert("3D 전시관 파일은 GLB 포맷만 가능합니다. (Error: " + fileName + ")");
      return;
    }
  });

  // Check File Type
  if (checkFlTp.indexOf('1') == -1) {
    alert("3D 전시관 파일을 선택 또는 드래그해주세요.");
    return;
  }
  if (checkFlTp.indexOf('2') == -1) {
    alert("대표 이미지 파일을 선택 또는 드래그해주세요.");
    return;
  }
  if (checkFlTp.indexOf('3') == -1) {
    alert("전시관 구조도 파일을 선택 또는 드래그해주세요.");
    return;
  }


  var paramJson = new Object();
  paramJson.exh_tmpl_uid = AIRPASS.mInfo.exh_tmpl_uid;
  paramJson.service_tp = "exh_tmpl_reg";
  paramJson.crud_tp = "u";
  paramJson.tmpl_name = tmpl_name;
  paramJson.tmpl_tp = tmpl_tp;
  paramJson.upt_prod_list = uptProdList;
  paramJson.del_prod_list = delProdList;
  paramJson.use_yn = useYN;


  // 전시이미지 파라미터 세팅
  var arrayExhFile = new Array();
  for (var i=0; i<mArrayContsFile.length; i++) {
    if (!mArrayContsFile[i]) {
      continue;
    }
    var objExhFile = new Object();
    objExhFile.file_tp = file_tp[i];
    objExhFile.file_name = mArrayContsFile[i].name;
    objExhFile.file_size = mArrayContsFile[i].size;
    arrayExhFile.push(objExhFile);
  }
  paramJson.tmpl_file = arrayExhFile;

  let arrayInsName = new Array();
  let arrayDelName = new Array();
  let arrayUpdateFl = new Array();

  for (var i=0; i<mArrayContsFile.length; i++) {
    arrayInsName.push(mArrayContsFile[i].name);
  }

  let fileList = AIRPASS.mInfo.list_tmpl_file;
  let tmpFilesList = new Array();
  for (let i=0; i < fileList.length; i++) {
    if (fileList[i] && fileList[i].save_name)
      tmpFilesList.push(fileList[i].save_name);
  }
  for (let i=0; i < tmpFilesList.length; i++) {
    if (tmpFilesList[i] && mArrayFirstFilesName.indexOf(tmpFilesList[i]) == -1)
      arrayDelName.push(tmpFilesList[i]);
  }

  let tmpFilesUid = new Array();
  for (let i=0; i < mArrayChngFlTp.length; i++) {
    if (mArrayChngFlTp[i] && mArrayChngFlTp[i].tmpl_fl_uid)
      tmpFilesUid.push(mArrayChngFlTp[i].tmpl_fl_uid);
  }
  for (let i=0; i < tmpFilesUid.length; i++) {
    if (tmpFilesUid[i] && mArrayFirstFilesUid.indexOf(parseInt(tmpFilesUid[i])) >= 0) {
      arrayUpdateFl.push(mArrayChngFlTp[i]);
    }
  }


  paramJson.arrayInsName = arrayInsName;
  paramJson.arrayDelName = arrayDelName;
  paramJson.arrayUpdateFl = arrayUpdateFl;

  //console.log(paramJson);
  doMultipart(paramJson);
}


// Multipart 통신 및 Callback
function doMultipart(tmpJson) {
  printLog("send JSON", JSON.stringify(tmpJson));

  //if (tmpJson.crud_tp == "u") return;
  var formData = new FormData();
  for (var i=0; i<mArrayContsFile.length; i++) {
		if (mArrayContsFile[i])
			formData.append("file[]", mArrayContsFile[i]);
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
            location.href = "/exhibition/template/index.do";
          } else if (tmpJson.crud_tp == "r") {
            AIRPASS.mInfo = result;
            mCrudTp = "u";
            setTamplInfo();
            setFile();
            setProd();
            console.log(AIRPASS.mInfo);
          } else if (tmpJson.crud_tp == "d") {
            alert("정상적으로 삭제 되었습니다.");
            location.href = "/exhibition/template/index.do";
          }
        } else {
          alert(result.retmsg);
          location.href = "/exhibition/template/index.do";
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

function deleteTmpl(){
  var paramJson = new Object();
  paramJson.exh_tmpl_uid = tmpl_id;
  paramJson.service_tp = 'exh_tmpl_reg';
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
          deleteTmpl();
        } else {
          alert(result.retmsg);
        }

      }
  });
}

function clickDelTmpl() {
  let jsonParam = new Object();
  jsonParam.service_tp = 'check_tmpl_delete';
  jsonParam.exh_tmpl_uid = tmpl_id;
  doCommunication(jsonParam);
}

</script>


<body id="page-top">
  <div id="wrapper">
    <%@ include file="../include/header.jsp" %>
      <div class="container-fluid" id="container-wrapper">
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
          <h1 class="h3 mb-0 text-gray-800">전시관 템플릿 수정</h1>
          <ol class="breadcrumb">
            <li class="breadcrumb-item">전시관 템플릿 관리</li>
            <li class="breadcrumb-item"><a href="#">전시관 템플릿 목록</a></li>
            <li class="breadcrumb-item active" aria-current="page">전시관 템플릿 수정</li>
          </ol>
        </div>

        <div class="row">
          <div class="col-lg-12 mb-4">
            <div class="card layout-write">
                <div class="section">
                  <h6>전시관 템플릿 업로드</h6>
                  <div class="box-file">
                    <i class="fas fa-cloud-upload-alt"></i>
                    <p class="main">업로드할 파일을 <span class="text-primary">선택</span> 또는 <span class="text-primary">드래그</span>해주세요</p>
                    <input id="ex_file" type="file" class="form-control" enctype='multipart/form-data' multiple="">
                    <p class="sub">*<span class="text-primary">jpg, png, gif, glb</span> 파일을 선택해주세요 (최대 3개까지 업로드 가능)</p>
                  </div>
                  <div class="table-responsive">
                    <table class="table align-items-center table-flush text-center">
                      <thead class="thead-light">
                        <tr>
                          <th>콘텐츠 구분</th>
                          <th>파일명</th>
                          <th>사이즈</th>
                          <th>업로드 일자</th>
                          <th>다운로드</th>
                          <th>삭제</th>
                        </tr>
                      </thead>
                      <tbody id='tbody_file'>
                        <!--<tr>
                          <td>
                            <select class="form-control" name="">
                              <option value="3D 전시관" selected>3D 전시관</option>
                              <option value="대표 이미지">대표 이미지</option>
                              <option value="전시관 구조도">전시관 구조도</option>
                            </select>
                          </td>
                          <td>Vr_sport.gltf</td>
                          <td>500K</td>
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

                <div class="section box-input">
                  <h6>전시관 템플릿 정보</h6>
                  <label class="field d-flex mb-3">
                    <p style="width:96px">전시관명</p>
                    <input  id="tmpl_name"type="text" class="form-control">
                  </label>
                  <div class="row column-input">
                    <label class="field d-flex col-sm-6">
                      <p style="width:96px">전시관 종류</p>
                      <select id="tmpl_tp" class="form-control">
                        <option value="1">체험관</option>
                        <option value="2">박물관</option>
                      </select>
                    </label>
                    <label class="field d-flex col-sm-6">
                      <p>전시상품 수</p>
                      <input id="prod_cnt" class="form-control" style="width:100px" type="text" onkeypress="if(event.keyCode==13) {$('#prod_cnt_click').trigger('click'); return false;}">
                      <button id="prod_cnt_click" class="btn btn-success ml-2" onclick="clickProdSet()">위치 설정</button>
                    </label>
                  </div>
                  <div style="margin-top:15px" class="row column-input field col-sm-6"><!--class="field d-flex col-sm-6">-->
                    <p class="mr-4" style="font-size:18px">전시회 등록여부</p>
                    <div class="custom-control custom-radio mr-3">
                      <input type="radio" id="yes" name="use-yn" class="custom-control-input">
                      <label class="custom-control-label" for="yes">가능</label>
                    </div>
                    <div class="custom-control custom-radio mr-3">
                      <input type="radio" id="no" name="use-yn" class="custom-control-input">
                      <label class="custom-control-label" for="no">불가능</label>
                    </div>
                  </div>
                </div>

                <div class="section mb-0">
                  <h6>전시관 템플릿 위치설정</h6>
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
                          <th>전시 콘텐츠 구분</th>
                          <th>위치 순번</th>
                          <th>전시 콘텐츠 구분</th>
                        </tr>
                      </thead>
                      <tbody id='tbody_prod'>
                        <!--<tr>
                          <td>1</td>
                          <td>
                            <select class="form-control" name="">
                              <option value="사진">사진</option>
                              <option value="동영상" selected>동영상</option>
                              <option value="3D 콘텐츠">3D 콘텐츠</option>
                            </select>
                          </td>
                          <td>2</td>
                          <td>
                            <select class="form-control" name="">
                              <option value="사진">사진</option>
                              <option value="동영상" selected>동영상</option>
                              <option value="3D 콘텐츠">3D 콘텐츠</option>
                            </select>
                          </td>
                        </tr>-->
                      </tbody>
                    </table>
                  </div>
                </div>

                <div class="d-flex justify-content-end mt-5">
                  <button type="button" class="btn btn-lg btn-secondary mr-2" onclick="clickDelTmpl()">삭제</button>
                  <button type="button" class="btn btn-lg btn-primary" onclick="clickBtnSave()">저장</button>
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