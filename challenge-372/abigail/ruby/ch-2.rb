#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line do |line|
    chars = line . rstrip . split ("")  # Array of input chars, sans newline
    max   = -1                          # Track maximum distance

    (0) . upto (chars . length - 1) do |f|           # For each character, ...
        (chars . length - 1) . downto (f + 1) do |l| # find matching character
            if chars [f] == chars [l]                # from the end
                if l - f - 1 > max                   # If larger distance
                    max = l - f - 1                  # remember it
                end
                break
            end
        end
    end

    puts (max)
end
