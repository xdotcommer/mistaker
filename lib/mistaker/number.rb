module Mistaker
  class Number < Base
    def reformat(str)
      str.to_s.tr('^0-9', '')
    end

    def mistake(err_type = rand.rand(NUMBER_MAX), index = nil)
      @str = reformat(@str)
      @length = @str.length

      index ||= rand.rand(@length)

      n = @str[index].to_i

      case err_type
      when ONE_DIGIT_UP
        n += 1
      when ONE_DIGIT_DOWN
        n -= 1
      when KEY_SWAP
        a, b = @str[index], @str[(index - 1).abs]
        @str[index], @str[(index - 1).abs] = b, a
        return str
      when NUMERIC_KEY_PAD
        n = TEN_KEYS[n.to_s].to_i
      when DIGIT_SHIFT
        if index >= @length
          return '0' * @length
        else
          return ('0' * index + @str)[0...@length]
        end
      when MISREAD
        n = MISREAD_NUMBERS[n.to_s].to_i
      end

      @str[index] = n.abs.to_s
      @str
    end
  end
end
