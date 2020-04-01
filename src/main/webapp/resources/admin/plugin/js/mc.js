if(window.console == undefined) console = {log:function(){}};
var console_text = "";
console_text +="   __  _____________  _______  _______		\n";
console_text +="  /  |/  / ___/ ___ \\/ ___/  |/  / __/		\n";
console_text +=" / /|_/ / /__/ / _ `/ /__/ /|_/ /\\ \\  	\n";
console_text +="/_/  /_/\\___/\\ \\_,_/\\___/_/  /_/___/  	\n";
console_text +="              \\___/                   		\n";
console.log("%c"+console_text, "color:blue;font-size:10pt;");

var DEBUG = true;
var MC_EDITOR = "smarteditor";//ck-editor,smarteditor,crosseditor
function getJSON(targetURL, params, callback){
	var promise = $.ajax({
		url : targetURL, 
		type: "POST", 
		data : params, 
		dataType : "json", 
		async: true,
		cache : false
	}).fail(errorProc);
	
	promise.done(function(data){
		if(!!callback){
			callback(data);
		}
	});
	return promise;
}
function getSyncJSON(targetURL, params, callback){
	var promise = $.ajax({
		url : targetURL, 
		type: "POST", 
		data : params, 
		dataType : "json", 
		async: false,
		cache : false
	}).fail(errorProc);
	
	promise.done(function(data){
		if(!!callback){
			callback(data);
		}
	});
	return promise;
}
function errorProc(jqXHR,textStatus,errorThrown){
	if(jqXHR.status == 401){
		var returnURL = location.pathname + location.search;
		if(confirm("세션이 끊어졌습니다.\n로그인 후 다시 시도해 주세요.\n로그인페이지로 이동하시겠습니까?")){
			window.top.location.href = "/super/login/index.do?returnURL="+returnURL;
		}
	}else if(jqXHR.status == 403){
		var returnURL = location.pathname + location.search;
		if(confirm("새로운 사용자가 로그인하였거나, 로그아웃되었습니다.\n로그인페이지로 이동하시겠습니까?")){
			window.top.location.href = "/super/login/index.do?returnURL="+returnURL;
		}
	}else if(jqXHR.status == 404){
		alert("요청하신 페이지를 찾을수 없습니다.");
	}else{
		var msg = $.parseJSON(jqXHR.responseText);
		if("Y"==msg.debug){
			alert("=================에러코드("+jqXHR.status+")=================\n"+jqXHR.statusText+" 자세한 에러내용은 콘솔확인\n====================END====================");
			console.error(msg.error_message);
		}else{
			alert("==============="+jqXHR.statusText+"================\n관리자에게 문의하십시오\n=====================END====================");
		}
	}
}
if(!String.prototype.startsWith) {
	String.prototype.startsWith = function(str){
		if (this.length < str.length) { return false; }
		return this.indexOf(str) == 0;
	}
}
if(!String.prototype.endsWith) {
	String.prototype.endsWith = function(str){
		if (this.length < str.length) { return false; }
		return this.lastIndexOf(str) + str.length == this.length;
	}
}
if(!String.prototype.getParameter) {
	String.prototype.getParameter = function(key){
		var str = this;
		var scripts = document.getElementsByTagName('script');
		var myScript = null;
		$.each(scripts, function(i,v){
			if($(v).attr("src") != null){
				if(($(v).attr("src")).indexOf(str) > -1){
					myScript = $(v).attr("src");
					return false;
				}
			}
		});
		if(myScript != null){
			var queryString = myScript.replace(/^[^\?]+\??/,'').split("&");
			var parameters = {};
			$.each(queryString, function (i,v){
				var pair = v.split("=");
			    var pair_key = decodeURIComponent(pair[0]);
			    var pair_value = decodeURIComponent(pair[1]);
			    if(typeof parameters[pair_key] === "undefined"){
			    	parameters[pair_key] = decodeURIComponent(pair_value);// If second entry with this name
			    }else if(typeof parameters[pair_key] === "string"){
			    	var arr = [parameters[pair_key], decodeURIComponent(pair_value)];
			    	parameters[pair_key] = arr; // If third or later entry with this name
			    }else{
			    	parameters[pair_key].push(decodeURIComponent(pair_value));
			    }
			})
			return parameters[key] == null ? "" : parameters[key];
		}else{
			return "";
		}
	}
}
if (!window.location.origin) {
    window.location.origin  = window.location.protocol + "//" + window.location.hostname + ( window.location.port ? ':'+window.location.port : '' );
}

if(!!$.blockUI){
	$.blockUI.defaults = {
			message : "<img src='/images/cms/common/ajax-loader.gif' alt='로딩중...'/> 페이지 로딩중입니다.",
		    overlayCSS:  { 
		        backgroundColor: '#968d8d', 
		        opacity:         0.6, 
		        cursor:          'wait' ,
				'z-index' : 200000
		    }, 
		    centerX: true, // <-- only effects element blocking (page block controlled via css above) 
		    centerY: true,
		    bindEvents: true,
		    constrainTabKey : true,
		    showOverlay : true,
			css : {
			    border: 'none', 
			    padding: '5px', 
			    backgroundColor: '#676767', 
			    '-webkit-border-radius': '10px', 
			    '-moz-border-radius': '10px', 
			    opacity: .6, 
			    color: '#fff',
				'z-index' : 200001
			}
	}
}

