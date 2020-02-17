my $formatter = sub { sprintf '%02d%02d%04d', .month, .day, .year given $^date }; 

.say for (2000..2099)
    .grep({ 
        0 < $^year.substr(2,2).flip < 12 })
    .map({ 
        Date.new($^year, |$year.flip.comb(2), :$formatter ) });

# 10022001
# 01022010
# 11022011
# 02022020
# 03022030
# 04022040
# 05022050
# 06022060
# 07022070
# 08022080
# 09022090