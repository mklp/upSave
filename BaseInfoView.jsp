<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ page contentType="text/html; charset=gbk" language="java" import="java.sql.*,java.util.*" errorPage="" %>
<%@page import="com.zhongway.database.cDataControlA"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";	
	String rybm = request.getParameter("rybm");
	String tblFlag=request.getParameter("tblFlag");
	String rsTab = "tblrsxx_temp";
	if(tblFlag!=null&&"1".equals(tblFlag.trim())){
		rsTab = "tblrsxx";
	}
	cDataControlA cData = new cDataControlA();
	String xm = cData.GetFirfield("select xm from "+rsTab+" where rybm='"+rybm+"'");
	String sfz = cData.GetFirfield("select upper(sfz) from "+rsTab+" where rybm='"+rybm+"'");
	String fuli = cData.GetFirfield("select type from tbl_sys_config where name='五险一金展示'");
	//判断是查询人员还是新增人员
	String type="";
	if(request.getParameter("sType")!=null&&!"".equals(request.getParameter("s_type"))){
		type=request.getParameter("sType");
	}
	
%>	
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">		
<html>
<head>
 <base href="<%=basePath%>" target="_self">
 <title>人事工资</title>
<!-- 清理缓存开始 -->
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0"> 
<!-- 清理缓存结束 -->
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<META http-equiv="X-UA-Compatible" content="IE=8" />
<link href="<%=request.getContextPath()%>/czbs/css/style.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/czbs/bootstrap/css/bootmain.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/czbs/bootstrap/css/pills.css" rel="stylesheet">
<script type="text/javascript" src="<%=request.getContextPath()%>/czbs/bootstrap/js/jquery1.10.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/czbs/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/lib/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
<script>

	var cur_path = "<%=request.getContextPath()%>";
	//变量接收返回的sql结果
   // alert(fnx);
	//页面加载时发送ajax对是否有五险一金进行判断
	$().ready(function () {
	  //alert("测试");
		var url_wxyj = "<%=request.getContextPath() %>/czbs/ajaxActions.do";
        var  wxyjGzbd= "gzbd";
		//alert(wxyjName)
	    $.get(url_wxyj,
			{method:"wxyjDtShow",
                wxyjGzbd:wxyjGzbd
		},
		function (data) {
	        //alert(data)
			if(data){
			    //修改文本内容
			    document.getElementById("li_wxyj_herf").innerText=data;
			}
        });
    })
	//更新文本内容
	function formButton(){
	    var url="<%=request.getContextPath()%>/czbs/ajaxActions.do";
	    var id = $("#wxyj_Id").val();
	    var name =$("#wxyj_Name").val();
	    //alert(name)
	    $.post(url,{method:"wxyj_Update",wxyj_Id:id,wxyj_Name:name},function (msg) {
	        alert(msg);
            window.location.reload();
            $("#wxyj_Name").attr("value","");
        })
	}

	//设置样式
	$(function(){
		  $('#myTab a').click(function (e) {
		 	  e.preventDefault();
			  //$(this).tab('show');


	 });
		  //添加五险一金页签 2015年5月5日13:45:14

	/*	  var  rybm= document.getElementById("rybm").value;
		  var ls_url ="<%=request.getContextPath()%>/czbs/ajaxActions.do?method=wxyjShow&rybm="+rybm+"&tblFlag=<%=tblFlag %>";
		  $.ajax({
	                cache: true,
	                type: "POST",
	                url:ls_url,
	                async: false,
	                error: function(request) {
	                    alert("Connection error");
	                },
	                success: function(data) {
                       //alert(data)
	                    if(data!="succ"){
	                       //展示五险一金页签
                            var li = document.getElementById("li_wxyj");
	                       //alert(li)
	                       li.style.display="";
	                    } else {
                            var li = document.getElementById("li_wxyj");
	                        li.style.display="none";
						}
	                }
	        });*/

        //添加五险一金页签 2018

        var  type= "gzbd";
        var ls_url ="<%=request.getContextPath()%>/czbs/ajaxActions.do?method=wxyjShow_M&type="+type+"";
        $.ajax({
            cache: true,
            type: "POST",
            url:ls_url,
            async: false,
            error: function(request) {
                alert("Connection error");
            },
            success: function(data) {
              //  alert(data)
                if(data!="no"){
                    //展示五险一金页签
                    var li = document.getElementById("li_wxyj");
                    //alert(li)
                    li.style.display="";
                } else {
                    var li = document.getElementById("li_wxyj");
                    li.style.display="none";
                }
            }
        });

		  $("table").find("td").each(function(index,element){
	           if(index%2==0){
	               $(this).addClass("bghs"); 
	           }   
	       });			 
	});
	function load(){ 

	}

 //iframe高度设置
 function iFrameHeight(str) {
        var ifm= document.getElementById(str);
        var subWeb = document.frames ? document.frames[str].document :ifm.contentDocument;
        if(ifm != null && subWeb != null) {
            ifm.height = subWeb.body.scrollHeight;
        }
    }
  function ChangeRsGz(str){
    var dwbm = $("#dwbm").val();
    var rybm   = $("#rybm").val();
    var rslb   = $("#rslb").val();
    var typeid = $("#typeid").val();
    if(rybm=="null" || rybm==""){
        return;
    }

    if(str=="gz"){
         document.getElementById("frame").src = cur_path + "/czbs/displayAction.do?method=displaySalary&rybm="+rybm+"&typeid="+typeid+"&rslb="+rslb+"&tblFlag=<%=tblFlag %>";
         $("#myTab a:eq(1)").tab('show');
     }else if(str=="wxyj"){
    	 document.getElementById("wxyjframe").src = cur_path + "/czbs/displayAction.do?method=wxyjQuery&forword=wxyjQuery&rybm="+rybm+"&tblFlag=<%=tblFlag %>";  
        $("#myTab a:eq(2)").tab('show');
            }else{
         document.getElementById("iframepage").src = cur_path + "/czbs/displayAction.do?method=addPerson&typeid="+typeid+"&rslb="+rslb+"&rybm="+rybm+"&dwbm="+dwbm+"&tblFlag=<%=tblFlag %>&type=<%=type%>";
        $("#myTab a:eq(0)").tab('show');
     }
  } 
  function ChangePerson(change_flag){
  	var rybm   = $("#rybm").val();
  	var dwbm = $("#dwbm").val();
    var typeid = $("#typeid").val();
  	var url=cur_path+"/czbs/ajaxActions.do?method=ChangePerson&rybm="+rybm+"&change_flag="+change_flag;
  	$.post(url,function(data){
  		if(data!=",,,"){
  			var temp = data.split(",");
  			now_rybm = $.trim(temp[0]);
			now_rslb = $.trim(temp[1]);
			now_xm = $.trim(temp[2]);
			now_sfz = $.trim(temp[3]);
  	  		$("#rybm").val(now_rybm);
      		$("#rslb").val(now_rslb);
      		document.getElementById("iframepage").src = cur_path+"/czbs/displayAction.do?method=addPerson&typeid="+typeid+"&rslb="+now_rslb+"&rybm="+now_rybm+"&dwbm="+dwbm+"&tblFlag=<%=tblFlag %>&type=<%=type%>";
     		$(this).addClass("selected").siblings().removeClass("selected");
       		$("#myTab a:eq(0)").tab('show');
      		$("#xm").text(now_xm);
      		$("#sfz").text(now_sfz);
      		$("#beforesfz").val(now_sfz);
  		}else{
  			if(change_flag=="-1"){
  				alert("该人员没有上一个人");
  			}else{
  				alert("该人员没有下一个人");
  			}
  		}
  	});  		
  }

