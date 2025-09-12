using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WinformRAPPHIM
{
    public partial class Form1 : Form
    {
        //Trường:
        //string strConn = "Data Source=DESKTOP-0KPRSEV;Initial Catalog=QUANLYRAPPHIM;Integrated Security=True;Encrypt=False";
        //Khánh:
        //string strConn = "Data Source=DESKTOP-0KPRSEV;Initial Catalog=QUANLYRAPPHIM;Integrated Security=True;Encrypt=False";
        //Tùng:
        //string strConn = "Data Source=DESKTOP-0KPRSEV;Initial Catalog=QUANLYRAPPHIM;Integrated Security=True;Encrypt=False";
        //Quang:
        string strCon = "Data Source=DESKTOP-0KPRSEV;Initial Catalog=QUANLYRAPPHIM;Integrated Security=True;Encrypt=False";
        SqlConnection sqlCon= null;
        public Form1()
        {
            InitializeComponent();
        }

        private void btnMoketnoi_Click(object sender, EventArgs e)
        {
            try
            {
                if (sqlCon == null)
                {
                    sqlCon = new SqlConnection(strCon);
                }
                if (sqlCon.State == ConnectionState.Closed)
                {
                    sqlCon.Open();
                    MessageBox.Show("Kết nối thành công");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnDongketnoi_Click(object sender, EventArgs e)
        {
            if(sqlCon != null && sqlCon.State == ConnectionState.Open)
            {
                sqlCon.Close();
                MessageBox.Show("Đóng kết nối thành công");
            }
            else
            {
                MessageBox.Show("Kết nối SQL đã đóng");
            }
        }
    }
}
