#Llamado a la API
require "uri"
require "net/http"
require 'json'

def request (url)
    url = URI(url)

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    JSON.parse(response.read_body)
end 

def build_def_page
    data = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=DEMO_KEY")
    html = "<html>\n
            <head>\n
            </head>\n
            <body>\n
            <h1> Prueba Fernando Pérez - Introducción a la programación con Ruby </h1>\n 
            <h2> Fotos de los Rover </h2>
            <ul>\n" #Recuerda que como es una web, se pueden poner títulos o texto
    #Con el código que está a continuación, entramos al hash y luego a la key que contiene la fotografía
    data["photos"].each do |photo|
        photo["img_src"]
        html += "<li><img src='#{photo['img_src']}'></li>\n" 
    end

    html += "</ul>\n
             </body>\n
             </html>\n"   
    return html
end

File.write('index.html', build_def_page)

=begin
require "uri"
require "net/http"

def request
url = URI("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY")

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Get.new(url)

response = https.request(request)
puts response.read_body
end
=end