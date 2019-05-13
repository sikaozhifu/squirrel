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
    <title>个人中心</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css" />
    <link rel="stylesheet" href="<%=basePath%>css/emoji.css" />
    <link rel="stylesheet" href="<%=basePath%>css/userhome.css" />
    <link rel="stylesheet" href="<%=basePath%>css/user.css" />

    <!-- bootstrap -->
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap-paginator.min.js"></script>

   <script type="text/javascript">

   function viewPersonal(id){
	   $.ajax({
			url:'<%=basePath%>admin/getUser',
			type:'GET',
			data:{id:id},
			dataType:'json',
			success:function(json){
				if(json){
					$('#myviewform').find("input[name='phone']").val(json.phone);
					$('#myviewform').find("input[name='username']").val(json.username);
					$('#myviewform').find("input[name='qq']").val(json.qq);
					$('#myviewform').find("input[name='power']").val(json.power);
					$('#myviewform').find("input[name='createAt']").val(json.createAt);
					$('#viewModal').modal('toggle');
				}
			},
			error:function(){
				alert('请求超时或系统出错!');
				$('#viewModal').modal('hide');
			}
   });
  }
   
   function sendContext(){
	 var context= $("#mycontext").text();
	 $.ajax({
		 url:'<%=basePath%>user/insertSelective',
		 type:'POST',
		 data:{context:context},
		 dataType:'json',
		 success:function(json){
			 alert(json.msg);
			 location.reload();
		 },
		error:function(){
			 alert('请求超时或系统出错!');
			}
	 });
	   
   }
   
   $(function(){
       var options={
           bootstrapMajorVersion:1,    //版本
           currentPage:1,    //当前页数
           numberOfPages:5,    //最多显示Page页
           totalPages:10,    //所有数据可以显示的页数
           onPageClicked:function(e,originalEvent,type,page){
               console.log("e");
               console.log(e);
               console.log("originalEvent");
               console.log(originalEvent);
               console.log("type");
               console.log(type);
               console.log("page");
               console.log(page);
           }
       }
       $("#page").bootstrapPaginator(options);
   })
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
    <img src="http://findfun.oss-cn-shanghai.aliyuncs.com/images/head_loading.gif" class="jcrop-preview jcrop_preview_s">
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
                <span class="name">${cur_user.username}</span><hr>
              <!--   <span class="school">莆田学院</span> -->
                <a class="btn" style="width: 98%;background-color: rgb(79, 190, 246);color:rgba(255, 255, 255, 1);" href="<%=basePath%>user/myPurse">我的钱包：￥${myPurse.balance}</a>
                <input type="hidden" value="${myPurse.recharge}" id="recharge"/>
                <input type="hidden" value="${myPurse.withdrawals}" id="withdrawals"/>
                <span class="btn" data-toggle="modal" data-target="#myModal" style="width: 98%;background-color: rgb(79, 190, 246); color:rgba(255, 255, 255, 1);margin-top:0.5cm;">
                	我的信用积分：${cur_user.power}
                </span>
                
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
            <img src="<%=basePath%>img/Advertisement.png">
          -->
                <div class="publish">
                	<form role="form" id="contextForm">
                     <div class="pub_content">
                        <div class="text_pub lead emoji-picker-container">
                            <input type="text" name="context" data-emojiable="converted"  class="form-control" data-type="original-input" style="display: none;"/>
                            <div class="emoji-wysiwyg-editor form-control" data-type="input" id="mycontext" contenteditable="true"></div>
                            <i class="emoji-picker-icon emoji-picker face" data-type="picker" style="top: 153px;"></i>
                            <div class="tag"></div>
                        </div>
                        <div class="img_pub">
                            <ul></ul>
                        </div>
                    </div>
                 	  </form>
                    <div class="button">
                        <span class="fa fa-image">
                            ::before
                            <input type="file" accept="image/gif,image/jpeg,image/jpg,image/png" multiple/>
                        </span>
                        <div class="checkbox">
                            <button onclick="sendContext()">发 布</button>
                        </div>
                    </div> 
                    
                </div>
                <!--

                    描述：闲置商品展示
                -->
                <div class="share_content">
                 <c:if test="${notice==null}">
                    <div class="no_share">
                    <span>没有任何内容，去逛逛其它的吧！</span>
                    </div>
                   </c:if>
                   <c:if test="${notice!=null}">
                    <div class="yes_share">
                    <h1 style="text-align: center;">求购信息</h1><hr>
                     <c:forEach items="${notice}" var="item" varStatus="status">
                   	 <button type="button" class="btn btn-info" onclick="viewPersonal(${item.user.id})" style="background-color: #c6f5f4;border:0px;outline:none;">${item.user.username}</button>
                     <span >说：&nbsp;&nbsp;&nbsp;&nbsp;${item.context}</span><br>
                     <p style="text-align:right;color:#4fbef6;">发布时间：${item.createAt}</p>
                     <hr><br>
                     </c:forEach>
                      <div id="page" style="center"></div>
                    <!--  <h1> 1 2 3 4 5 下一页 上一页</h1> -->
                    </div>
                    </c:if>  
                </div>
            </div>

            <div class="recommend">
                <div class="title">
                    <span class="text">聊天好友</span>
                    <span class="underline"></span>
                </div>
                <ul>
                <c:forEach items="${userList}" var="item" varStatus="status">
                	<li>
                        <a href="#" class="head_img">
                            <img src="<%=basePath%>img/photo${status.index + 1}.jpg">
                        </a>
                        <span>${item.username}</span>
                        <div style="text-align: right;cursor: pointer;" onclick="chat(${item.id})"><i class="fa fa-weixin fa-2x" aria-hidden="true"></i>&nbsp; &nbsp; &nbsp; </div>
                    </li>
                  </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="ng-scope chat" id="chat" hidden>
    <div class="share_content">

        <div >
            <h1 style="text-align: right;cursor: pointer" onclick="closeChar()">X</h1>
            <h1 style="text-align: center;">聊天记录</h1>

            <div id="chatcontent">

            </div>

            <div class="publish-content">
                <textarea class="textcontent" name="content"></textarea>
                <button class="btn" id="sendchat">发送</button>
            </div>
        </div>

    </div>

</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title middle" id="myModalLabel">查看用户信息</h4>
            </div>
            <div class="modal-body" style="height: 220px;">
	         <form id="myviewform">
	          <div class="form-group">
	            <label for="recipient-name" class="control-label col-sm-2" >名称:</label>
	            <div class="col-sm-10">
	            <input type="text" class="form-control" id="message-text" name="username" readonly/>
	          </div>
	          </div>
	          <div class="form-group">
	            <label for="message-text" class="control-label col-sm-2">手机号:</label>
	            <div class="col-sm-10">
	            <input type="text" class="form-control" id="message-text" name="phone" readonly/>
	          </div> 
	          </div>
	           <div class="form-group">
	            <label for="message-text" class="control-label col-sm-2">qq号:</label>
	            <div class="col-sm-10">
	            <input type="text" class="form-control" id="message-text" name="qq" readonly/>
	          </div> 
	          </div>
	          <div class="form-group">
	            <label for="message-text" class="control-label col-sm-2">信用积分:</label>
	            <div class="col-sm-10">
	            <input type="text" class="form-control" id="message-text" name="power" readonly/>
	          </div>
	           </div>
	          <div class="form-group">
	            <label for="message-text" class="control-label col-sm-2">开户时间:</label>
	             <div class="col-sm-10">
	            <input type="text" class="form-control" id="message-text" name="createAt" readonly/>
	          </div>
	           </div>
	        </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>