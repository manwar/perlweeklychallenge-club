#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line do |line|
    line . gsub!(/"/, "") . gsub! /\n/, ""      # Remove quotes, newline
    spaces     = line . count (" ")             # Count spaces
    words      = line . strip . split /\s+/     # Split into words

    gaps       = words . length - 1             # Number of gaps
    per_gap    = gaps > 0 ? spaces / gaps : 0   # Calculate amount
    end_spaces = spaces - gaps * per_gap        #   of spaces needed

    puts '"' + words . join(" " * per_gap) + " " * end_spaces + '"'
end
