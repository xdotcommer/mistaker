# Mistaker

Mistaker is a gem for emulating common data entry errors that arise from transcription, OCR and numerical data entry.  Use the gem to generate common variations of strings, numerics and dates you might find in older, hand entered data sets.  

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mistaker'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install mistaker

## Usage

```ruby
Mistaker::Word.mistake "GRATEFUL"  #=> "GRATEFU"
Mistaker::Word.mistake "GRATEFUL"  #=> "GRATAFUL"
Mistaker::Word.mistake "GRATEFUL"  #=> "GRAEFUL"
Mistaker::Word.mistake "GRATEFUL"  #=> "GRATEFULL"

Mistaker::Name.mistake "KIM DEAL"   #=> "KIM FEAL"
Mistaker::Name.mistake "KIM DEAL"   #=> "KIM DEL"
Mistaker::Name.mistake "KIM DEAL"   #=> "KIM DEALL"
Mistaker::Name.mistake "KIM DEAL"   #=> "KIM DEAP"

Mistaker::Date.mistake '09/04/1982' #=> "1928-09-04"
Mistaker::Date.mistake '09/04/1982' #=> "0019-82-09"
Mistaker::Date.mistake '09/04/1982' #=> "1932-09-04"

Mistaker::Number.mistake '12345'    #=> "12335"
Mistaker::Number.mistake '12345'    #=> "72345"
Mistaker::Number.mistake '12345'    #=> "13345"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/xdotcommer/mistaker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/xdotcommer/mistaker/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mistaker project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/xdotcommer/mistaker/blob/master/CODE_OF_CONDUCT.md).
