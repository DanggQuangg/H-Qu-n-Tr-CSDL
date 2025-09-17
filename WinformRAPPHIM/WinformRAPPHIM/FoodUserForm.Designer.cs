namespace WinformRAPPHIM
{
    partial class FoodUserForm
    {
        /// <summary> 
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.pbAnh = new Guna.UI2.WinForms.Guna2PictureBox();
            this.lbTenDoAn = new System.Windows.Forms.Label();
            this.lbLoaiDoAn = new System.Windows.Forms.Label();
            this.backgroundWorker1 = new System.ComponentModel.BackgroundWorker();
            this.lbGiaTien = new System.Windows.Forms.Label();
            this.lbSoLuong = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.pbAnh)).BeginInit();
            this.SuspendLayout();
            // 
            // pbAnh
            // 
            this.pbAnh.Location = new System.Drawing.Point(3, 3);
            this.pbAnh.Name = "pbAnh";
            this.pbAnh.ShadowDecoration.Parent = this.pbAnh;
            this.pbAnh.Size = new System.Drawing.Size(92, 92);
            this.pbAnh.TabIndex = 0;
            this.pbAnh.TabStop = false;
            // 
            // lbTenDoAn
            // 
            this.lbTenDoAn.AutoSize = true;
            this.lbTenDoAn.Font = new System.Drawing.Font("Microsoft Sans Serif", 13.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbTenDoAn.Location = new System.Drawing.Point(101, 5);
            this.lbTenDoAn.Name = "lbTenDoAn";
            this.lbTenDoAn.Size = new System.Drawing.Size(131, 29);
            this.lbTenDoAn.TabIndex = 1;
            this.lbTenDoAn.Text = "Tên đồ ăn";
            // 
            // lbLoaiDoAn
            // 
            this.lbLoaiDoAn.AutoSize = true;
            this.lbLoaiDoAn.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbLoaiDoAn.Location = new System.Drawing.Point(101, 36);
            this.lbLoaiDoAn.Name = "lbLoaiDoAn";
            this.lbLoaiDoAn.Size = new System.Drawing.Size(103, 25);
            this.lbLoaiDoAn.TabIndex = 2;
            this.lbLoaiDoAn.Text = "Loại đồ ăn";
            // 
            // lbGiaTien
            // 
            this.lbGiaTien.AutoSize = true;
            this.lbGiaTien.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbGiaTien.Location = new System.Drawing.Point(101, 65);
            this.lbGiaTien.Name = "lbGiaTien";
            this.lbGiaTien.Size = new System.Drawing.Size(78, 25);
            this.lbGiaTien.TabIndex = 3;
            this.lbGiaTien.Text = "Giá tiền";
            // 
            // lbSoLuong
            // 
            this.lbSoLuong.AutoSize = true;
            this.lbSoLuong.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbSoLuong.Location = new System.Drawing.Point(432, 70);
            this.lbSoLuong.Name = "lbSoLuong";
            this.lbSoLuong.Size = new System.Drawing.Size(79, 25);
            this.lbSoLuong.TabIndex = 4;
            this.lbSoLuong.Text = "Còn lại:";
            // 
            // FoodUserForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.lbSoLuong);
            this.Controls.Add(this.lbGiaTien);
            this.Controls.Add(this.lbLoaiDoAn);
            this.Controls.Add(this.lbTenDoAn);
            this.Controls.Add(this.pbAnh);
            this.Name = "FoodUserForm";
            this.Size = new System.Drawing.Size(517, 99);
            ((System.ComponentModel.ISupportInitialize)(this.pbAnh)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Guna.UI2.WinForms.Guna2PictureBox pbAnh;
        private System.Windows.Forms.Label lbTenDoAn;
        private System.Windows.Forms.Label lbLoaiDoAn;
        private System.ComponentModel.BackgroundWorker backgroundWorker1;
        private System.Windows.Forms.Label lbGiaTien;
        private System.Windows.Forms.Label lbSoLuong;
    }
}
