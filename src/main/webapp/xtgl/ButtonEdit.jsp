<%--
  Created by IntelliJ IDEA.
  User: 93525
  Date: 2018/12/7
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="../layui/css/layui.css" media="all">
    <script src="../layui/layui.js"></script>
    <script src="../js/jquery.js"></script>
    <script src="../js/jquery-3.2.1.js"></script>
    <script src="../js/distpicker.data.js"></script>
    <script src="../js/distpicker.js"></script>
</head>
<body>
<div class="layui-form">
    <br/>
    <input type="hidden" id="bid" value="<%=request.getParameter("bid")%>">
    <div class="layui-form-item">
        <label class="layui-form-label">按钮名称</label>
        <div class="layui-input-block">
            <input type="text" placeholder="按钮名称" id="bname" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">父级菜单</label>
        <div class="layui-input-block">
            <select id="MenuParent"></select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">权限名称</label>
        <div class="layui-input-block">
            <input type="text" placeholder="权限名称" id="premission" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</div>

<script>
    $(function () {
        $.ajax({
            type: "POST",
            url: "/Button/findOnly.action",
            data: {
                bid: $('#bid').val()
            },
            dataType: "json",
            success: function (data) {
                $('#bname').val(data.name);
                $('#MenuParent').val(data.mparent);
                $('#premission').val(data.mpath);
            }
        });
    $.ajax({
        async: false,
        type: "POST",
        url: "/Menu/findAllSonMenu.action",
        dataType: "json",
        data: {
            page: 0,
            limit: 1000
        },
        success: function (res) {
            var opt = "<option value='-1' selected = \'selected\'>--请选择--</option>";
            $("#MenuParent").append(opt);
            for (var i = 0; i < res.data.length; i++) {
                var option = "<option value=\"" + res.data[i].MenuId + "\"";
                option += ">" + res.data[i].MenuName + "</option>"; //动态添加数据
                $("#MenuParent").append(option);
            }
        }
    });
});
//Demo
layui.use('form', function () {
    var form = layui.form;
    //监听提交
    form.on('submit(formDemo)', function (data1) {
        $.ajax({
            type: "POST",
            url: "/Button/edit.action",
            data: {
                bid: $('#bid').val(),
                bname: $('#bname').val(),
                name: $('#MenuParent').val(),
                premission: $('#premission').val()
            },
            dataType: "text",
            success: function (data) {
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);
                parent.location.reload();
            }
        });
    });

});
</script>

</body>
</html>



