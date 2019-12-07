using System;
using System.Collections.Generic;
using System.Linq;
using QLNV.Models;
using QLNV.Models.Interface;
using QLNV.Models.Implement;

namespace QLNV.Services.Base
{
    public class ServiceStoreProduce
    {
        private static ServiceStoreProduce _instance { get; set; }
        private static IDataContext DataContext { get; set; }
        private static IDatabaseFactory DatabaseFactory { get; set; }

        public static ServiceStoreProduce Instance()
        {
            DatabaseFactory = new DatabaseFactory();
            DataContext = DatabaseFactory.GetDb();
            _instance = new ServiceStoreProduce();
            return ServiceStoreProduce._instance;
        }

        internal List<string> List_Select_Place()
        {
            var temp = DataContext.Database().SqlQuery<string>("Get_List_Place_Staff").ToList();

            return temp;
        }

        internal List<Get_Table_By_Staff_Result> List_Staff_Info()
        {
            var temp = DataContext.Database().SqlQuery<Get_Table_By_Staff_Result>("Get_Table_By_Staff").ToList();

            return temp;
        }
    }
}