</script>
</head>
<body width="100%" height="100%">
 <input type="hidden" id="rybm" name="rybm" value="<%=request.getParameter("rybm") %>">
 <input type="hidden" id="typeid" name="typeid" value="<%=request.getParameter("typeid") %>">
 <input type="hidden" id="flag" name="flag" value="">
 <input type="hidden" id="dwbm" name="dwbm" value="<%=request.getParameter("dwbm") %>">
 <input type="hidden" id="rslb" name="rslb" value="<%=request.getParameter("rslb") %>"> 
 <input type="hidden" id="beforesfz" name="beforesfz" value="<%=sfz %>"> 
<section class="rbox">
<div style="margin-top:5px;">
<ul class="nav nav-tabs" id="myTab">
  <li class="active" style=" padding-left:0px;"><a href="#home" onclick="ChangeRsGz('rs')">人事信息</a></li>
  <li><a href="#profile" onclick="ChangeRsGz('gz')" >工资信息</a></li>
<!--   <li id="li_wxyj" style="display:none;"><a href="#wxyj" onclick="ChangeRsGz('wxyj')" >五险一金</a></li>-->
  <li id="li_wxyj" ><a href="#wxyj" onclick="ChangeRsGz('wxyj')" id="li_wxyj_herf" ></a></li>
  <li style="margin-top:5px;margin-left:100px;">
  		<span style="color:#4B83EC;">姓名: </span><span id="xm"  style="color:#4B83EC;"><%=xm %></span>&nbsp;&nbsp;&nbsp;&nbsp;
   		<span style="color:#4B83EC;">身份证：</span><span id ="sfz" style="color:#4B83EC;"><%=sfz %></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <span><input type="button" onclick="ChangePerson('-1')" value="上一页" class="button"></span>
        <span><input type="button" onclick="ChangePerson('+1')" value="下一页" class="button"></span>
	  <%--测试五险文字更新--%>
	  <form action="" method="" id="form001">
		  <input type="hidden"  name="wxyj_Id" value="55" id="wxyj_Id">
		  <input type="text" name="wxyj_Name" id="wxyj_Name" value="">
		  <input type="button" onclick="formButton()" value="更新">
	  </form>
 </li>
</ul>
</div>
<div class="tab-content">
  	<div class="tab-pane active" id="home">
	    <div class="tab-content">
	        <div class="tab-pane active" id="rs">	
	           <iframe id="iframepage" frameborder="0" name="iframepage" src="<%=request.getContextPath()%>/czbs/displayAction.do?method=addPerson&typeid=<%=request.getParameter("typeid") %>&rslb=<%=request.getParameter("rslb") %>&rybm=<%=request.getParameter("rybm") %>&dwbm=<%=request.getParameter("dwbm") %>&tblFlag=<%=tblFlag %>&type=<%=type%>" onLoad="iFrameHeight('iframepage')" 
	             style="width:100%;"></iframe>
	        </div>
	   </div>
   </div>
	<!--工资信息-->
  	<div class="tab-pane" id="profile">
		<div class="tab-content">
  			<div class="tab-pane active" id="zcgzmes">	
                 <iframe id="frame" frameborder="0" name="frame" src="" onLoad="iFrameHeight('frame')"   style="width:100%;"></iframe>  
		     </div>	
	    </div>
    </div>
   
    <!--五险一金信息-->
  	<div class="tab-pane" id="wxyj">
		<div class="tab-content">
  			<div class="tab-pane active" id="wxyj">	
                 <iframe id="wxyjframe" frameborder="0" name="wxyjframe" src="" onLoad="iFrameHeight('wxyjframe')"   style="width:100%;"></iframe>  
		     </div>	
	    </div>
    </div>  
</div>
</section> 
</body>
</html>
