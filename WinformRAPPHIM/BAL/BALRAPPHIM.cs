using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;

namespace BAL
{
    public class BALRAPPHIM
    {
        DALRAPPHIM db = null;
        public BALRAPPHIM()
        {
            db = new DALRAPPHIM();
        }
        public DataTable LayTatCaDoAn(ref string err)
        {
            return db.MyExecuteQuery("spDoAn", CommandType.StoredProcedure, ref err);
        }

    }
}