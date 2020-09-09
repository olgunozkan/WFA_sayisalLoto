using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MetroFramework.Forms;

namespace WFA_SayisalLoto
{
    public partial class Form1 : MetroForm
    {
        public Form1()
        {
            InitializeComponent();
        }
        private void Form1_Load(object sender, EventArgs e)
        {
            timer1.Stop();
        }
        private void metroTile1_Click(object sender, EventArgs e)
        {
          
            if (timer1.Enabled)
            { 
                textBox1.Text = textBox2.Text = textBox3.Text = textBox4.Text = textBox5.Text = textBox6.Text = "0";
                sayac1 = diziYazdir = elemanArama =  i = 0;                
                timer1.Stop();
            }
            else
                timer1.Start();

        }
        Random      rdm = new Random();
        int elemanArama = 0;
        int           i = 0;
        int      sayac1 = 0;
        int  diziYazdir = 0;
        int[]      dizi = { };
        int[]  copyDizi = new int[6];
        
       
        private void timer1_Tick(object sender, EventArgs e)
        {   
            //Kullanıcı çekiliş yap butonuna tıkladığında sol baştan başlayarak, 1 ile 49 arasında(49 dahil) sayı üretecek.
            if (sayac1 < 11)
            {
                textBox1.Text = Convert.ToString(rdm.Next(1, 50));
                textBox2.Text = Convert.ToString(rdm.Next(1, 50));
                textBox3.Text = Convert.ToString(rdm.Next(1, 50));
                textBox4.Text = Convert.ToString(rdm.Next(1, 50));
                textBox5.Text = Convert.ToString(rdm.Next(1, 50));
                textBox6.Text = Convert.ToString(rdm.Next(1, 50));
                sayac1++;

                // Her bir kutuda toplamda 10 adet sayı gösterildikten sonra, 10.üretilen sayı ekrana sabitlecek ve dizi içerisinde tutulacak.
                if (sayac1 == 10)
                {
                    Array.Resize(ref dizi, 6);
                    dizi[i] = Convert.ToInt32(textBox1.Text);
                    dizi[++i] = Convert.ToInt32(textBox2.Text);
                    dizi[++i] = Convert.ToInt32(textBox3.Text);
                    dizi[++i] = Convert.ToInt32(textBox4.Text);
                    dizi[++i] = Convert.ToInt32(textBox5.Text);
                    dizi[++i] = Convert.ToInt32(textBox6.Text);
                    sayac1++;

                    //Ikinci kutudan itibaren 10. sırada gelen sayı daha önce üretildiyse, yeni bir sayı üretilecek ve benzersiz olana kadar bu işlem devam edecek.
                    while (elemanArama < 6)
                    {

                        Array.Copy(dizi, copyDizi, 6);
                        Array.Clear(copyDizi, elemanArama, 1);
                        if (Array.IndexOf(copyDizi, dizi[elemanArama]) != -1)
                        {
                            dizi[elemanArama] = rdm.Next(1, 50);

                            if (elemanArama == 0)
                                textBox1.Text = Convert.ToString(dizi[elemanArama]);
                            if (elemanArama == 1)
                                textBox2.Text = Convert.ToString(dizi[elemanArama]);
                            if (elemanArama == 2)
                                textBox3.Text = Convert.ToString(dizi[elemanArama]);
                            if (elemanArama == 3)
                                textBox4.Text = Convert.ToString(dizi[elemanArama]);
                            if (elemanArama == 4)
                                textBox5.Text = Convert.ToString(dizi[elemanArama]);
                            if (elemanArama == 5)
                                textBox6.Text = Convert.ToString(dizi[elemanArama]);
                        }                      
                        ++elemanArama;
                    }
                    //kutuda benzersiz sayı üretildikten sonra küçükten büyüğe doğru sıralama yapılacak ve ekrana yazdırılacak.
                    Array.Sort(dizi);
                    if (diziYazdir == 0)
                       textBox1.Text = Convert.ToString(dizi[diziYazdir++]);
                    if (diziYazdir == 1)
                       textBox2.Text = Convert.ToString(dizi[diziYazdir++]);
                    if (diziYazdir == 2)
                       textBox3.Text = Convert.ToString(dizi[diziYazdir++]);
                    if (diziYazdir == 3)
                       textBox4.Text = Convert.ToString(dizi[diziYazdir++]);
                    if (diziYazdir == 4)
                       textBox5.Text = Convert.ToString(dizi[diziYazdir++]);
                    if (diziYazdir == 5)
                       textBox6.Text = Convert.ToString(dizi[diziYazdir]);                    
                }
            }

        }            
    }
 }