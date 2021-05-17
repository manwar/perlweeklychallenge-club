#!/usr/bin/ruby

#
# See ../README.md
#
 
#
# Run as: ruby ch-1.rb < input-file
#

ARGF . each_line do
    | line |
    parts = line . strip() . split (/\/+/)
    parts2 = []
    parts . each do
        | part |
        if part == "" or part == "."   # Skip empty parts and current directory
            next
        end
        if part == ".."                # Remove parent directory
            parts2 . pop
            next
        end
        parts2 . push (part)           # Add part
    end
    puts ("/" + parts2 . join("/"))    # Print result
end
