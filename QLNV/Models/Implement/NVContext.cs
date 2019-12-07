using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Web;
using QLNV.Models;
using QLNV.Models.Interface;

namespace QLNV.Models.Implement
{
    public class QLNVContext : QLNVEntities, IDataContext
    {
        public int Commit()
        {
            return SaveChanges();
        }

        public IDbSet<T> DbSet<T>() where T : class
        {
            return Set<T>();
        }

        public DbEntityEntry<T> EntityEntry<T>(T item) where T : class
        {
            return Entry<T>(item);
        }

        System.Data.Entity.Database IDataContext.Database()
        {
            return Database;
        }
    }
    
}