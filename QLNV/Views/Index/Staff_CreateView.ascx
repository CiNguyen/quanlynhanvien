<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<form id="add_new_staff_info" method="post" onsubmit="Event_Add_Staff_Info();">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h3 class="modal-title" style="color: #00008b">Thêm nhân viên mới</h3>
    </div>
    <div class="modal-body">
        <div class="row" style="padding-top: 10px">
            <div class="col-md-4">
                <strong>Họ và tên <span style="color: red">*</span></strong>
                <input type="text" id="Full_Name" name="Full_Name" class="form-control" required="required" />
            </div>
            <div class="col-md-4">
                <strong>Chức vụ <span style="color: red">*</span></strong>
                <input type="text" id="Department" name="Department" class="form-control" />
            </div>
            <div class="col-md-4">
                <strong>Địa chỉ <span style="color: red">*</span></strong>
           <select id="Place" name="Place" class="form-control">
                <option value="" >Chọn địa chỉ </option>
            </select>
            </div>
        </div>
        <div class="row" style="padding-top: 10px">
            <div class="col-md-4">
                <strong>Ngày sinh</strong>
                <label class="input-group date">
                    <input type="text" id="BirthDay" placeholder="dd-mm-yyyy" name="BirthDay" class="form-control date" />
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </label>
            </div>
            <div class="col-md-4">
                <strong>Giới tính</strong>
                <input type="text" id="Gender" name="Gender" class="form-control" />
            </div>
        </div>

    </div>
    <div class="modal-footer">
        <button class="btn btn-primary" type="submit"><i class="fa fa-plus" aria-hidden="true"></i>Add</button>
        <a href="#" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times" aria-hidden="true"></i>Close</a>
    </div>
</form>
<script type="text/javascript">
    $(".date").datepicker({
        format: "dd/mm/yyyy"
    });
    
    $("#Place").select2({
        width: '100%',
        placeholder: 'Chọn địa điểm'
    });

    $.ajax({
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        type: 'POST',
        url: "/Index/Select_List_Place",
        success: function (res) {
            $("#Place").empty();
            res = $.map(res,
                function (item, a) {
                    return "<option value='" +
                        item.Value +
                        "' " +
                        (item.Selected ? "" : "") +
                        ">" +
                        item.Text +
                        "</option>";
                });
            $("#Place").html(res.join(""));
        }
    });

    function Event_Add_Staff_Info() {
        var form = convert_SerializeArray_to_JSON('add_new_staff_info');
        $.ajax({
            type: "POST",
            data: {data: JSON.stringify(form)},
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
                    $('#myModal').modal('hide');
                    Load_Content();
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

