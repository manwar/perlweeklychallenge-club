#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-2.rb < input-file
#

matrix = []

def shortest_path (matrix, from, to, exclude)
    if 1 + exclude . size() == matrix . length() then
        return matrix [from] [to], [to]
    end

    shortest           = 99999999999
    sh_path            = []
    new_exclude        = exclude . clone()
    new_exclude [from] = 1

    for step in 0 .. matrix . length() - 1 do
        if  step == from || step == to || exclude . key?(step) then
            next
        end

        length, path = shortest_path(matrix, step, to, new_exclude)
        if  shortest > length + matrix [from] [step] then
            shortest = length + matrix [from] [step]
            sh_path  = path . clone()
            sh_path . unshift (step)
        end
    end

    return shortest, sh_path
end

ARGF . each_line do
    |line|
    matrix . push (line . split(" ") . map {|x| x . to_i})
end

length, path = shortest_path(matrix, 0, 0, {})
puts (length)
puts (path . unshift(0) . join(" "))
