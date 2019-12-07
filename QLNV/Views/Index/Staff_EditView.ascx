<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
    <%@ Import Namespace="QLNV.Models" %>
    <% Staff item = (Staff) ViewData["staff_info"];%>

    <form id="edit_staff_info" method="post" onsubmit="Event_Edit_Staff_Info();">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h3 class="modal-title" style="color: #00008b">Edit Staff Info</h3>
        </div>
        <div class="modal-body">
            <div class="row" style="padding-top: 10px">
                <div class="col-md-4">
                    <strong>Họ và tên <span style="color: red">*</span></strong>
                    <input type="text" id="Full_Name" name="Full_Name" class="form-control" required="required" value="<%=item.Full_Name %>" />
                    <input type="hidden" id="ID" name="ID" value="<%=item.ID %>" />
                    <input type="hidden" id="Code_User" name="Code_User" value="<%=item.Code_User %>" />
                </div>
                <div class="col-md-4">
                    <strong>Chức vụ <span style="color: red">*</span></strong>
                    <input type="text" id="Department" name="Department" class="form-control" value="<%=item.Department %>" />
                </div>
                <div class="col-md-4">
                    <strong>Địa điểm<span style="color: red">*</span></strong>
                    <input type="text" id="Place" name="Place" class="form-control" value="<%=item.Place %>" />
                </div>
            </div>
            <div class="row" style="padding-top: 10px">
                <div class="col-md-4">
                    <strong>Ngày sinh </strong>
                    <label class="input-group date">
                        <input type="text" id="BirthDay" placeholder="mm-yyyy" name="BirthDay" class="form-control date" value="<%=item.BirthDay.GetValueOrDefault().ToShortDateString()%>" />
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </label>
                </div>
                <div class="col-md-4">
                    <strong>Giới tính</strong>
                    <input type="text" class="form-control" name="Gender" id="Gender" value="<%=item.Gender %>" />
                </div>
                <div class="col-md-4">
                    <strong>Người tạo</strong>
                    <input type="text" class="form-control" name="CreateUser" id="CreateUser" value="<%=item.CreateUser %>" />
                </div>
            </div>
            


        </div>
        <div class="modal-footer">
            <button class="btn btn-primary" type="submit"><i class="fa fa-pencil" aria-hidden="true"></i>Edit</button>
            <a href="#" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i>Close</a>
        </div>
    </form>
    <script type="text/javascript">
    $(".date").datepicker({
        format: "dd/mm/yyyy"
    });

    function Event_Edit_Staff_Info() {
        var form = convert_SerializeArray_to_JSON('edit_staff_info');
        $.ajax({
            type: "POST",
            data: {data:JSON.stringify(form)},
            url: "/Index/Event_Add_Edit_Staff_Info",
            success: function (data) {
                if (data["code"] == "0") {
                    Lobibox.notify('success', {
                        img: '/Contents/img/check_thanhcong.png',
                        sound: false,
                        position: 'top right',
                        delay: 2000,
                        showClass: 'fadeInDown',
                        title: 'Message Success ',
                        msg: data['msg']
                    });
                    Load_Content();
                    $("#myModal .close").click();
                    reload_hcp_tableview();
                } else {
                    Lobibox.notify('error', {
                        img: '/Contents/img/check_warning.png',
                        sound: false,
                        position: 'top right',
                        delay: 2000,
                        showClass: 'fadeInDown',
                        title: 'Message Error ',
                        msg: data['msg']
                    });
                }
            },
            error: function () {
                Lobibox.alert(
                    'error', // Any of the following
                    {
                        msg: 'Have Error In Processing , Please try again ! '
                    }
                );
            }
        });
        return false;
    }
    </script>

