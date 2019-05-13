<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>确认订单</title>
	<link rel="icon" href="<%=basePath%>img/logo.png" type="image/x-icon"/>
<link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css" />
<link rel="stylesheet" href="<%=basePath%>css/userhome.css" />
<link rel="stylesheet" href="<%=basePath%>css/user.css" />

<!-- bootstrap -->
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
<script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>

<!--订单编号随机数（有可能重复，得处理）  -->
<script type="text/javascript">
	window.onload = function() {
		var o = document.getElementsByClassName('order-num');

		o[0].value = fRandomBy(00000000, 99999999);
	}
	function fRandomBy(under, over) {
		switch (arguments.length) {
		case 1:
			return parseInt(Math.random() * under + 1);
		case 2:
			return parseInt(Math.random() * (over - under + 1) + under);
		default:
			return 0;
		}
	}
</script>

	<style>
		.chat {
			width: 1000px;
			height: 500px;
			margin: 20px auto;
			background-color: #f9f9f9;
			z-index: 999;
			box-shadow: 0 2px 5px 0 rgba(0, 0, 0, .16), 0 2px 10px 0 rgba(0, 0, 0, .12);
			padding: 20px;
			position: fixed;
			top: 0px;
			left: 0px;
			right: 0px;
			bottom: 0px;
			margin: auto;
			overflow: scroll;
		}

		.p-left {
			text-align: left;
			color: #f65b08;
		}

		.p-right {
			text-align: right;
			color: #f65b08;
		}

		.p-left-content {
			background-color: #74a7f5;
			border: 0px;
			outline: none;
		}

		.p-right-content {
			background-color: rgba(93, 141, 245, 0.57);
			border: 0px;
			outline: none;
			text-align: right
		}

		.textcontent {
			width: 100%;
			padding: 6px 12px;
			font-size: 14px;

			color: #555;
			background-color: #fff;
			background-image: none;
			border: 1px solid #ccc;
			border-radius: 4px;
			-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
			box-shadow: inset 0 1px 1px rgba(32, 255, 140, 0.07);
			-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
			line-height: 25px;
			color: rgb(51, 51, 51);
			font-size: 16px;
			outline: 0px;
			content: attr(placeholder);
			color: #9aa2ab;
		}

		.textcontent:HOVER {
			-webkit-transition: border linear .2s, -webkit-box-shadow linear .5s;
			border-color: rgba(224, 203, 17, 0.75);
			-webkit-box-shadow: 0 0 18px rgba(14, 229, 230, 0.29);
		}

		.publish-content {
			padding: 25px;
			width: 100%;
			position: relative;
			left: 0;
			bottom: 0;
			text-align: center;
		}
	</style>
	<script type="text/javascript">
        var maijiaUid;
        var has = 0;
        var uid = ${cur_user.id};

        function closeChar() {
            $("#chat").hide();
        }

        function chat(id) {

            if (has == 0){
                setInterval(function () {
                    has =1
                    updateChar(id);
                },1000)
            }

            $("#chat").show();
        }




        //更新聊天内容
        function updateChar(id) {
            maijiaUid = id;//卖家id
            var html = "";
            $.get("<%=basePath%>/chats/list?"+Math.random(), {sayuser: uid, lisuser: maijiaUid}, function (obj) {

                for (var i = 0; i < obj.length; i++) {

                    if (obj[i].sayuser == uid) {
                        html += "  <p class=\"p-right\">" + obj[i].time + " 我说：&nbsp;&nbsp;&nbsp;&nbsp;</p>\n" +
                            "                <br/>\n" +
                            "                <p style=\"text-align: right\"><span class=\"btn btn-info p-right-content\">" + obj[i].content + "</span></p>\n" +
                            "                 <br/>";
                    } else {
                        html += " <p class=\"p-left\">" + obj[i].time + " " + obj[i].sayname + "说：&nbsp;&nbsp;&nbsp;&nbsp;</p>\n" +
                            "                <br/>\n" +
                            "                <p class=\"btn btn-info p-left-content\">" + obj[i].content + "</p>\n" +
                            "                <br/>";
                    }

                }

                $("#chatcontent").html(html);


            })

        }

        $(function () {
            $("#sendchat").click(function () {
                var content = $("textarea[name=content]").val();
                if (content == "" || content == null){
                    return false;
                } else {
                    $.post("<%=basePath%>/chats/save",{sayuser:uid,lisuser:maijiaUid,content:content});
                    $("textarea[name=content]").val("");
                    updateChar(maijiaUid);
                }
            })
        })
	</script>
