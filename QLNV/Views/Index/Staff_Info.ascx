<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<section>
       <div id="ribbon" class="hidden-print">
                <ol class="breadcrumb"><li class="active"><i class="fa fa-share-alt menu-item-icon"></i> Quản lý nhân viên</li></ol>
                <a href="/Index/Staff_CreateView" class="btn-sm btn-info" data-backdrop="static" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus" aria-hidden="true"></i> Thêm mới</a>
            </div>
    <div id="content" class="row">

    </div>
</section>

<script type="text/javascript">
    $(function () {
        Load_Content();
        done_load();
    });
    function Load_Content(province) {
        $("#content").load("/Index/Staff_TableView", { 'province': province });
    }
</script>

