using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Media;
using System.Windows.Forms;

namespace WPA_Ganyan200
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            SoundPlayer soundPlayer = new SoundPlayer($@"{Environment.CurrentDirectory}\..\..\Content\music.wav");
            soundPlayer.Play();
            pctBir.Size = new Size(200,150);
            pctBir.Location = new Point(-192, 20);
            pctIki.Size = new Size(200, 10);
            pctIki.Location = new Point(6, 345);
            //pctUc.Size = new Size(200, 150);
            //pctUc.Location = new Point(-192, 20);
        }

        int pctUcLocY = 163;
        int index = 0;        
        int pctBirLoc = 535;
        int pctIkiLoc = 345;
        int pctUcLocX = -193;
        private void timer1_Tick(object sender, EventArgs e)
        {
            pctUcLocY--;
            index++;
            pctBirLoc--;
            pctIkiLoc--;
            pctUcLocX++;
            

            if (index<=155)
                pctBir.Location = new Point(6, pctBirLoc);

            if (index <= 150)
            {
                pctIki.Size = new Size(200, index);
                pctIki.Location = new Point(3, pctIkiLoc);
            }

            if (pctUcLocX <= -50)

            {
                pctUc.Location = new Point(pctUcLocX, pctUcLocY);
                if (index <= 150)
                    pctUc.Size = new Size(200, index);
            }

            else if (pctUcLocX <= 6)
            {
                pctUcLocY++;
                pctUc.Location = new Point(pctUcLocX, pctUcLocY);
                if (index <= 150)
                    pctUc.Size = new Size(200, index);

            }
          
        }
            
    }
}
