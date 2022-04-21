$(document).ready(function() {
  function checkActivePage() {
    const path = window.location.pathname;
    const curItem = $(`a[href="${path}"]`);

    if (curItem.length < 1) {
      let menu;
      if (path.includes('/template/')) {
        menu = $('#menuTemplate');
      } else if (path.includes('/product/')) {
        menu = $('#menuProduct');
      } else if (path.includes('/exhibition/')) {
        menu = $('#menuExhibition');
      }
      menu.addClass('show')
        .siblings('.nav-link').removeClass('collapsed');
        
    } else {
      curItem.parents('.collapse').addClass('show')
        .siblings('.nav-link').removeClass('collapsed');
    }
  }
  checkActivePage();
});



// 로그 출력
function printLog(tmpName, tmpValue) {
    console.log(">>>>>>>>>> " + tmpName + " : " + tmpValue);
}

// 암호화 + br 변환
function getText_Encode(tmpTxt) {
	if (!tmpTxt)
		return "";
	
	var txt = tmpTxt.replace(/\n/gi, "<br>");
	txt = encodeURIComponent(encodeURIComponent(txt));
	return txt;
}


function getDecodeTxt(tmpTxt) {
	var txt = decodeURIComponent(decodeURIComponent(tmpTxt));
	return txt.replace(/<br>/gi, "\n");
}


function getURLParameter(sParam){
  var sPageURL = window.location.search.substring(1);
  var sURLVariables = sPageURL.split('&');
  for (var i = 0; i < sURLVariables.length; i++){
  var sParameterName = sURLVariables[i].split('=');
  if (sParameterName[0] == sParam){
    return sParameterName[1];
  }
  }
  return null;
}



function pagination(params){
  var pageSize = 10; 
  var maxRetCount = AIRPASS.pageInfo.maxRetCount;
  var pageCount = Math.ceil(params.totalCount / maxRetCount) ;
  var pageText = "";
  var range;

  if(params.rangePage == 1 || params.rangePage == null){
    range = 1;
  }else {
    range = (Math.ceil(params.rangePage / pageSize ) -1) * pageSize +1;
  }

  var endPage = false;
  var page = range;
  
  pageText += '<ul class="pagination justify-content-end mb-1">';
  if( range != 1 ){
    pageText += '<li class="page-item previous">';
    pageText += '<a href="javascript:;" class="prev page-link" id="page'+ --page +'">이전</a></li>';
  }

  for (var i = 0; i < pageSize; i++) {
    page = range + i;
    if(pageCount >= page){
      var opt = params.rangePage == page ? 'active' : '';    
      pageText += '<li class="page-item '+opt+'"><a href="javascript:;" id="page'+ page +'" class="page-link">'+ page +'</a></li>';
    } else{
      endPage = true;
    }
  }

  if(!endPage){ 
    pageText += '<li class="page-item next"><a href="#" id="page'+ ++page +'" class="page-link">다음</a></li>';
  }
  pageText += '</ul>';
  			
  AIRPASS.pageInfo.endPage = pageCount;
  $(".card-footer").empty();
  $(".card-footer").append(pageText);
  
}






