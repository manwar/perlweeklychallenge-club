use v6;

# Note: IMHO, FNR is ill-defined. I'll use my own rules.
my $S = 'ababcbaddccaad';
my @chars = $S.comb;
my $result = "";
my %seen;
for (@chars) {
    my $fnr = "#";
    for @chars -> $char {
        $fnr = $char and last unless %seen{$char};
        $fnr = $char and last if %seen{$char} < 2;
    }
    $result ~= $fnr;
    %seen{$_}++;
}
say $result;
