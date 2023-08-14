#!/usr/bin/env ruby

def count_words(arr,pat)
  (arr.select {|w| w.start_with?(pat)}).count
end

p count_words(%w[pay attention practice attend],'at')
p count_words(%w[janet julia java javascript],'ja')

