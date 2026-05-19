#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line do |line|
    list = line . strip . split /\s+/

    #
    # First element is n
    #
    n = list . shift . to_i

    #
    # Handle special case when n exceeds the length of the list
    #
    if n > list . length
        puts "-1;"
        next
    end

    #
    # Calculate the set size, and the number of sets which
    # get one more element
    #
    per_set  = list . length / n
    overflow = list . length - n * per_set

    #
    # Print sets
    #
    (1) . upto (n) do |i|
        #
        # Calculate the size of the current set
        #
        set_size = per_set
        if i <= overflow
            set_size = set_size + 1
        end
        #
        # Print current set
        #
        print list . slice!(0, set_size) . join(" ") + "; "
    end

    puts ""
end
