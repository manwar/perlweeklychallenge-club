#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line {
    |line|
    numbers = line . rstrip . split(" ") . map(&:to_i)

    for mask in 1 .. 2 ** numbers . length - 2 
        sum = 0
        set = []
        numbers . each_with_index {
            |val, index|
            if mask & (1 << index) > 0
                sum += val - index - 1
                set = set . push (val)
            end
        }

        if sum == 0 && set . length > 1
            print (set . join " ") + "; "
        end
    end
    print ("\n")
}
