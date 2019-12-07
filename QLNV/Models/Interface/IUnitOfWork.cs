using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QLNV.Models.Interface
{
    public interface IUnitOfWork
    {
        int Commit();
    }
}