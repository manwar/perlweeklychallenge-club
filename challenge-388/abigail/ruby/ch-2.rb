#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line do |n|
    sf = 1
    for i in 1 .. n . to_i do
        sf = i * sf + 1 - 2 * (i % 2)
    end
    puts sf
end
