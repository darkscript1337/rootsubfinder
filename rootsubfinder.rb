require 'httparty'
require 'json'
require 'net/ping'
require 'thread'

def ascii_art
  puts "\033[91m"
  puts %q{
  ____             _                  _       _   _ _______________ 
 |  _ \  __ _ _ __| | _____  ___ _ __(_)_ __ | |_/ |___ /___ /___  |
 | | | |/ _` | '__| |/ / __|/ __| '__| | '_ \| __| | |_ \ |_ \  / / 
 | |_| | (_| | |  |   <\__ \ (__| |  | | |_) | |_| |___) |__) |/ /  
 |____/ \__,_|_|  |_|\_\___/\___|_|  |_| .__/ \__|_|____/____//_/   
                                       |_|                          
  }
  puts "\033[92mCoder By: RootAyyildiz Turkish Hacktivist\033[0m\n"
end

API_KEY = 'Tjun5orDFJYwOaYwYQ3zSdpNX7SEJB3f'

puts "Subdomain bulmak istediğiniz domaini girin (örneğin: mfa.gr):"
domain = gets.chomp

url = "https://api.securitytrails.com/v1/domain/#{domain}/subdomains"

response = HTTParty.get(url, headers: { 'apikey' => API_KEY })
data = JSON.parse(response.body)

filename = "#{domain}_active_subdomains.txt"

threads = []
mutex = Mutex.new

def check_domain(full_domain)
  # HTTP ve HTTPS isteği
  http_check = Net::Ping::HTTP.new("http://#{full_domain}", nil, 15)
  https_check = Net::Ping::HTTP.new("https://#{full_domain}", nil, 15)
  
  http_success = http_check.ping? || https_check.ping?

  # Ping kontrolü (arka planda)
  external_ping = Net::Ping::External.new(full_domain)
  ping_success = external_ping.ping?

  # Eğer hem HTTP(S) hem de Ping başarılıysa true döner
  return http_success || ping_success
end

File.open(filename, 'w') do |file|
  if data['subdomains']
    puts "Subdomainler kontrol ediliyor..."

    data['subdomains'].each do |subdomain|
      threads << Thread.new do
        full_domain = "#{subdomain}.#{domain}"

        if check_domain(full_domain)
          mutex.synchronize do
            puts "\033[92m[AKTİF]\033[0m #{full_domain}"
            file.puts full_domain
          end
        else
          puts "\033[91m[AKTİF DEĞİL]\033[0m #{full_domain}"
        end
      end
    end

    threads.each(&:join)
  else
    puts "Subdomain bulunamadı veya bir hata oluştu!"
  end
end

puts "Aktif subdomain sonuçları #{filename} dosyasına kaydedildi."

ascii_art
