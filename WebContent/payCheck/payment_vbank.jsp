<%@page import="book.vo.BookBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
BookBean bb = (BookBean)request.getAttribute("bookList");
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book/payment_vbank</title>
<body>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!--무통장입금 결제 -->
<script>
var IMP = window.IMP;

IMP.init('imp28424881');
IMP.request_pay({
    pg : 'inicis',
    pay_method : 'vbank',
    merchant_uid : 'merchant_' + new Date().getTime(),
    name : '주문명:결제테스트',
    amount : <%=bb.getBook_price()%>,
    buyer_email : 'iamport@siot.do',
    buyer_name : '구매자이름',
    buyer_tel : '010-1234-5678',
    buyer_addr : '서울특별시 강남구 삼성동',
    buyer_postcode : '123-456'
}, function(rsp) {
    if ( rsp.success ) {
        var msg = '결제가 완료되었습니다.';
        msg += '고유ID : ' + rsp.imp_uid;
        msg += '상점 거래ID : ' + rsp.merchant_uid;
        msg += '결제 금액 : ' + rsp.paid_amount;
        msg += '카드 승인번호 : ' + rsp.apply_num;
        window.close();
        opener.parent.location='BookPro.bk?car_id=<%=bb.getCar_id()%>&pickup=<%=bb.getPickup_date() %>&end=<%=bb.getEnd_date() %>&rentprice=<%=bb.getBook_price()%>&member_id=<%=bb.getMember_id()%>';
    } else {
        var msg = '결제에 실패하였습니다.';
        msg += '에러내용 : ' + rsp.error_msg;
        window.close();
    }

    alert(msg);
});
</script>
</body>
</html>