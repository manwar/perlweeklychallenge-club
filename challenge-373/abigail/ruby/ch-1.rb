#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line do |line|
    parts = line . strip                            # Remove newline
                 . gsub(/ /,  "")                   # Remove spaces
                 . gsub(/\./, "")                   # Remove dots
                 . split /;/                        # Split on ;
    puts parts [0] == parts [1] ? "true" : "false"  # Equal?
end
