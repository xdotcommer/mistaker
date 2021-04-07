require 'date'

module Mistaker
  class Date < Base
    YEAR, MONTH, DAY = (0..2).to_a

    def reformat(str)
      case str
      when /\A(\d{1,2})\/(\d{1,2})\/(\d{4})\z/
        "#{$3}-#{$1.rjust(2, '0')}-#{$2.rjust(2, '0')}"
      when /\A(\d{1,2})\/(\d{1,2})\/(\d{2})\z/
        "20#{$3}-#{$1.rjust(2, '0')}-#{$2.rjust(2, '0')}"
      when /\A(\d{4})\-(\d{2})\-(\d{2})\z/
        str
      else
        ::Date.parse(str).to_s
      end
    end

    def mistake(err_type = rand.rand(DATE_MAX), mdy = rand.rand(3))
      @str = reformat(str)
      y,m,d = reformat(str).split('-').map &:to_i

      case err_type
      when ONE_DIGIT_UP
        case mdy
        when YEAR
          y += 1
        when MONTH
          m += 1
        when DAY
          d += 1
        end
      when ONE_DIGIT_DOWN
        case mdy
        when YEAR
          y -= 1
        when MONTH
          m -= 1
        when DAY
          d -= 1
        end
      when KEY_SWAP
        case mdy
        when YEAR
          y = y.to_s
          a,b = y[2],y[3]
          y[2], y[3] = b, a
        when MONTH
          m = m.to_s.rjust(2,'0')
          m.reverse!
        when DAY
          d = d.to_s.rjust(2,'0')
          d.reverse!
        end
      when ONE_DECADE_DOWN
        y -= 10
      when Y2K
        y = y >= 2000 ? "00#{y.to_s[2..3]}" : "20#{y.to_s[2..3]}"
      when MONTH_DAY_SWAP
        m, d = d, m
      when MISREAD
        case mdy
        when YEAR
          y = y.to_s
          y[2] = MISREAD_NUMBERS[y[2]]
        when MONTH
          m = m.to_s
          m[m.length - 1] = MISREAD_NUMBERS[m[m.length - 1]]
        when DAY
          d = d.to_s
          d[d.length - 1] = MISREAD_NUMBERS[d[d.length - 1]]
        end
      when NUMERIC_KEY_PAD
        case mdy
        when YEAR
          y = y.to_s
          y[3] = TEN_KEYS[y[3]]
        when MONTH
          m = m.to_s
          m[m.length - 1] = TEN_KEYS[m[m.length - 1]]
        when DAY
          d = d.to_s
          d[d.length - 1] = TEN_KEYS[d[d.length - 1]]
        end
      when DIGIT_SHIFT
        d = m
        m = y.to_s[2..3]
        y = "00#{y.to_s[0..1]}"
      end

      "#{y}-#{m.to_s.rjust(2,'0')}-#{d.to_s.rjust(2,'0')}"
    end
  end
end
