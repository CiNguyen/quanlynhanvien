using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace QLNV.Models.Interface
{
    public interface IDatabaseFactory
    {
        IDataContext GetDb();
    }
}