function submitHiddenForm(b,e){
	var a=$("#_hidden_iframe_");
	if(!a[0]){
		a=$('<iframe id="_hidden_iframe_" name="_hidden_iframe_" style="display: none;"></iframe>');
		$("body").append(a)
	}
	var d=$("#_hidden_form_");
	if(!d[0]){
		d=$('<form method="post" id="_hidden_form_" target="_hidden_iframe_" style="display: none;"></form>');
		$("body").append(d)
	}
	d.empty();
	d.attr("action",b);
	for(var c in e){
		if(e.hasOwnProperty(c)){
			$('<input type="hidden">').attr("name",c).attr("value",e[c]).appendTo(d)
		}
	}
	d.submit();
}

//화면캡쳐(오브젝트,파일명)
function capture(captureObj,file_name) {
	html2canvas($(captureObj), {
		//allowTaint: true,
		//taintTest: false,
		useCORS: true,
		//proxy: '/etc/proxy_image',
		onrendered: function(canvas) {
			var image = canvas.toDataURL();
			submitHiddenForm("/etc/bypass_image", { image : image, filename:file_name+".png"});
		}
	});
}

function popOpen(url, title, width, height) {
	var w = width; // 팝업창 넓이
	var h = height; // 팝업창 높이
	var winl = (screen.width - w) / 2;
	var wint = (screen.height - h) / 2;
	var settings = 'height=' + h + ',';
	settings += 'width=' + w + ',';
	settings += 'top=' + wint + ',';
	settings += 'left=' + winl + ',';
	settings += 'scrollbars=yes,';
	settings += 'resizable=yes';
	window.open(url, title, settings);
}

function twtLink(){
	var shortUrl = shorturl(location.href);
	var title = encodeURIComponent($("title").text());
	window.open("https://twitter.com/intent/tweet?text=" + encodeURIComponent("[CMS데모]") + title + ":" + "&url=" + shortUrl);
}

function fbLink(){
	var title = encodeURIComponent($("title").text());
	window.open("https://www.facebook.com/sharer/sharer.php?u=" + encodeURIComponent(location.href));
}
function ksLink(){
	var title = $("title").text();
	var shortUrl = shorturl(location.href);
	Kakao.Story.share({
		url: shortUrl,
		text: $("title").text()
	});
}

function shorturl(url){
	var rst = url;
	$.ajax({
		type : "POST",
		url : "/shorturl.do",
		async: false,
		data : {
			longUrl : encodeURIComponent(url),
			login : "o_3qojukp8ip",
			apiKey : "R_c52d594730d94c058959c1e12efa17da",
			format : "xml"
		},
		dataType : "text",
		success : function(transUrl){
			rst = transUrl;
		}
	});	
	return rst;
}
function copyLink(){
	window.prompt('아래의 URL을 복사하여 사용하실수 있습니다.', location.href);
}

function capLock(e){
	var keyCode = 0;
	var shiftKey = false;
	keyCode = e.keyCode;
	shiftKey = e.shiftKey;
	if (((keyCode >= 65 && keyCode <= 90) && !shiftKey)	|| ((keyCode >= 97 && keyCode <= 122) && shiftKey)) {
		if($('#capslock').is(":visible")==false){
			$('#capslock').show(100).delay( 2800 ).hide(100);
		}
	}
}

function fileSizeCheck(id, limit){
	var iSize = 0;
	if (!!$.browser.msie && $.browser.version<10) {
		var objFSO;
		try{
			objFSO = new ActiveXObject("Scripting.FileSystemObject");
		}catch(event){
			alert("ie10이하 버전에선 파일용량 체크가 안될수있습니다. 최신브라우저로 업그레이드 하시거나 chrome 브라우저를 다운로드받아 이용하시기 바랍니다.");
			return false;
		}
		var sPath = $(id)[0].value;
		var objFile = objFSO.getFile(sPath);
		var iSize = objFile.size;
		iSize = iSize / 1024;
	} else {
		iSize = ($(id)[0].files[0].size / 1024);
	}
	iSize = (Math.round((iSize / 1024) * 100) / 100)
	if(iSize > limit){
		return false;
	}else{
		return true;
	}
}

function vote(menu_seq, val, obj){
	getJSON("/vote/vote.do", {cms_menu_seq : menu_seq, article_seq : val}, function(data){
		if(data.rst == "0"){//반영실패
			alert(data.msg);
		}else{//반영성공
			alert(data.msg);
			$(obj).html(data.cnt);
		}
	})
}
(function($) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");

    $.ajaxSetup({
           beforeSend: function(xhr) {
        	if( token && header ){
        		xhr.setRequestHeader(header, token);
        		xhr.setRequestHeader("AJAX", true);
        	}
        },
        statusCode : {
            403: function() {    
              	//alert("sorry! session or csrf token invalid ...");
            	location.reload();
            }
        }
    });
})(jQuery);

if(location.href.indexOf("#currentview")>0){
//	delete window.alert;
//	delete window.location;
	window.alert = function(){};
	history.pushState(null, null, location.href);
	window.onpopstate = function(event) {
		history.go(1);
	};
}