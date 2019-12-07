using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QLNV.Models;
using QLNV.Services.Base;

namespace QLNV.Services
{
    public class Services_Staff : QLNVServices<Staff>
    {
        #region Config

        public static Services_Staff _instance { get; set; }
        public static Services_Staff Instance()
        {
            _instance = new Services_Staff(ServiceControtor<Staff>.Instance());
            return Services_Staff._instance;
        }
        public Services_Staff(ServiceControtor<Staff> controtor)
            : base(controtor)
        { }

        #endregion

        // event add nhan vien
        internal Message Event_Add_Edit_Staff_Info(Staff data)
        {
            Message ms = new Message();
            try
            {
                var check = (this).Get(a => a.ID == data.ID && a.Code_User == data.Code_User);
                if (check != null)
                {
                    check.Code_User = data.Code_User;
                    check.Full_Name = data.Full_Name;
                    check.Department = data.Department;
                    check.Place = data.Place;
                    check.Gender = data.Gender;
                    check.Status = "Actived";
                    check.CreateDate = data.CreateDate;
                    check.CreateUser = data.CreateUser;

                    (this).Update(check);

                    ms.code = "0";
                    ms.msg = "Cập nhật nhân viên thành công !";
                    ms.sub_code = data.ID.ToString();

                    return ms;
                    
                }
                data.Status = "Actived";
                data.CreateDate = System.DateTime.Now;
                data.Code_User = "US_" + data.ID.ToString();
                (this).Add(data);

                ms.code = "0";
                ms.msg = "Thêm thông tin nhân viên thành công !";
                ms.sub_code = data.ID.ToString();
                return ms;
            }
            catch (Exception ex)
            {
                ms.code = "1";
                ms.msg = ex.Message;
                return ms;
            }
        }
        

        internal Message Event_Delete_Staff_Info(string id)
        {
            Message ms = new Message();
            try
            {
                int idInfo = int.Parse(id);
                var check = (this).Get(a => a.ID == idInfo);
                if (check == null)
                {
                    ms.code = "1";
                    ms.msg = "Dữ Liệu Không Tồn Tại Trong Hệ Thống";
                    return ms;
                }

                check.Status = "Deleted";
                check.CreateDate = System.DateTime.Now;

                (this).Update(check);

                ms.code = "0";
                ms.msg = "Xóa Nhân Viên Thành Công !";
                ms.sub_code = check.ID.ToString();
                return ms;
            }
            catch (Exception ex)
            {
                ms.code = "1";
                ms.msg = ex.Message;

                return ms;
            }
        }

        internal int Get_ID_Event(int id_event)
        {
            var item = Get(r => r.ID == id_event);
            if (item != null)
            {
                return item.ID;
            }
            else
            {
                return 0;
            }
        }

    }
}