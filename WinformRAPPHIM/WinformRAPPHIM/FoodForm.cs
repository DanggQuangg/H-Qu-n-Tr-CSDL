using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using BAL;
using DAL;
namespace WinformRAPPHIM
{
    public partial class FoodForm : Form
    {
        BALRAPPHIM dbRapPhim;
        DataTable Food;
        public FoodForm()
        {
            string err2;
            InitializeComponent();
            string err = "";
            dbRapPhim = new BALRAPPHIM();
            Food = dbRapPhim.LayTatCaDoAn(ref err);

        }

    }
}
