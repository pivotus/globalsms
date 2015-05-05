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

## Örnek Kullanım

### SMS Gönderme

Mesaj göndermek için tanımlanmış fonksiyonlara argüman olarak **hash** verilir. Fonksiyon geriye **hash** döner.

Ön tanımlı değerler:

    turkish_character: "1"
    time: "now"

Kullanıcının gireceği değerler:

    originator: "DENEME",
    numbers: "5493666154",
    text: "Mesaj Metni",

#### Tek mesaj gönderen örnek kod:

```ruby
require 'globalsms'

sms = GlobalSMS::SMS.new('api-key','api-secret')

argv = {
  originator: "DENEME",
  numbers: "5493666154",
  text: "Mesaj Metni",
  turkish_character: "1"
}

sms.single_send(argv)

# {
#     "result" => true, "message_id" => "239916", "numbers" => ["5493666154"], "total_numbers_count" => 1, "turkcell_numbers_count" => 0, "vodafone_numbers_count" => 1, "avea_numbers_count" => 0, "total_credit" => 1, "0" => ""
# }

```

#### Aynı mesajı birden fazla numaraya gönderen örnek kod:

```ruby
require 'globalsms'

sms = GlobalSMS::SMS.new('api-key','api-secret')

argv = {
  originator: "DENEME",
  numbers: ["5493666154", "5493666155", "5493666156", "5493666157"],
  text: "Mesaj Metni",
  turkish_character: "1"
}

sms.bulk_send(argv)

# {
#     "result" => true, "message_id" => "239922", "numbers" => ["5493666154", "5493666155", "5493666156", "5493666157"
#         "..."
#     ], "total_numbers_count" => 4, "turkcell_numbers_count" => 0, "vodafone_numbers_count" => 4, "avea_numbers_count" => 0, "total_credit" => 4, "0" => ""
# }

```

#### Tek bir çağrıda birden fazla numaraya farklı mesajlar gönderen örnek kod:

```ruby
require 'globalsms'

sms = GlobalSMS::SMS.new('api-key','api-secret')

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
#     "result" => true, "results" => [{
#         "result" => true, "message_id" => "239928", "numbers" => ["5493666154"], "total_numbers_count" => 1, "turkcell_numbers_count" => 0, "vodafone_numbers_count" => 1, "avea_numbers_count" => 0, "total_credit" => 1, "0" => ""
#     }, {
#         "result" => true, "message_id" => "239929", "numbers" => ["5493666155"], "total_numbers_count" => 1, "turkcell_numbers_count" => 0, "vodafone_numbers_count" => 1, "avea_numbers_count" => 0, "total_credit" => 1, "0" => ""
#     }, {
#         "result" => true, "message_id" => "239930", "numbers" => ["5493666156"], "total_numbers_count" => 1, "turkcell_numbers_count" => 0, "vodafone_numbers_count" => 1, "avea_numbers_count" => 0, "total_credit" => 1, "0" => ""
#     }, {
#         "result" => true, "message_id" => "239931", "numbers" => ["5493666157"], "total_numbers_count" => 1, "turkcell_numbers_count" => 0, "vodafone_numbers_count" => 1, "avea_numbers_count" => 0, "total_credit" => 1, "0" => ""
#     }]
# }

```

### Rapor Alma



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/salihozd/globalsms/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
