using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class DALRAPPHIM
    {
        string ConnStr = "Data Source=DESKTOP-0KPRSEV;Initial Catalog=QUANLYRAPPHIM;Integrated Security=True";
        SqlConnection conn = null;
        SqlCommand comm = null;
        SqlDataAdapter da = null;
        // Constructor
        public DALRAPPHIM()
        {
            conn = new SqlConnection(ConnStr);
            comm = conn.CreateCommand();
        }
        // Khai bao ham thuc thi tang ket noi
        public DataSet ExecuteQueryDataSet(string strSQL, CommandType ct, params SqlParameter[] p)
        {
            if (conn.State == ConnectionState.Open)
                conn.Close();
            conn.Open();
            comm.CommandText = strSQL;
            comm.CommandType = ct;
            comm.Parameters.Clear(); // Xóa tham số cũ để tránh lỗi
            if (p != null)
                comm.Parameters.AddRange(p); // Truyền tham số vào câu lệnh SQL
            da = new SqlDataAdapter(comm);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close(); // Đóng kết nối sau khi truy vấn xong
            return ds;
        }

        // Action Query = Insert | Delete | Update | Stored Procedure
        public bool MyExecuteNonQuery(string strSQL, CommandType ct, ref string error, params SqlParameter[] param)
        {
            bool f = false;
            try
            {
                if (conn.State == ConnectionState.Open)
                    conn.Close();
                conn.Open();
                comm.Parameters.Clear(); // Xóa tham số cũ trước khi thêm mới
                comm.CommandText = strSQL;
                comm.CommandType = ct;
                if (param != null)
                    comm.Parameters.AddRange(param);

                comm.ExecuteNonQuery();
                f = true;
            }
            catch (SqlException ex)
            {
                error = ex.Message;
            }
            finally
            {
                conn.Close(); // Đóng kết nối sau khi hoàn thành
            }
            return f;
        }
        public DataTable MyExecuteQuery(string query, CommandType cmdType, ref string err, params SqlParameter[] parameters)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(ConnStr))
            {
                try
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.CommandType = cmdType;
                        if (parameters != null)
                            cmd.Parameters.AddRange(parameters);

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                }
                catch (Exception ex)
                {
                    err = ex.Message;
                }
            } // Kết nối sẽ tự động đóng khi thoát khỏi `using`
            return dt;
        }
    }
}
