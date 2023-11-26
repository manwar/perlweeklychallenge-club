#!/usr/bin/env ruby

def consistent_strings(arr,allowed)
  count = 0
  arr.each do |str|
    if str.split('').all? {|c| allowed.include?(c)} then
      count += 1
    end
  end
  count
end

p consistent_strings(['ad','bd','aaab','baa','badab'],'ab')
p consistent_strings(['a','b','c','ab','ac','bc','abc'],'abc')
p consistent_strings(['cc','acd','b','ba','bac','bad','ac','d'],'cad');

