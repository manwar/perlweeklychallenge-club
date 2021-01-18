ARGF . each_line do |_|
    puts ((_ . split (/\s+/)) . grep (/\S/)) . reverse . join (" ")
end
