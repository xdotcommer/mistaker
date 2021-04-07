require "mistaker/version"
require "mistaker/base"
require "mistaker/date"
require "mistaker/number"
require "mistaker/word"
require "mistaker/name"

module Mistaker
  class Error < StandardError; end

  NUMBER_MAX = 5
  DATE_MAX = 8
  NAME_MAX = 6

  ONE_DIGIT_UP, ONE_DIGIT_DOWN, NUMERIC_KEY_PAD, DIGIT_SHIFT, MISREAD, KEY_SWAP = (0..NUMBER_MAX).to_a
  MONTH_DAY_SWAP, ONE_DECADE_DOWN, Y2K = ((NUMBER_MAX + 1)..DATE_MAX).to_a

  DROPPED_LETTER, DOUBLE_LETTER, MISREAD_LETTER, MISTYPED_LETTER, EXTRA_LETTER, MISHEARD_LETTER = (0..NAME_MAX).to_a

  MISREAD_NUMBERS = {
    '0' => '8',
    '1' => '7',
    '2' => '5',
    '3' => '8',
    '4' => '9',
    '5' => '6',
    '6' => '5',
    '7' => '1',
    '8' => '3',
    '9' => '4'
  }.freeze

  MISREAD_LETTERS = {
    'A' => 'E',
    'B' => 'D',
    'C' => 'E',
    'D' => 'B',
    'E' => 'A',
    'F' => 'F',
    'G' => 'C',
    'H' => 'M',
    'I' => 'L',
    'J' => 'Q',
    'K' => 'X',
    'L' => 'I',
    'M' => 'H',
    'N' => 'N',
    'O' => 'A',
    'P' => 'Q',
    'Q' => 'G',
    'R' => 'V',
    'S' => 'Z',
    'T' => 'I',
    'U' => 'V',
    'V' => 'U',
    'W' => 'W',
    'X' => 'K',
    'Y' => 'T',
    'Z' => 'S',
    ' ' => ' '
  }.freeze

  MISTYPED_LETTERS = {
    'A' => 'S',
    'B' => 'G',
    'C' => 'V',
    'D' => 'F',
    'E' => 'A',
    'F' => 'G',
    'G' => 'F',
    'H' => 'J',
    'I' => 'U',
    'J' => 'H',
    'K' => 'L',
    'L' => 'P',
    'M' => 'N',
    'N' => 'N',
    'O' => 'H',
    'P' => 'O',
    'Q' => 'W',
    'R' => 'E',
    'S' => 'D',
    'T' => 'R',
    'U' => 'Y',
    'V' => 'C',
    'W' => 'Q',
    'X' => 'C',
    'Y' => 'U',
    'Z' => 'X',
    ' ' => ' '
  }.freeze

  TEN_KEYS = {
    '0' => '1',
    '1' => '4',
    '2' => '5',
    '3' => '6',
    '4' => '1',
    '5' => '2',
    '6' => '3',
    '7' => '4',
    '8' => '5',
    '9' => '6'
  }.freeze

  MISHEARD_LETTERS = {
    'A' => 'AE',
    'E' => 'EE',
    'I' => 'E',
    'O' => 'OU',
    'U' => 'O',
    'Y' => 'JA',
    'B' => 'P',
    'C' => 'K',
    'D' => 'T',
    'F' => 'VA',
    'G' => 'CH',
    'H' => 'GH',
    'J' => 'Y',
    'K' => 'C',
    'L' => 'LL',
    'M' => 'MM',
    'N' => 'MN',
    'P' => 'B',
    'Q' => 'CU',
    'R' => 'RR',
    'S' => 'SS',
    'T' => 'D',
    'V' => 'F',
    'W' => 'WH',
    'X' => 'CKS',
    'Z' => 'D',
    ' ' => ' '
  }.freeze

  EXTRA_LETTERS = {
    'A' => 'E',
    'B' => 'S',
    'C' => 'E',
    'D' => 'T',
    'E' => 'S',
    'F' => 'E',
    'G' => 'UE',
    'H' => 'S',
    'I' => 'E',
    'J' => 'S',
    'K' => 'S',
    'L' => 'L',
    'M' => 'N',
    'N' => 'E',
    'O' => 'T',
    'P' => 'H',
    'Q' => 'UE',
    'R' => 'E',
    'S' => 'S',
    'T' => 'T',
    'U' => 'E',
    'V' => 'E',
    'W' => 'E',
    'X' => 'E',
    'Y' => 'S',
    'Z' => 'E',
    ' ' => ''
  }.freeze
end
