<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<link rel="stylesheet" href="../layui/css/layui.css" media="all">
<script src="../layui/layui.js"></script>
<script src="../js/jquery.js"></script>
<script src="../js/jquery-3.2.1.js"></script>
<script src="../js/distpicker.data.js"></script>
<script src="../js/distpicker.js"></script>
<body>
<br/>
<script>
    $(function () {
        $.ajax({
            type: 'post',
            url: '../FindProducttypeDateBind.action',
            dataType: 'json',
            data: {
                PtId: $('#ids').val()
            }, success: function (data) {
                $('#PtDescribe').val(data.p.ptDescribe);
                $('#ptId').val(data.p.ptId);
            }
        })
    })

    function ProducttypeEdit() {
        $.ajax({
            type: 'post',
            url: '../FindProducttypeEdit.action',
            dataType: 'text',
            data: {
                PtId: $('#ptId').val(),
                PtDescribe: $('#PtDescribe').val()
            }, success: function (data) {
                if (data > 0) {
                    var index = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(index);
                    parent.location.reload();
                } else {
                    alert("修改失败");
                }
            }
        })
    }
</script>

<input type="hidden" name="ids" id="ids" value="<%=request.getParameter("ids")%>">
<input type="hidden" id="ptId">
<div class="layui-form">
    <div class="layui-form-item">
        <label class="layui-form-label">产品类型名称</label>
        <div class="layui-input-block">
            <input type="text" name="PtDescribe" id="PtDescribe" placeholder="请输入" autocomplete="off"
                   style="width: 200px"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo" onclick="ProducttypeEdit();">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</div>
</body>
</html>
