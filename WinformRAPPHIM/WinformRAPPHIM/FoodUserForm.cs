using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Net.Http;
using System.IO;
using System.Text.Json;
using Guna.UI2.WinForms.Suite;
using static System.Net.WebRequestMethods;
namespace WinformRAPPHIM
{
    public partial class FoodUserForm : UserControl
    {

        public FoodUserForm()
        {
            InitializeComponent();
            // Khi khởi tạo form (để ảnh fit khung):
            pbAnh.SizeMode = PictureBoxSizeMode.Zoom;
            pbAnh.WaitOnLoad = false;   // không block UI

            // Ở nơi bạn có URL (từ DB hoặc sau khi upload):
            string url = "https://res.cloudinary.com/dqsyfabrp/image/upload/v1757908429/matbiec_chhxwd.jpg";
            try
            {
                if (!string.IsNullOrWhiteSpace(url))
                    pbAnh.LoadAsync(url);   // tải trực tiếp từ Cloudinary
                else
                    pbAnh.Image = null;
            }
            catch
            {
                pbAnh.Image = null; // hoặc ảnh placeholder
            }

        }
    }
}
