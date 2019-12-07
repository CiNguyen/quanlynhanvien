using QLNV.Models;
using QLNV.Services;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Xml.Serialization;
using QLNV.Services.Base;

namespace QLNV.Controllers
{
    public class IndexController : Controller
    {
        // GET: Index
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Staff_Info()
        {
            return PartialView();
        }

        public ActionResult Staff_TableView()
        {
            var list = ServiceStoreProduce.Instance().List_Staff_Info();
            ViewData["list_staff"] = list;
            return PartialView();
        }

        public ActionResult Staff_CreateView()
        {
            return PartialView();
        }

        public JsonResult Select_List_Place(string text, string value)
        {
            var temp = ServiceStoreProduce.Instance().List_Select_Place().ToList();

            List<SelectListItem> list = new List<SelectListItem>();

            foreach (var item in temp)
            {
                list.Add(new SelectListItem
                {
                    Text = item,
                    Value = item
                });
            }

            return Json(list);
        }


        public ActionResult Event_Add_Edit_Staff_Info(string data)
        {
            Message ms = new Message();
            Staff staff = JsonConvert.DeserializeObject<Staff>(data);
            staff.Status = "Actived";
            staff.CreateDate = System.DateTime.Now;
            staff.CreateUser = "Admin";
            ms = Services_Staff.Instance().Event_Add_Edit_Staff_Info(staff);
            return Json(ms);
        }

        public ActionResult Staff_EditView(int id)
        {
            var data = Services_Staff.Instance().Get(a => a.ID == id);

            ViewData["staff_info"] = data;
            return PartialView();
        }

        [HttpPost]
        public JsonResult Event_Delete_Staff_Info(string id)
        {
            var result = Services_Staff.Instance().Event_Delete_Staff_Info(id);

            return Json(result);
        }
    }
}