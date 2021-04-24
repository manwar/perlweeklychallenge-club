#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

SIZE = 7

#
# Brute force all possibilities, with early returns.
#
ARGF . each_line do |_|
    numbers = (_ . split) . map {|_| _ . to_i}

    numbers . each_with_index do |a, a_i|
        numbers . each_with_index do |b, b_i|
            next if a_i == b_i
            target = a + b
            numbers . each_with_index do |c, c_i|
                next if a_i == c_i || b_i == c_i
                numbers . each_with_index do |d, d_i|
                    next if a_i == d_i || b_i == d_i || c_i == d_i
                    next if target != b + c + d
                    numbers . each_with_index do |e, e_i|
                        next if a_i == e_i || b_i == e_i || c_i == e_i ||
                                d_i == e_i
                        numbers . each_with_index do |f, f_i|
                            next if a_i == f_i || b_i == f_i || c_i == f_i ||
                                    d_i == f_i || e_i == f_i
                            next if target != d + e + f
                            numbers . each_with_index do |g, g_i|
                                next if a_i == g_i || b_i == g_i ||
                                        c_i == g_i || d_i == g_i ||
                                        e_i == g_i || f_i == g_i
                                next if target != f + g
                                puts "#{a} #{b} #{c} #{d} #{e} #{f} #{g}"
                            end
                        end
                    end
                end
            end
        end
    end
end
