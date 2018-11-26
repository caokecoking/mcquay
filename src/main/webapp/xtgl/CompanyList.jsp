<%--
  Created by IntelliJ IDEA.
  User: 93525
  Date: 2018/11/26
  Time: 10:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<link rel="stylesheet" href="../layui/css/layui.css" media="all">
<script src="../layui/layui.js"></script>
<script type="text/html" id="barDemo">
    <a id="query" class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
    <html>
<head>
    <title>Title</title>
</head>
<body>
<table id="demo" lay-filter="test"></table>
<script>
    layui.use('table', function () {
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#demo',
            id: 'testReload'
            , height: 400
            , toolbar: 'default'
            , url: '/Company/findAll.action' //数据接口
            , page: true //开启分页
            , cols: [[ //表头
                {field: 'CompCoding', title: '分公司编码', width: '10%', sort: true, fixed: 'left'}
                , {field: 'CompName', title: '分公司名称', width: '15%'}
                , {field: 'CompAddress', title: '详细地址', width: '15%', sort: true}
                , {field: 'CompAttribute', title: '属性', width: '10%'}
                , {field: 'CompEmailAddress', title: '邮箱地址', width: '10%',templet:'#isPayment1'}
                , {field: 'CompEmailPassword', title: '邮箱密码', width: '15%', sort: true}
                , {fixed: 'right', title: '操作', width: '20%', align: 'center', toolbar: '#barDemo'}
            ]], limits: [5, 10, 15, 20],
            limit: 5

        });
        //数据重载（查询）
        var $ = layui.$, active = {
            reload: function () {
                var productName = $('#productName');
                var providerId = $('#providerName');
                var isPayment = $('#isPayment');
                //执行重载
                table.reload('testReload', {
                    url: '/Company/findAll.action',
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    , where: {
                        productName: productName.val(),
                        providerId: providerId.val(),
                        isPayment: isPayment.val()
                    }
                });
            }
        };
        $('.layui-inline').on('click',function(){
            layer.open({
                title: '增加',
                type : 2,
                content: 'CompanyAdd.jsp', //数组第二项即吸附元素选择器或者DOM
                area :['600px','400px']
            });
        });
        $('.search .layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        //监听行工具事件
        table.on('tool(test)', function (obj) { //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                , layEvent = obj.event; //获得 lay-event 对应的值
            if (layEvent === 'detail') {
                location.href = '/bill/findOnlyByBill1.action?id='+data.id;
            } else if (layEvent === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    location.href = '/bill/delete.action?id='+data.id;
                });
            } else if (layEvent === 'edit') {
                location.href = '/bill/findOnlyByBill.action?id='+data.id;
            }
        });


    });
</script>
</body>
</html>
