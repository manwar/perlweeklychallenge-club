my $formatter = sub { sprintf '%02d%02d%04d', .month, .day, .year given $^date }; 

.say for (2000..2099)
    .grep({ 
        0 < $^year.substr(2,2).flip < 12 })
    .map({ 
        Date.new($^year, |$year.flip.comb(2), :$formatter ) });