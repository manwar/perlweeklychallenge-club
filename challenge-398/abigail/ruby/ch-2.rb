#!/opt/homebrew/opt/ruby/bin/ruby

def Next (index, max)
    index += 1
    if index >= max then
        index = 0
    end
    return index
end

def Prev (index, max)
    index -= 1
    if index <  0 then
        index = max - 1
    end
    return index
end

ARGF . each_line do |line|
    words = line . split (/\s+/)
    diffs = words . map do |word|
        offset = word [0] . ord - "a" . ord
        diff   = ""
        word . each_char do |ch|
            diff << ch . ord - offset
        end
        diff
    end

    diffs . each_index do |index|
        if diffs [index] != diffs [Next(index, diffs . length)] && 
           diffs [index] != diffs [Prev(index, diffs . length)]
        then
            puts words [index]
        end
    end
end
