# GlobalSMS

Ruby geliştiricileri için GlobalHaberlesme.com API lerini kullanan Ruby Gem'idir. GlobalHaberlesme.com tarafından sunulan API dokümantasyonundaki çağrıların (neredeyse) tamamını içerir.

## Kurulum

Uygulama içerisinde kullanmak için aşağıdaki satırı Gemfile'a ekleyin:

```ruby
gem 'globalsms'
```

Sonra kurulmasını sağlayın:

    $ bundle

Ya da kendiniz kurun:

    $ gem install globalsms

## Kullanılabilir Fonksiyonlar ve Kullanım Örnekleri

### SMS Gönderme

Mesaj göndermek için tanımlanmış fonksiyonlara argüman olarak **hash** verilir. Fonksiyon geriye **hash** döner.

Ön tanımlı değerler:

    turkish_character: "0"
    time: "now"

`turkish_character: "0"` olarak verilmesine karşın, mesaj Türkçe karakter içeriyorsa Türkçe karakterler değiştirilerek gönderilir. Örneğin `TÜRKÇE KARAKTER İÇEREN BİR MESAJ` olarak gönderilen bir mesaj `TURKCE KARAKTER iCEREN BiR MESAJ` olarak iletilir.

Kullanıcının gireceği değerler:

    numbers: "5493666154"
    text: "Mesaj Metni"

Nesne üretme:

SMS gönderme işlemi yapmak üzere GlobalSMS:SMS sınıfından bir nesne üretirken argüman olarak **hash** verilir. Örneğin,

```ruby
init_args = {
  api_key: "api-key",
  api_secret: "api-secret",
  originator: "USTAD",
  turkish_character: "1"
}

sms = GlobalSMS::SMS.new(init_args)
```

#### Bir mesaj gönderme

```ruby
require 'globalsms'

sms = GlobalSMS::SMS.new(init_args)

args = {
  numbers: "5493666154",
  text: "Mesaj Metni",
  turkish_character: "1",
  time: "2015-10-07 12:35:00" # Geleceğe dönük mesaj atılması istendiğinde, geleceğe dair bir tarih/saat verilir.
  Öntanımlı şu an `now` olarak verilmiştir.
}

sms.single_send(args)

# {
#   "result" => true, "message_id" => "239916", "numbers" => ["5493666154"], "total_numbers_count" => 1, "turkcell_numbers_count" => 0, "vodafone_numbers_count" => 1, "avea_numbers_count" => 0, "total_credit" => 1, "0" => ""
# }
```

#### Aynı mesajı birden fazla numaraya gönderme

NOT: Tek mesaj gönderme yöntemiyle aynıdır. Sadece `numbers` değerine dizi olarak birden fazla numara verilir. Tek bir `message_id` üretir.

```ruby
require 'globalsms'

sms = GlobalSMS::SMS.new(init_args)

args = {
  originator: "DENEME",
  numbers: ["5493666154", "5493666155", "5493666156", "5493666157"],
  text: "Mesaj Metni",
  turkish_character: "1"
}

sms.single_send(args)

# {
#   "result" => true, "message_id" => "239922", "numbers" => ["5493666154", "5493666155", "5493666156", "5493666157", "..."], "total_numbers_count" => 5, "turkcell_numbers_count" => 0, "vodafone_numbers_count" => 5, "avea_numbers_count" => 0, "total_credit" => 5, "0" => ""
# }
```

**NOT:** 4'den fazla numaraya mesaj gönderilirken dönen cevapta 4'den sonraki numaralar `"..."` olarak kısaltılır.

#### Tek bir çağrıda birden fazla numaraya farklı mesajlar gönderme

```ruby
require 'globalsms'

sms = GlobalSMS::SMS.new(init_args)

args = [
  { numbers: "5493666154",
    text: "Mesaj Metni",
    turkish_character: "1"
  },

  { numbers: "5493666155",
    text: "Bir Başka Mesaj Metni",
    turkish_character: "1"
  },

  { numbers: "5493666156",
    text: "Ve Bir Başka Mesaj Metni",
    turkish_character: "1"
  },

  { numbers: "5493666157",
    text: "Ve De Bir Başka Mesaj Metni",
    turkish_character: "1"
  }
]

sms.multi_send(args)

# {
#   "result" => true, "results" => [{
#     "result" => true, "message_id" => "239928", "numbers" => ["5493666154"], "total_numbers_count" => 1, "turkcell_numbers_count" => 0, "vodafone_numbers_count" => 1, "avea_numbers_count" => 0, "total_credit" => 1, "0" => ""
#   }, {
#     "result" => true, "message_id" => "239929", "numbers" => ["5493666155"], "total_numbers_count" => 1, "turkcell_numbers_count" => 0, "vodafone_numbers_count" => 1, "avea_numbers_count" => 0, "total_credit" => 1, "0" => ""
#   }, {
#     "result" => true, "message_id" => "239930", "numbers" => ["5493666156"], "total_numbers_count" => 1, "turkcell_numbers_count" => 0, "vodafone_numbers_count" => 1, "avea_numbers_count" => 0, "total_credit" => 1, "0" => ""
#   }, {
#     "result" => true, "message_id" => "239931", "numbers" => ["5493666157"], "total_numbers_count" => 1, "turkcell_numbers_count" => 0, "vodafone_numbers_count" => 1, "avea_numbers_count" => 0, "total_credit" => 1, "0" => ""
#   }]
# }
```

