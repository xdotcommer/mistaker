module Mistaker
  class Base
    attr_reader :str, :rand, :length

    def initialize(str = nil)
      @str = str
      @rand = Random.new
    end

    def reformat(str)
      str
    end
  end
end
