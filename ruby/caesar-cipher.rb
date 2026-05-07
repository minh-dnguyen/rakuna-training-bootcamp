def caesar_cipher(string, shift)
  result = ""
  shift = shift % 26
  string.each_char do |char|
    ascii_value = char.ord
    if ascii_value >= 65 && ascii_value <= 90
      shifted_value = ascii_value + shift
      if shifted_value > 90
        shifted_value = shifted_value - 26
      end
      result += shifted_value.chr
    elsif ascii_value >= 97 && ascii_value <= 122
      shifted_value = ascii_value + shift
      if shifted_value > 122
        shifted_value = shifted_value - 26
      end
      result += shifted_value.chr
    else
      result += char
    end
  end
  result
end

puts caesar_cipher("What a string!", 5)
