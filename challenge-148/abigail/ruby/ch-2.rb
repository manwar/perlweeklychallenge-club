#!/usr/bin/ruby

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
#
 
#
# Run as: ruby ch-2.rb
#

count = 5
out   = []
a_i   = 0
b_i   = 1
c_i   = 2
sum_i = 3
for i in 0 .. count - 1 do
    out . push ([999999, 999999, 999999, 999999 * 3])
end

max_index = 0
k         = 0

while 3 * k + 2 < out [max_index] [sum_i] do
    a  = 3 * k + 2
    f1 =     k + 1
    f2 = 8 * k + 5

    d1 = []
    for i in 1 .. f1 do
        if i * i > f1 then
            next
        end
        if f1 % i == 0 then
            d1 . push (i)
            if i != f1 / i then
                d1 . push (f1 / i)
            end
        end
    end

    d2 = []
    for i in 1 .. f2 do
        if i * i > f2 then
            next
        end
        if f2 % i == 0 then
            s1 = Math . sqrt(i)      . floor()
            s2 = Math . sqrt(f2 / i) . floor()
            if s1 * s1 == i then
                d2 . push (s1)
            end
            if (s2 * s2 == f2 / i) && s1 != s2 then
                d2 . push (s2)
            end
        end
    end

    d1 . each do |d1v|
        d2 . each do |d2v|
            b = d1v * d2v
            c = f1 * f1 * f2 / (b * b)
            if a + b + c < out [max_index] [sum_i] then
                seen = false
                out . each do |entry|
                    if entry [a_i] == a && entry [b_i] == b then
                        seen = true
                    end
                end
                if seen then
                    next
                end

                out [max_index] = [a, b, c, a + b + c]

                max_index = 0
                max_sum   = out [max_index] [sum_i]
                for i in 1 .. count - 1 do
                    if max_sum < out [i] [sum_i] then
                        max_index = i
                        max_sum   = out [i] [sum_i]
                    end
                end
            end
        end
    end
    k = k + 1
    if k > 10 then
        break
    end
end

out . each do |entry|
    printf "%d %d %d\n", entry [a_i], entry [b_i], entry [c_i]
end
