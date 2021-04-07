module Mistaker
  class Name < Base
    def reformat(str)
      str.to_s.tr('^A-z ', '').upcase
    end

    def mistake(err_type = rand.rand(NAME_MAX), index = nil)
      @str = reformat(@str)
      @length = @str.length

      index ||= rand.rand(@length)

      case err_type
      when DROPPED_LETTER
        @str.slice! index
      when DOUBLE_LETTER
        @str.insert(index, @str[index])
      when MISREAD_LETTER
        @str[index] = MISREAD_LETTERS[@str[index]]
      when MISTYPED_LETTER
        @str[index] = MISTYPED_LETTERS[@str[index]]
      when PLURALIZATION
        @str << 'S'
      when MISHEARD_LETTERS
        @str = "#{ @str.slice(0...index) }#{ MISHEARD_LETTERS[@str[index]] }#{ @str.slice((index+1)..@length) }"
      end

      @str
    end
  end
end
