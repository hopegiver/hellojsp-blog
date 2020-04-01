/* Korean initialisation for the jQuery calendar extension. */
/* Written by DaeKwon Kang (ncrash.dk@gmail.com), Edited by Genie and Myeongjin Lee. */
( function( factory ) {
	if ( typeof define === "function" && define.amd ) {

		// AMD. Register as an anonymous module.
		define( [ "../widgets/datepicker" ], factory );
	} else {

		// Browser globals
		factory( jQuery.datepicker );
	}
}( function( datepicker ) {

datepicker.regional.ko = {
	dateFormat: "yy-mm-dd", 			// Input Display Format 변경	
	showOtherMonths: false, 			// 빈 공간에 현재월의 앞뒤월의 날짜를 표시
    showMonthAfterYear:true, 		// 년도 먼저 나오고, 뒤에 월 표시
    changeYear: true, 					// 콤보박스에서 년 선택 가능
    changeMonth: true, 				// 콤보박스에서 월 선택 가능
	closeText: "닫기",
	prevText: "이전달",
	nextText: "다음달",
	currentText: "오늘",
	buttonText: "선택", 					// 버튼에 마우스 갖다 댔을 때 표시되는 텍스트
	//	yearSuffix: "년", 						// 달력의 년도 부분 뒤에 붙는 텍스트
	monthNames: [ "1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월" ],
	monthNamesShort: [ "1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월" ],
	dayNames: [ "일요일","월요일","화요일","수요일","목요일","금요일","토요일" ],
	dayNamesShort: [ "일","월","화","수","목","금","토" ],
	dayNamesMin: [ "일","월","화","수","목","금","토" ],
	weekHeader: "주",	
	firstDay: 0,
	isRTL: false};
datepicker.setDefaults( datepicker.regional.ko );

return datepicker.regional.ko;

} ) );