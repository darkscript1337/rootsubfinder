Subdomain tespit uygulaması

Bu uygulama, bir domain için subdomain'leri tespit eder ve bu subdomain'lerin aktif olup olmadığını hem HTTP(S) isteği yaparak hem de ping ile kontrol eder. Subdomain'ler SecurityTrails API'sinden çekilir ve çift kontrol yöntemiyle aktiflik durumu belirlenir.

Kullanılan kütüphaneler:
1. **httparty**: HTTP istekleri yapmak için kullanılır. API'ye istek gönderir ve yanıtları alır.
   - İndirme komutu: `gem install httparty`
   
2. **json**: API'den gelen yanıtları JSON formatında işlemek için kullanılır.
   - İndirme komutu: `gem install json`
   
3. **net-ping**: Sunucuya HTTP(S) isteği gönderir ve ICMP ping atarak subdomain'in aktif olup olmadığını kontrol eder.
   - İndirme komutu: `gem install net-ping`

Uygulamanın Çalışma Adımları:
1. SecurityTrails API'sine belirtilen domain ile istek gönderilir ve subdomain'ler alınır.
2. Her bir subdomain, HTTP ve HTTPS protokolleri üzerinden test edilir (ping atılır ve HTTP isteği yapılır).
3. Hem HTTP(S) yanıtı hem de ping yanıtı başarılıysa subdomain aktif olarak kabul edilir.
4. Aktif olan subdomain'ler `*.txt` dosyasına kaydedilir.
5. Terminalde, aktif ve aktif olmayan subdomain'ler renkli bir şekilde gösterilir.