### Rapor Alma

Gönderilmiş mesajlara ait raporları almak için fonksiyonlara argüman olarak tek bir çağrı için `message_id`, birden fazla çağrı için `message_id` leri içeren bir array verilir. Fonksiyon geriye **hash** döndürür.


Nesne üretme:

Rapor görüntüleme işlemi yapmak üzere GlobalSMS:REPORT sınıfından bir nesne üretirken argüman olarak **hash** verilir. Örneğin,

```ruby
init_args = {
  api_key: "api-key",
  api_secret: "api-secret"
}

sms = GlobalSMS::REPORT.new(init_args)
```

#### Bir mesaja ait raporları görüntüleme

```ruby
require 'globalsms'

sms = GlobalSMS::REPORT.new(init_args)

sms.message(239916, limit=250)

# {
#   "result" => true, "data" => [{
#     "id" => "34163245", "created_datetime" => "2015-05-05 14:54:32", "gsm_no" => "5493666154", "gsm_operator" => "2", "sent_status" => "2", "sent_datetime" => "2015-05-05 14:54:37", "out_status" => "255", "out_datetime" => "2015-05-05 14:54:37", "report_message" => "COMMAND_ERROR", "name" => nil
#   }], "totals" => {
#     "total_number" => "1", "message_id" => "239916", "total_sent" => "1", "num_reached" => "0", "num_not_reached" => "0", "num_waiting_for_time" => "0", "paid_coin" => "1"
#   }
# }
```

**NOT:** `limit` değişkeni 250 ile ilklenmiştir.

#### Son x mesaja ait raporları görüntüleme

Argüman verilmezse, ön tanımlı olarak en son yollanan (1) mesaja ait raporu döndürür.

```ruby
require 'globalsms'

sms = GlobalSMS::REPORT.new(init_args)

sms.last_n(10)

# {
#   "result" => true, "data" => [{
#     "id" => "239931", "created_datetime" => "2015-05-05 15:00:52", "originator" => "DENEME", "originator_id" => "1616", "total_num" => "1", "pieces" => "1", "total_sent" => "1", "num_reached" => "0", "num_not_reached" => "0", "num_waiting_for_time" => "0", "text" => "Ve De Bir Başka Mesaj Metni", "time_to_send" => "2015-05-05 15:00:52"
#   }, {
#     "id" => "239930", "created_datetime" => "2015-05-05 15:00:52", "originator" => "DENEME", "originator_id" => "1616", "total_num" => "1", "pieces" => "1", "total_sent" => "1", "num_reached" => "0", "num_not_reached" => "0", "num_waiting_for_time" => "0", "text" => "Ve Bir Başka Mesaj Metni", "time_to_send" => "2015-05-05 15:00:52"
#   }, {
#     "id" => "239929", "created_datetime" => "2015-05-05 15:00:52", "originator" => "DENEME", "originator_id" => "1616", "total_num" => "1", "pieces" => "1", "total_sent" => "1", "num_reached" => "0", "num_not_reached" => "0", "num_waiting_for_time" => "0", "text" => "Bir Başka Mesaj Metni", "time_to_send" => "2015-05-05 15:00:52"
#   }, {
#     "id" => "239928", "created_datetime" => "2015-05-05 15:00:52", "originator" => "DENEME", "originator_id" => "1616", "total_num" => "1", "pieces" => "1", "total_sent" => "1", "num_reached" => "0", "num_not_reached" => "0", "num_waiting_for_time" => "0", "text" => "Mesaj Metni", "time_to_send" => "2015-05-05 15:00:52"
#   }, {
#     "id" => "239926", "created_datetime" => "2015-05-05 14:59:06", "originator" => "DENEME", "originator_id" => "1616", "total_num" => "1", "pieces" => "1", "total_sent" => "1", "num_reached" => "0", "num_not_reached" => "0", "num_waiting_for_time" => "0", "text" => "Ve De Bir Başka Mesaj Metni", "time_to_send" => "2015-05-05 14:59:06"
#   }, {
#     "id" => "239925", "created_datetime" => "2015-05-05 14:59:06", "originator" => "DENEME", "originator_id" => "1616", "total_num" => "1", "pieces" => "1", "total_sent" => "1", "num_reached" => "0", "num_not_reached" => "0", "num_waiting_for_time" => "0", "text" => "Ve Bir Başka Mesaj Metni", "time_to_send" => "2015-05-05 14:59:06"
#   }, {
#     "id" => "239924", "created_datetime" => "2015-05-05 14:59:06", "originator" => "DENEME", "originator_id" => "1616", "total_num" => "1", "pieces" => "1", "total_sent" => "1", "num_reached" => "0", "num_not_reached" => "0", "num_waiting_for_time" => "0", "text" => "Bir Başka Mesaj Metni", "time_to_send" => "2015-05-05 14:59:06"
#   }, {
#     "id" => "239923", "created_datetime" => "2015-05-05 14:59:06", "originator" => "DENEME", "originator_id" => "1616", "total_num" => "1", "pieces" => "1", "total_sent" => "1", "num_reached" => "0", "num_not_reached" => "0", "num_waiting_for_time" => "0", "text" => "Mesaj Metni", "time_to_send" => "2015-05-05 14:59:06"
#   }, {
#     "id" => "239922", "created_datetime" => "2015-05-05 14:57:10", "originator" => "DENEME", "originator_id" => "1616", "total_num" => "4", "pieces" => "1", "total_sent" => "4", "num_reached" => "0", "num_not_reached" => "0", "num_waiting_for_time" => "0", "text" => "Mesaj Metni", "time_to_send" => "2015-05-05 14:57:10"
#   }, {
#     "id" => "239916", "created_datetime" => "2015-05-05 14:54:32", "originator" => "DENEME", "originator_id" => "1616", "total_num" => "1", "pieces" => "1", "total_sent" => "1", "num_reached" => "0", "num_not_reached" => "0", "num_waiting_for_time" => "0", "text" => "Mesaj Metni", "time_to_send" => "2015-05-05 14:54:32"
#   }], "totals" => {
#     "total_message" => "33", "total_reached" => "21", "total_sms" => "42"
#   }
# }
```

