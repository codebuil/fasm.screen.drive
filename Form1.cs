namespace transformer
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Application.DoEvents();
            int n = 0;
            int nn = 0;
            string s = "";
            s = s + "#include<stdio.h>\r\n#include<stdlib.h>\r\n\r\n\r\n";
            string[] sss = textBox1.Text.Split("\r\n");
            for (n = 0; n < sss.Length; n++)
            {
                string[] ssss = sss[n].Split(";");
                for (nn = 0; nn < ssss.Length; nn++)
                {
                    s = s + ssss[nn]+"\r\n";
                }
                
            }
            s = s + "int main(){\r\nBeforeRun()\r\nRun()\r\n}\r\n";
            Application.DoEvents();
            textBox2.Text = s;
        }
    }
}