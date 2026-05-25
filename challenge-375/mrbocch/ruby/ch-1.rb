
def single_common_word(arr1, arr2)
  s1 = arr1.tally.filter_map{|k, v| k if v == 1 }.to_set
  s2 = arr2.tally.filter_map{|k, v| k if v == 1 }.to_set

   s1.intersection(s2).length
end

raise if single_common_word(["apple", "banana", "cherry"], ["banana", "cherry", "date"]) != 2
raise if single_common_word(["a", "ab", "abc"], ["a", "a", "ab", "abc"])                 != 2
raise if single_common_word(["orange", "lemon"], ["grape", "melon"])                     != 0
raise if single_common_word(["test", "test", "demo"], ["test", "demo", "demo"])          != 0
raise if single_common_word(["Hello", "world"], ["hello", "world"])                      != 1