#### Belirli tarihler arasında gönderilmiş mesajlara ait raporları görüntüleme

Bu fonsiyon argüman olarak **hash** alır ve sonuç olarak **hash** döner. 'limit' değeri sorgu cevabının boyutunu ayarlar. Azami değeri 200-dür. 200-den fazlası için cevap dönmez veya 20 adet döner. Bu sebeple 'start' değeri
kullanılarak sayfalama yapılır. Örneğin 'limit' değeri 100 ve 'start' değeri 100 ise 2. sayfa(100 ve 200 arası
değerler) döner. 'limit' ve 'start' değerleri girilmezse ilk 200 kayıt listelenir.

Ön tanımlı değerler:

    start_time: "00:00:00"
    end_time: "23:59:59"
    limit: "200"
    start: "0"

Kullanıcının gireceği değerler:

    start_date: "2015-05-06"
    end_date: "2015-05-06"

```ruby
require 'globalsms'

sms = GlobalSMS::REPORT.new(init_args)

args = {
  start_date: "2015-05-06",
  end_date: "2015-05-06",
  start_time: "20:21:20",
  end_time: "20:22:00"
}

sms.between(args)

# {
#   "result" => true, "data" => [{
#     "id" => "243408", "created_datetime" => "2015-05-06 20:21:30", "originator" => "DENEME", "originator_id" => "1649", "total_num" => "2", "pieces" => "1", "total_sent" => "2", "num_reached" => "2", "num_not_reached" => "0", "num_waiting_for_time" => "0", "text" => "Mesaj Metni", "time_to_send" => "2015-05-06 20:21:30"
#   }], "totals" => {
#     "total_message" => "1", "total_reached" => "2", "total_sms" => "2"
#   }
# }
```

### Bilgi Alma

Nesne üretme:

Bilgi alma işlemi yapmak üzere GlobalSMS:INFO sınıfından bir nesne üretirken argüman olarak **hash** verilir. Örneğin,

```ruby
init_args = {
  api_key: "api-key",
  api_secret: "api-secret"
}

sms = GlobalSMS::INFO.new(init_args)
```

#### Gönderici adlarını görüntüleme

Bu fonksiyon argüman almaz.

```ruby
require 'globalsms'

sms = GlobalSMS::INFO.new(init_args)

sms.originator_list

# {
#   "result" => true, "data" => [{
#     "originator_id" => "1616", "title" => "DENEME", "created_datetime" => "2015-04-27 20:25:39", "updated_datetime" => "2015-04-27 20:25:44", "approved_datetime" => "2015-04-27 20:25:44", "description" => "", "status" => "1"
#   }]
# }
```

#### Kullanıcı detaylarını ve kalan kredi bilgisini görüntüleme

```ruby
require 'globalsms'

sms = GlobalSMS::INFO.new(init_args)

sms.user_info

# {
#   "result" => true, "data" => {
#     "firstname" => "Salih", "lastname" => "Özdemir", "username" => "salihozd", "email" => "me@salihozdemir.net", "image" => nil, "credit" => "8"
#   }
# }
```

## Geliştirme

Bu Gem, GlobalHaberlesme.com dan bağımsız bir geliştirici tarafından oluşturulmuştur.

## Katkıda Bulunma

Geliştirmeye yapacağınız öneri ve katkılarınızı bekliyoruz.

## Lisans

Bu Gem, MIT Lisansı ile korunur.

## Bağlantılar

Orijinal API Dokümantasyonu `http://uye.globalhaberlesme.com/uploads/api_user.pdf`

RubyGems `https://rubygems.org/gems/globalsms`
