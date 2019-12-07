<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<%@ Import Namespace="QLNV.Models" %>
<% List<Get_Table_By_Staff_Result> list = (List<Get_Table_By_Staff_Result>)ViewData["list_staff"];%>
<script type="text/javascript">
    $(function () {
        var table = $('#staff_info').DataTable({
            dom: 'T<"clear">lfrtip',
            "scrollX": true,
            "language": {
                "decimal": ",",
                "thousands": "."
            },
            "lengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]],
            "scrollCollapse": true,
            'columnDefs': [{
                'targets': 0,
                'searchable': false,
                'orderable': false,
                'className': 'dt-body-center',
                'render': function (data, type, full, meta) {
                    return '<input type="checkbox" name="id[]" value="' + $('<div/>').text(data).html() + '">';
                }
            }],
            "tableTools": {
                "sSwfPath": "../Contents/css/datatables/swf/copy_csv_xls.swf"
            }
        });

        //checkbox
        $("#checkAll").click(function () {
            $(".checkitem").prop('checked', $(this).prop('checked'));
        });


        $(".checkitem").change(function () {
            if ($(this).prop("checked") == false) {
                $("#checkAll").prop("checked", false);
            }
            if ($(".checkitem:checked").length == $(".checkitem").length) {
                $("#checkAll").prop("checked", true);
            }
        });

        $("#btnDelete").click(function () {
            var count = $(".checkitem:checked").length;
            if (count == 0) {
                alert("Không có nhân viên được chọn để xóa !");
                return false;
            } else {
                return confirm(count + " nhân viên sẽ bị xóa");
            }
        })

        new $.fn.dataTable.FixedColumns(table, {
            leftColumns: 2
        });

        $('.panel').lobiPanel({
            reload: {
                icon: 'fa fa-refresh'
            },
            editTitle: {
                icon: 'fa fa-edit',
                icon2: 'fa fa-save'
            },
            unpin: {
                icon: 'fa fa-arrows'
            },
            minimize: {
                icon: 'fa fa-chevron-up',
                icon2: 'fa fa-chevron-down'
            },
            close: {
                icon: 'fa fa-times-circle'
            },
            expand: {
                icon: 'fa fa-expand',
                icon2: 'fa fa-compress'
            }

        });
    });
</script>
<div class="panel panel-info">
    <div class="panel-heading">
        <div class="panel-title">
            <h4>Danh sách nhân viên | <a id="btnDelete" class="btn btn-warning" title="Chọn nhân viên trước khi xóa"  data-backdrop="static"><i class="fa fa-close" aria-hidden="true"></i> Xóa</a></h4>
        </div>
    </div>
    <div class="panel-body">
        <div class="table-responsive">
            <table class="table table-striped table-bordered table-hover " id="staff_info">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="checkAll" /></th>
                        <th>Tools</th>
                        <th>Mã nhân viên</th>
                        <th>Họ và tên </th>
                        <th>Chức vụ</th>
                        <th>Địa chỉ</th>
                        <th>Ngày sinh</th>
                        <th>Giới tính</th>
                        <th>Trạng thái</th>
                        <th>Ngày tạo</th>
                        <th>Người tạo</th>
                    </tr>
                </thead>
                <tbody>
                    <%if (list != null && list.Count>0)
                        {
                            foreach (var item in list)
                            { %>
                    <tr>
                        <td><input style="text-align:center" type="checkbox" class="checkitem" name="staffIdDelete" id="staffIdDelete" value="<%=item.ID %>" /></td>
                        <td>
                            <a href="/Index/Staff_EditView/<%=item.ID %>" class="btn btn-sm btn-primary" data-backdrop="static" data-toggle="modal" data-target="#myModal"><i class="fa fa-edit"></i></a>
                            <a href="Javarscript:;" onclick="return Delete_Staff_Info(<%=item.ID%>);" class="btn btn-sm btn-danger"><i class="fa fa-remove"></i></a>
                        </td>
                        <td><%=item.Code_User %></td>
                        <td><%=item.Full_Name %></td>
                        <td><%=item.Department %></td>
                        <td><%=item.Place%></td>
                        <td><%=item.BirthDay.GetValueOrDefault().ToShortDateString()%></td>
                        <td><%=item.Gender %></td>
                        <td><%=item.Status %></td>
                        <td><%=item.CreateDate.GetValueOrDefault().ToShortDateString() %></td>
                        <td><%=item.CreateUser %></td>
                    </tr>
                    <% } %>
                    <%} %>
                </tbody>
                <tfoot>
                    <tr>
                        <th></th>
                        <th>Tools</th>
                        <th>Mã nhân viên</th>
                        <th>Họ và tên </th>
                        <th>Chức vụ</th>
                        <th>Địa chỉ</th>
                        <th>Ngày sinh</th>
                        <th>Giới tính</th>
                        <th>Trạng thái</th>
                        <th>Ngày tạo</th>
                        <th>Người tạo</th>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
    
</div>
<div id="myLogo" class="modal fade bs-example-modal-md">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="row no-padding ">
				<div class="col-md-12 padding-20">
					<img id="ori_logo" class="center-block" width="100%" height="auto" src="" />
				</div>
			</div>
			<div class="row no-padding margin-bottom-10">
				<div class="col-md-12">
					<button class="btn btn-danger center-block" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i>Close</button>
				</div>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>


<script type="text/javascript">

    
    function Delete_Staff_Info(id) {
        Lobibox.confirm({
            msg: "Xác Nhận Xóa Nhân Viên Này ?",
            callback: function ($this, type, ev) {
                if (type === 'yes') {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json",
                        dataType: "json",
                        url: '/Index/Event_Delete_Staff_Info/' + id ,
                        success: function (data) {
                            if (data.code == "0") {
                                Lobibox.alert("success",
                                    {
                                        msg: data.msg
                                    });
                                reload_admin_info_table();
                            } else {
                                Lobibox.alert("error",
                                    {
                                        msg: data.msg
                                    });
                            }
                        }
                    });
                }
            }
        });
    }
</script>

