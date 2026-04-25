#!/opt/homebrew/opt/ruby/bin/ruby

def are_anagrams (str1, str2)
    return str1 . split("") . sort . join("") ==
           str2 . split("") . sort . join("")
end

def can_scramble (input, target)
    if input == target
        return true
    end

    if input . length != target . length
        return false
    end

    if not are_anagrams input, target
        return false
    end

    for l in 1 .. input . length - 1 do
        m = input . length - l
        if can_scramble(input [0, l], target [0, l]) &&
           can_scramble(input [l, m], target [l, m]) ||
           can_scramble(input [l, m], target [0, m]) &&
           can_scramble(input [0, l], target [m, l])
            return true
        end
    end

    return false
end


ARGF . each_line {
    |line|
    parts  = line . rstrip . split " "
    input  = parts [0]
    target = parts [1]

    puts can_scramble input, target
}
