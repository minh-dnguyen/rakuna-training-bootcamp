def substrings(text, dictionary)
  result = {}
  lowered_text = text.downcase
  dictionary.each do |word|
    matches_array = lowered_text.scan(word)
    match_count = matches_array.length
    if match_count > 0
      result[word] = match_count
    end
  end
  result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substrings("Howdy partner, sit down! How's it going?", dictionary)