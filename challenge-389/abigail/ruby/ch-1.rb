#!/opt/homebrew/opt/ruby/bin/ruby

ARGF . each_line do |line|
    parts = line . split
    notes = []
    nr_of_notes = parts . length / 2
    for i in 1 .. nr_of_notes
        notes [parts [i + nr_of_notes] . to_i - 1] = parts [i]
    end
    puts (parts [0] . upcase + " => " + notes . join(" "))
end
