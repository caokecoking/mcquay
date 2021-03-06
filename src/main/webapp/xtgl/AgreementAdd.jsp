<%--
  Created by IntelliJ IDEA.
  User: 93525
  Date: 2018/11/28
  Time: 18:16
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
<br/>
<div class="layui-form">
    <div class="layui-form-item">
        <label class="layui-form-label">协议店名称</label>
        <div class="layui-input-block">
            <input type="text" placeholder="请输入协议店名称" id="AgreName" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">分公司名称</label>
        <div class="layui-input-block">
            <select id="Compid"></select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">详情地址</label>
        <div class="layui-input-block">
            <input type="text" placeholder="请输入详情地址" id="AgreAddress" autocomplete="off" class="layui-input">
        </div>
    </div>
</div>
<div class="layui-form-item">
    <label class="layui-form-label">省 / 市 / 县</label>
    <div class="layui-input-block">
        <div data-toggle="distpicker">
            <select id="Prov" style="height:35px"></select>
            <select id="Dist" style="height:35px"></select>
            <select id="Coun" style="height:35px"></select>
        </div>
    </div>
</div>
<div class="layui-form">
    <div class="layui-form-item">
        <label class="layui-form-label">负责人名称</label>
        <div class="layui-input-block">
            <input type="text" placeholder="请输入负责人名称" id="ChargeName" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">负责人电话</label>
        <div class="layui-input-block">
            <input type="text" placeholder="请输入负责人电话" id="ChargePhone" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">负责人邮箱</label>
        <div class="layui-input-block">
            <input type="text" placeholder="请输入负责人邮箱" id="ChargeEmail" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">传真号码</label>
        <div class="layui-input-block">
            <input type="text" placeholder="请输入传真号码" id="TeleFax" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">开户银行</label>
        <div class="layui-input-block">
            <input type="text" placeholder="请输入开户银行" id="DepositBank" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">银行账号</label>
        <div class="layui-input-block">
            <input type="text" placeholder="请输入银行账号" id="BankAccount" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">法人名称</label>
        <div class="layui-input-block">
            <input type="text" placeholder="请输入法人名称" id="CorpName" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">法人电话</label>
        <div class="layui-input-block">
            <input type="text" placeholder="请输入法人电话" id="CorpPhone" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">法人邮箱</label>
        <div class="layui-input-block">
            <input type="text" placeholder="请输入法人邮箱" id="CorpEmail" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">到期日期</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" id="AgreFinishTime">
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
            async: false,
            type: "POST",
            url: "/Company/findAll.action",
            dataType: "json",
            data: {
                page: 0,
                limit: 1000
            },
            success: function (res) {
                var opt = "<option value='' selected = \'selected\'>--请选择--</option>";
                $("#Compid").append(opt);
                for (var i = 0; i < res.data.length; i++) {
                    var option = "<option value=\"" + res.data[i].compid + "\"";
                    option += ">" + res.data[i].compName + "</option>"; //动态添加数据
                    $("#Compid").append(option);
                }
            }
        });
    });
    //Demo
    layui.use('form', function () {
        $('.layui-form .city').distpicker();
        var form = layui.form;
        layui.use('laydate', function () {
            var laydate = layui.laydate;
            //执行一个laydate实例
            laydate.render({
                elem: '#AgreFinishTime' //指定元素
            });
        });
        //监听提交
        form.on('submit(formDemo)', function (data1) {
            $.ajax({
                type: "POST",
                url: "/Agreement/addAgreement.action",
                data: {
                    AgreName: $('#AgreName').val(),
                    Name: $('#Compid').val(),
                    AgreAddress: $('#AgreAddress').val(),
                    Prov: $('#Prov').val(),
                    Dist: $('#Dist').val(),
                    Coun: $('#Coun').val(),
                    ChargeName: $('#ChargeName').val(),
                    ChargePhone: $('#ChargePhone').val(),
                    ChargeEmail: $('#ChargeEmail').val(),
                    TeleFax: $('#TeleFax').val(),
                    DepositBank: $('#DepositBank').val(),
                    BankAccount: $('#BankAccount').val(),
                    CorpName: $('#CorpName').val(),
                    CorpPhone: $('#CorpPhone').val(),
                    CorpEmail: $('#CorpEmail').val(),
                    AgreFinishTime: $('#AgreFinishTime').val()
                },
                dataType: "text",
                success: function (data) {
                    if (data == 1) {
                        var index = parent.layer.getFrameIndex(window.name);
                        parent.layer.close(index);
                        parent.location.reload();
                    } else if (data == 2) {
                        layer.msg('该地区已有协议店');
                    } else if (data == 3) {
                        layer.msg('该省没有分公司');
                    }
                }
            });
        });

    });
</script>

</body>
</html>

