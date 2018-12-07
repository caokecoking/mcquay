<%--
  Created by IntelliJ IDEA.
  User: 93525
  Date: 2018/11/29
  Time: 20:41
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
    <input type="hidden" id="Deptid" value="<%=request.getParameter("Deptid")%>"/>
    <div class="layui-form-item">
        <label class="layui-form-label">岗位名称</label>
        <div class="layui-input-block">
            <input type="text" placeholder="岗位名称" id="DeptName" autocomplete="off" class="layui-input">
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
    $(function(){
        $.ajax({
            type: "POST",
            url: "/department/findOnly.action",
            data: {
                Deptid: $('#Deptid').val()
            },
            dataType: "json",
            success: function (data) {
                $('#Deptid').val(data.Deptid);
                $('#DeptName').val(data.DeptName);
            }
        });
    })
    //Demo
    layui.use('form', function () {
        var form = layui.form;
        //监听提交
        form.on('submit(formDemo)', function (data1) {
            $.ajax({
                type: "POST",
                url: "/department/editDepartment.action",
                data: {
                    Deptid: $('#Deptid').val(),
                    DeptName: $('#DeptName').val()
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

