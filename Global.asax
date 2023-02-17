

 protected void Application_BeginRequest(object sender, EventArgs e)  //İşi yapacağınız yer tamda bu method.
        {

           
            var currentUrl = HttpContext.Current.Request.Url.AbsoluteUri.ToString();
            var link = HttpContext.Current.Request.Url.AbsolutePath.ToString();
            string currenturldecode = HttpUtility.UrlDecode(currentUrl);
            string linkdecode = HttpUtility.UrlDecode(link);
            using (EcommerceEntities db = new EcommerceEntities()) //Entity Framework Kodu
            {
                var IsKey = db.RedirectTable.FirstOrDefault(x => x.KeyData == linkdecode);  
                //Redirect tablosu veritabnaında oluşturduğum yönlendirmeleri tutacağım key vlaue şeklinde bir tablo,
                //içine verileri özneli bir admin çalışması ile dolduruyoruz
                // Google da sıralmamaızı kaybetmek istmeiyoruz ama linkleri dğeiştirmek zorundayız bunu mutlaka yapmamız gerekiyor
                if (IsKey != null && IsKey.Id > 0)  //eğer istek gelen url bu tabloda varsa çaktırmadan karşılığına gelen yeni url'e 301 yönlendirmesi şeklinde basıyoruz.
                {

                    Response.Status = "301 Moved Permanently";
                    Response.StatusCode = 301;
                    Response.AddHeader("Location", currenturldecode.Replace(IsKey.KeyData, IsKey.Value));
                    Response.End();

                }
            }

        }

Hepsi bukadar web configde satır sayısı kısıtlı IIS üzerindne ekelyebiliriz elbette yönlendirmeleri ancak 2000 urlli
kocaman bir sitenin url yönlendirmesi web confiğe sığmaz :)
