<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的关注</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css" />
    <link rel="stylesheet" href="<%=basePath%>css/emoji.css" />
    <link rel="stylesheet" href="<%=basePath%>css/userhome.css" />
    <link rel="stylesheet" href="<%=basePath%>css/user.css" />
     <!-- bootstrap -->
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
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
    <img src="http://findfun.oss-cn-shanghai.aliyuncs.com/images/head_loading.gif" class="jcrop-preview jcrop_preview_s">
</div>
<div id="cover" style="min-height: 639px;">
    <div id="user_area">
        <div id="home_header">
            <a href="<%=basePath%>goods/homeGoods">
                <h1 class="logo"></h1>
            </a>
            <a href="<%=basePath%>goods/homeGoodse">
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
                <span class="name">${cur_user.username}</span><hr>
              <!--   <span class="school">莆田学院</span> -->
                  <a class="btn" style="width: 98%;background-color: rgb(79, 190, 246);color:rgba(255, 255, 255, 1);" href="<%=basePath%>user/myPurse">我的钱包：￥${myPurse.balance}</a>
                <input type="hidden" value="${myPurse.recharge}" id="recharge"/>
                <input type="hidden" value="${myPurse.withdrawals}" id="withdrawals"/>
               <span class="btn" data-toggle="modal" data-target="#myModal" style="width: 98%;background-color: rgb(79, 190, 246); color:rgba(255, 255, 255, 1);margin-top:0.5cm;">我的信用积分：${cur_user.power}</span>
                
            </div>
            <div class="home_nav">
                <ul>
                    <a href="<%=basePath%>orders/myOrders">
                        <li class="notice">
                            <div></div>
                            <span>订单中心</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>user/allFocus">
                        <li class="fri">
                            <div></div>
                            <span>关注列表</span>
                            <strong></strong>
                        </li>
                    </a>
                    
                    <a href="<%=basePath%>goods/publishGoods">
                        <li class="store">
                            <div></div>
                            <span>发布物品</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>user/allGoods">
                        <li class="second">
                            <div></div>
                            <span>我的闲置</span>
                            <strong></strong>
                        </li>
                    </a>
                    <a href="<%=basePath%>user/basic">
                        <li class="set">
                            <div></div>
                            <span>个人设置</span>
                            <strong></strong>
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
                <h1 style="text-align: center">关注列表</h1>
					<hr />
                <div class="share_content">
                    <c:if test="${empty goodsAndImage}">
                        <div class="no_share">
                            <span>没有任何内容，去逛逛其它的吧！</span>
                        </div>
                    </c:if>
                    <c:if test="${!empty goodsAndImage}">
                        <c:forEach var="items" items="${goodsAndImage}">
                            <div class="story">
                                <a href="<%=basePath%>goods/goodsId/${items.goods.id}" class="head_img">
                                    <img src="../upload/${items.images[0].imgUrl}">
                                </a>
                                <span class="name">${items.goods.name}</span>
                                <span class="text" style="overflow: hidden; outline: none;">${items.goods.describle}</span>
                                <div class="box">
                                    <div class="box_content">
                                        <div class="left_shadow"></div>
                                        <div class="left" index="1" style="display: none;"><</div>
                                        <div class="right_shadow"></div>
                                        <div class="left" index="3" style="display: none;">></div>
                                        <img src="../upload/${items.images[0].imgUrl}" index="2">
                                        <span class="com" style="display: none;left: 396.733px;"></span>
                                    </div>
                                    <div class="interact">
                                        <span class="fa fa-heart fa-lg"><a href="<%=basePath%>goods/goodsId/${items.goods.id}">前往购买</a></span>
                                        <span class="fa fa-heart-o fa-lg"><a href="<%=basePath%>user/deleteFocus/${items.goods.id}">取消关注</a></span>
                                    </div><br>
                                    <div class="like_detail">
                                        <div class="like_content">
                                            <span>下架时间：${items.goods.endTime}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
            <!--

                描述：最右侧，可能认识的人
            -->
            <div class="recommend">
                <div class="title">
                    <span class="text">可能认识的人</span>
                    <span class="change">换一组</span>
                    <span class="underline"></span>
                </div>
                <ul>
                    <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo1.jpg">
                        </a>
                        <span>Brudce</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                    <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo2.jpg">
                        </a>
                        <span>Graham</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                    <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo3.jpg">
                        </a>
                        <span>策马奔腾hly</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                    <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo4.jpg">
                        </a>
                        <span>Danger-XFH</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                    <li>
                        <a href="" class="head_img">
                            <img src="<%=basePath%>img/photo5.jpg">
                        </a>
                        <span>Keithw</span>
                        <div class="fa fa-plus-square"></div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>