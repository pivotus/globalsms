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

    turkish_character: "1"
    time: "now"

Kullanıcının gireceği değerler:

    originator: "DENEME"
    numbers: "5493666154"
    text: "Mesaj Metni"

#### (single_send) Tek mesaj gönderen örnek kod:

```ruby
require 'globalsms'

sms = GlobalSMS::SMS.new('api-key', 'api-secret')

argv = {
  originator: "DENEME",
  numbers: "5493666154",
  text: "Mesaj Metni",
  turkish_character: "1"
}

sms.single_send(argv)

# {
#   "result" => true, "message_id" => "239916", "numbers" => ["5493666154"], "total_numbers_count" => 1, "turkcell_numbers_count" => 0, "vodafone_numbers_count" => 1, "avea_numbers_count" => 0, "total_credit" => 1, "0" => ""
# }
```

#### (bulk_send) Aynı mesajı birden fazla numaraya gönderen örnek kod:

NOT: Bu yöntem ile mesaj gönderilirken birden fazla numaraya gönderilen aynı mesajlar, tek bir `message_id` üretir.

```ruby
require 'globalsms'

sms = GlobalSMS::SMS.new('api-key', 'api-secret')

argv = {
  originator: "DENEME",
  numbers: ["5493666154", "5493666155", "5493666156", "5493666157"],
  text: "Mesaj Metni",
  turkish_character: "1"
}

sms.bulk_send(argv)

# {
#   "result" => true, "message_id" => "239922", "numbers" => ["5493666154", "5493666155", "5493666156", "5493666157"
#     "..."
#   ], "total_numbers_count" => 4, "turkcell_numbers_count" => 0, "vodafone_numbers_count" => 4, "avea_numbers_count" => 0, "total_credit" => 4, "0" => ""
# }
```

#### (multi_send) Tek bir çağrıda birden fazla numaraya farklı mesajlar gönderen örnek kod:

```ruby
require 'globalsms'

sms = GlobalSMS::SMS.new('api-key', 'api-secret')

argv = [
  { originator: "DENEME",
    numbers: "5493666154",
    text: "Mesaj Metni",
    turkish_character: "1"
  },

  { originator: "DENEME",
    numbers: "5493666155",
    text: "Bir Başka Mesaj Metni",
    turkish_character: "1"
  },

  { originator: "DENEME",
    numbers: "5493666156",
    text: "Ve Bir Başka Mesaj Metni",
    turkish_character: "1"
  },

  { originator: "DENEME",
    numbers: "5493666157",
    text: "Ve De Bir Başka Mesaj Metni",
    turkish_character: "1"
  }
]

sms.multi_send(argv)

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

#### (single_report) Tek mesaja ait raporları döndüren örnek kod:

```ruby
require 'globalsms'

sms = GlobalSMS::REPORT.new('api-key', 'api-secret')

sms.single_report(239916)

# {
#   "result" => true, "data" => [{
#     "id" => "34163245", "created_datetime" => "2015-05-05 14:54:32", "gsm_no" => "5493666154", "gsm_operator" => "2", "sent_status" => "2", "sent_datetime" => "2015-05-05 14:54:37", "out_status" => "255", "out_datetime" => "2015-05-05 14:54:37", "report_message" => "COMMAND_ERROR", "name" => nil
#   }], "totals" => {
#     "total_number" => "1", "message_id" => "239916", "total_sent" => "1", "num_reached" => "0", "num_not_reached" => "0", "num_waiting_for_time" => "0", "paid_coin" => "1"
#   }
# }
```

#### (bulk_report) Birden fazla mesaja ait raporları döndüren örnek kod:

```ruby
require 'globalsms'

sms = GlobalSMS::REPORT.new('api-key', 'api-secret')

arr = ["239928", "239929", "239930", "239931"]

sms.bulk_report(arr)

