namespace WPA_Ganyan200
{
    partial class Form1
    {
        /// <summary>
        ///Gerekli tasarımcı değişkeni.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///Kullanılan tüm kaynakları temizleyin.
        /// </summary>
        ///<param name="disposing">yönetilen kaynaklar dispose edilmeliyse doğru; aksi halde yanlış.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer üretilen kod

        /// <summary>
        /// Tasarımcı desteği için gerekli metot - bu metodun 
        ///içeriğini kod düzenleyici ile değiştirmeyin.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.pctUc = new System.Windows.Forms.PictureBox();
            this.pctIki = new System.Windows.Forms.PictureBox();
            this.pctBir = new System.Windows.Forms.PictureBox();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.pctUc)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pctIki)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pctBir)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.BackColor = System.Drawing.Color.White;
            this.label1.Location = new System.Drawing.Point(923, 58);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(10, 481);
            this.label1.TabIndex = 0;
            // 
            // label2
            // 
            this.label2.BackColor = System.Drawing.Color.White;
            this.label2.Location = new System.Drawing.Point(3, 536);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(930, 12);
            this.label2.TabIndex = 1;
            // 
            // label3
            // 
            this.label3.BackColor = System.Drawing.Color.White;
            this.label3.Location = new System.Drawing.Point(3, 176);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(918, 10);
            this.label3.TabIndex = 2;
            // 
            // label4
            // 
            this.label4.BackColor = System.Drawing.Color.White;
            this.label4.Location = new System.Drawing.Point(3, 359);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(929, 10);
            this.label4.TabIndex = 3;
            // 
            // label5
            // 
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.label5.ForeColor = System.Drawing.Color.White;
            this.label5.ImageAlign = System.Drawing.ContentAlignment.TopLeft;
            this.label5.Location = new System.Drawing.Point(874, 20);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(101, 17);
            this.label5.TabIndex = 7;
            this.label5.Text = "Start";
            this.label5.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            // 
            // pctUc
            // 
            this.pctUc.Image = global::WPA_Ganyan200.Properties.Resources.h3;
            this.pctUc.Location = new System.Drawing.Point(-192, 163);
            this.pctUc.Name = "pctUc";
            this.pctUc.Size = new System.Drawing.Size(200, 10);
            this.pctUc.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pctUc.TabIndex = 6;
            this.pctUc.TabStop = false;
            // 
            // pctIki
            // 
            this.pctIki.Image = global::WPA_Ganyan200.Properties.Resources.h2;
            this.pctIki.Location = new System.Drawing.Point(6, 345);
            this.pctIki.Name = "pctIki";
            this.pctIki.Size = new System.Drawing.Size(200, 10);
            this.pctIki.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pctIki.TabIndex = 5;
            this.pctIki.TabStop = false;
            // 
            // pctBir
            // 
            this.pctBir.Image = global::WPA_Ganyan200.Properties.Resources.h1;
            this.pctBir.Location = new System.Drawing.Point(-5, 536);
            this.pctBir.Name = "pctBir";
            this.pctBir.Size = new System.Drawing.Size(200, 150);
            this.pctBir.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pctBir.TabIndex = 4;
            this.pctBir.TabStop = false;
            // 
            // timer1
            // 
            this.timer1.Enabled = true;
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.DarkGreen;
            this.ClientSize = new System.Drawing.Size(987, 548);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.pctUc);
            this.Controls.Add(this.pctIki);
            this.Controls.Add(this.pctBir);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.pctUc)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pctIki)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pctBir)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.PictureBox pctBir;
        private System.Windows.Forms.PictureBox pctIki;
        private System.Windows.Forms.PictureBox pctUc;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Timer timer1;
    }
}