</head>
<body>
	<div class="pre-2" id="big_img">
		<img
			src="http://findfun.oss-cn-shanghai.aliyuncs.com/images/head_loading.gif"
			class="jcrop-preview jcrop_preview_s">
	</div>
	<div id="cover" style="min-height: 639px;">
		<div id="user_area">
			<div id="home_header">
				<a href="<%=basePath%>goods/homeGoods">
					<h1 class="logo"></h1>
				</a>
				<a href="<%=basePath%>goods/homeGoods">
                 <img src="<%=basePath%>img/home_header.png"  style="margin-left: 20px;" >
           		 </a> 
				<a href="<%=basePath%>user/home">
					<div class="home"></div>
				</a>
			</div>
			<!--

            描述：左侧个人中心栏
        -->
			<div id="user_nav">
				<div class="user_info">
					<div class="head_img">
						<img src="<%=basePath%>img/photo.jpg">
					</div>
					<div class="big_headimg">
						<img src="">
					</div>
					<span class="name">${cur_user.username}</span>
					<hr>
					<!--   <span class="school">莆田学院</span> -->
				   <a class="btn" style="width: 98%;background-color: rgb(79, 190, 246);color:rgba(255, 255, 255, 1);" href="<%=basePath%>user/myPurse">我的钱包：￥${myPurse.balance}</a>
                <input type="hidden" value="${myPurse.recharge}" id="recharge"/>
                <input type="hidden" value="${myPurse.withdrawals}" id="withdrawals"/>
               <span class="btn" data-toggle="modal" data-target="#myModal"style="width: 98%; background-color: rgb(79, 190, 246); color: rgba(255, 255, 255, 1); margin-top: 0.5cm;">我的信用积分：${cur_user.power}</span>

				</div>
				<div class="home_nav">
					<ul>
						<a href="<%=basePath%>orders/myOrders">
							<li class="notice">
								<div></div> <span>订单中心</span> <strong></strong>
						</li>
						</a>
						<a href="<%=basePath%>user/allFocus">
							<li class="fri">
								<div></div> <span>关注列表</span> <strong></strong>
						</li>
						</a>
						<a href="<%=basePath%>goods/publishGoods">
							<li class="store">
								<div></div> <span>发布物品</span> <strong></strong>
						</li>
						</a>
						<a href="<%=basePath%>user/allGoods">
							<li class="second">
								<div></div> <span>我的闲置</span> <strong></strong>
						</li>
						</a>
						<a href="<%=basePath%>user/basic">
							<li class="set">
								<div></div> <span>个人设置</span> <strong></strong>
						</li>
						</a>
					</ul>
				</div>
			</div>
			<!--

            描述：右侧内容区域
        -->
			<div id="user_content">

				<div class="share">

					<!--

                    描述：关注商品展示
                -->
					<h1 style="text-align: center">确认订单</h1>
					<hr />
					<div class="share_content">
						<div class="story">
							<form class="form-horizontal" role="form" action="<%=basePath%>orders/addOrders" >
							<h4 >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;订单编号： <input name="orderNum" class="order-num" type="text" style="border:0px;background:rgba(0, 0, 0, 0);" value=""/>  <input name="goodsId" type="hidden" value="${goodsExtend.goods.id}"/> </h4>
								<div class="form-group">
									<label for="firstname" class="col-sm-2 control-label">图片:</label>
									<div class="col-sm-10">
                							<img style="height:150px;weight:150px;" src="<%=basePath%>upload/${goodsExtend.images[0].imgUrl}" />
									</div>
									<label for="firstname" class="col-sm-2 control-label">名称：</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" disabled="disabled" style="border:0px;background:rgba(0, 0, 0, 0); " value="${goodsExtend.goods.name}" >
									</div>
									<label for="firstname" class="col-sm-2 control-label">价格：</label>
									<div class="col-sm-10">
										<input name="orderPrice" type="hidden" class="form-control" style="border:0px;background:rgba(0, 0, 0, 0); " value="${goodsExtend.goods.price}">
										<input  type="text" class="form-control" style="border:0px;background:rgba(0, 0, 0, 0); " value="${goodsExtend.goods.price }"  name="pricetext">
										<input type="checkbox" name="check" value="1"> 线下寄售
									</div>
									<label for="firstname" class="col-sm-2 control-label" >收货信息：</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" 
											placeholder="收获人信息 地址 联系方式" value="" name="orderInformation">
									</div>
								</div>
								<hr />
								<div class="form-group">
									<div class="col-sm-offset-4 col-sm-8">
									    <a href="<%=basePath%>goods/goodsId/${goodsExtend.goods.id}" class="btn btn-danger">取消支付</a>
										<c:if test="${myPurse.balance >= goodsExtend.goods.price}"><button type="submit" class="btn btn-info">立即支付</button></c:if>
										<c:if test="${myPurse.balance < goodsExtend.goods.price}"><button disabled="disabled" class="btn btn-danger">余额不足，请充值！</button></c:if>
										
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>

				<script type="text/javascript">
					$(function () {
						$("input[name=check]").click(function () {
                            if ($(this).is(':checked')){
                                //选中
                                var price = $("input[name=orderPrice]").val();

                                $("input[name=orderPrice]").val(parseInt(price)+1);
                                $("input[name=pricetext]").val(price+ "+ 1.0运费");
							} else {
                                var price = $("input[name=orderPrice]").val();
                                $("input[name=orderPrice]").val(price-1);
                                $("input[name=pricetext]").val(price-1);
							}
                        })
                    })
				</script>
				<!--

                描述：最右侧，可能认识的人
            -->
				<div class="recommend">
					<div class="title">
						<span class="text">可能认识的人</span> <span class="change">换一组</span> <span
							class="underline"></span>
					</div>
					<ul>
						<li><a href="" class="head_img"> <img
								src="<%=basePath%>img/photo1.jpg">
						</a> <span>Brudce</span>
							<div class="fa fa-plus-square"></div></li>
						<li><a href="" class="head_img"> <img
								src="<%=basePath%>img/photo2.jpg">
						</a> <span>Graham</span>
							<div class="fa fa-plus-square"></div></li>
						<li><a href="" class="head_img"> <img
								src="<%=basePath%>img/photo3.jpg">
						</a> <span>hly</span>
							<div class="fa fa-plus-square"></div></li>
						<li><a href="" class="head_img"> <img
								src="<%=basePath%>img/photo4.jpg">
						</a> <span>Danger-XFH</span>
							<div class="fa fa-plus-square"></div></li>
						<li><a href="" class="head_img"> <img
								src="<%=basePath%>img/photo5.jpg">
						</a> <span>Keithw</span>
							<div class="fa fa-plus-square"></div></li>
					</ul>
				</div>
			</div>
		</div>
	</div>

</body>
</html>