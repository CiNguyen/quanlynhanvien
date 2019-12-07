using QLNV.Models.Interface;


namespace QLNV.Models.Implement
{
    public class DatabaseFactory : IDatabaseFactory
    {
        public IDataContext GetDb()
        {
            return new QLNVContext();
        }
    }
}