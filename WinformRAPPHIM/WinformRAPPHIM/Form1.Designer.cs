namespace WinformRAPPHIM
{
    partial class Form1
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

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnMoketnoi = new Guna.UI2.WinForms.Guna2Button();
            this.btnDongketnoi = new Guna.UI2.WinForms.Guna2Button();
            this.SuspendLayout();
            // 
            // btnMoketnoi
            // 
            this.btnMoketnoi.CheckedState.Parent = this.btnMoketnoi;
            this.btnMoketnoi.CustomImages.Parent = this.btnMoketnoi;
            this.btnMoketnoi.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.btnMoketnoi.ForeColor = System.Drawing.Color.White;
            this.btnMoketnoi.HoverState.Parent = this.btnMoketnoi;
            this.btnMoketnoi.Location = new System.Drawing.Point(138, 147);
            this.btnMoketnoi.Name = "btnMoketnoi";
            this.btnMoketnoi.ShadowDecoration.Parent = this.btnMoketnoi;
            this.btnMoketnoi.Size = new System.Drawing.Size(180, 45);
            this.btnMoketnoi.TabIndex = 0;
            this.btnMoketnoi.Text = "Mở kết nối";
            this.btnMoketnoi.Click += new System.EventHandler(this.btnMoketnoi_Click);
            // 
            // btnDongketnoi
            // 
            this.btnDongketnoi.CheckedState.Parent = this.btnDongketnoi;
            this.btnDongketnoi.CustomImages.Parent = this.btnDongketnoi;
            this.btnDongketnoi.Font = new System.Drawing.Font("Segoe UI", 9F);
            this.btnDongketnoi.ForeColor = System.Drawing.Color.White;
            this.btnDongketnoi.HoverState.Parent = this.btnDongketnoi;
            this.btnDongketnoi.Location = new System.Drawing.Point(378, 147);
            this.btnDongketnoi.Name = "btnDongketnoi";
            this.btnDongketnoi.ShadowDecoration.Parent = this.btnDongketnoi;
            this.btnDongketnoi.Size = new System.Drawing.Size(180, 45);
            this.btnDongketnoi.TabIndex = 1;
            this.btnDongketnoi.Text = "Đóng kết nối";
            this.btnDongketnoi.Click += new System.EventHandler(this.btnDongketnoi_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.btnDongketnoi);
            this.Controls.Add(this.btnMoketnoi);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);

        }

        #endregion

        private Guna.UI2.WinForms.Guna2Button btnMoketnoi;
        private Guna.UI2.WinForms.Guna2Button btnDongketnoi;
    }
}

