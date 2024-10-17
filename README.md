Subdomain tespit uygulaması eklendi

- SecurityTrails API'si ile subdomain tespiti yapıldı
- Hem HTTP hem HTTPS isteği ve Ping kontrolü ile subdomain'lerin aktifliği kontrol edildi
- Çoklu iş parçacığı (threading) kullanılarak kontrol işlemleri hızlandırıldı
- Subdomain'ler hem HTTP(S) yanıtına göre hem de ping yanıtına göre aktiflik durumuna göre değerlendirildi
- Aktif olan subdomain'ler bir dosyaya kaydedildi
- Timeout süreleri artırılarak yavaş sunucuların daha fazla zaman alması sağlandı

Gerekli Kütüphaneler:
- httparty
- json
- net-ping

Kurulum:
1. Gerekli gem'leri yüklemek için `gem install httparty json net-ping` komutlarını çalıştırın.
2. Uygulamayı çalıştırmak için `ruby rootsubfinder.rb` komutunu çalıştırın.