# {
#   "239928" => {
#     "result" => true, "data" => [{
#       "id" => "34163260", "created_datetime" => "2015-05-05 15:00:52", "gsm_no" => "5493666154", "gsm_operator" => "2", "sent_status" => "2", "sent_datetime" => "2015-05-05 15:00:53", "out_status" => "255", "out_datetime" => "2015-05-05 15:00:53", "report_message" => "COMMAND_ERROR", "name" => nil
#     }], "totals" => {
#       "total_number" => "1", "message_id" => "239928", "total_sent" => "1", "num_reached" => "0", "num_not_reached" => "0", "num_waiting_for_time" => "0", "paid_coin" => "1"
#     }
#   }, "239929" => {
#     "result" => true, "data" => [{
#       "id" => "34163261", "created_datetime" => "2015-05-05 15:00:52", "gsm_no" => "5493666155", "gsm_operator" => "2", "sent_status" => "2", "sent_datetime" => "2015-05-05 15:00:53", "out_status" => "255", "out_datetime" => "2015-05-05 15:00:53", "report_message" => "COMMAND_ERROR", "name" => nil
#     }], "totals" => {
#       "total_number" => "1", "message_id" => "239929", "total_sent" => "1", "num_reached" => "0", "num_not_reached" => "0", "num_waiting_for_time" => "0", "paid_coin" => "1"
#     }
#   }, "239930" => {
#     "result" => true, "data" => [{
#       "id" => "34163262", "created_datetime" => "2015-05-05 15:00:52", "gsm_no" => "5493666156", "gsm_operator" => "2", "sent_status" => "2", "sent_datetime" => "2015-05-05 15:00:53", "out_status" => "255", "out_datetime" => "2015-05-05 15:00:53", "report_message" => "COMMAND_ERROR", "name" => nil
#     }], "totals" => {
#       "total_number" => "1", "message_id" => "239930", "total_sent" => "1", "num_reached" => "0", "num_not_reached" => "0", "num_waiting_for_time" => "0", "paid_coin" => "1"
#     }
#   }, "239931" => {
#     "result" => true, "data" => [{
#       "id" => "34163263", "created_datetime" => "2015-05-05 15:00:52", "gsm_no" => "5493666157", "gsm_operator" => "2", "sent_status" => "2", "sent_datetime" => "2015-05-05 15:00:53", "out_status" => "255", "out_datetime" => "2015-05-05 15:00:53", "report_message" => "COMMAND_ERROR", "name" => nil
#     }], "totals" => {
#       "total_number" => "1", "message_id" => "239931", "total_sent" => "1", "num_reached" => "0", "num_not_reached" => "0", "num_waiting_for_time" => "0", "paid_coin" => "1"
#     }
#   }
# }
```

#### (report_last) Son x mesaja ait raporları döndüren örnek kod:

Argüman verilmezse, ön tanımlı olarak en son yollanan (1) mesaja ait raporu döndürür.

```ruby
require 'globalsms'

sms = GlobalSMS::REPORT.new('api-key', 'api-secret')

sms.report_last(10)

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

#### (report_between) Belirli tarihler arasında gönderilmiş mesajlara ait raporları döndüren örnek kod:

Bu fonsiyon argüman olarak **hash** alır ve sonuç olarak **hash** döner.

Ön tanımlı değerler:

    start_time: "00:00:00"
    end_time: "23:59:59"

Kullanıcının gireceği değerler:

    start_date: "2015-05-06"
    end_date: "2015-05-06"

```ruby
require 'globalsms'

sms = GlobalSMS::REPORT.new('api-key','api-secret')

argv = {
  start_date: "2015-05-06",
  end_date: "2015-05-06",
  start_time: "20:21:20",
  end_time: "20:22:00"
}

sms.report_between(argv)

# {
#   "result" => true, "data" => [{
#     "id" => "243408", "created_datetime" => "2015-05-06 20:21:30", "originator" => "DENEME", "originator_id" => "1649", "total_num" => "2", "pieces" => "1", "total_sent" => "2", "num_reached" => "2", "num_not_reached" => "0", "num_waiting_for_time" => "0", "text" => "Mesaj Metni", "time_to_send" => "2015-05-06 20:21:30"
#   }], "totals" => {
#     "total_message" => "1", "total_reached" => "2", "total_sms" => "2"
#   }
# }
```

#### (originator_list) Orinigator (gönderici adı) listeleyen örnek kod:

Bu fonksiyon argüman almaz.

```ruby
require 'globalsms'

sms = GlobalSMS::REPORT.new('api-key', 'api-secret')

sms.originator_list

# {
#   "result" => true, "data" => [{
#     "originator_id" => "1616", "title" => "DENEME", "created_datetime" => "2015-04-27 20:25:39", "updated_datetime" => "2015-04-27 20:25:44", "approved_datetime" => "2015-04-27 20:25:44", "description" => "", "status" => "1"
#   }]
# }
```

#### (user_info) Kullanıcı detaylarını ve kalan kredi bilgisini döndüren örnek kod:

```ruby
require 'globalsms'

sms = GlobalSMS::REPORT.new('api-key', 'api-secret')

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

Geliştirmeye yapacağınız öneri ve katkılarınızı bekliyorum.

## Lisans

Bu Gem, MIT Lisansı ile korunur.

## Bağlantılar

Orijinal API Dokümantasyonu `http://uye.globalhaberlesme.com/uploads/api_user.pdf`

RubyGems `https://rubygems.org/gems/globalsms`