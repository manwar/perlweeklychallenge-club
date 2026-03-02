# References
# 1. https://www.fullstackruby.dev/string-theory/2020/11/05/gsub-blocks-partitions-string-scanners-oh-my/ 
# 2. https://apidock.com/ruby/String/gsub
def replace_and_count(letter_to_search_and_replace, text)
    count = 0
    result = text.gsub(letter_to_search_and_replace) {|s| count+=1; s.upcase} 
    puts result
    puts count
end

replace_and_count("e", "HeEeeello!")
