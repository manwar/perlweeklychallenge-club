use strict;
use warnings;
use feature qw/say/;

# Note: IMHO, FNR is ill-defined. I'll use my own rules.
my $S = 'ababcbad';
my @chars = split //, $S;
my $result = "";
my %seen;
for (@chars) {
    my $fnr = "#";
    for my $char (@chars) {
        $fnr = $char and last unless $seen{$char};
        $fnr = $char and last if $seen{$char} < 2;
    }
    $result .= $fnr;
    $seen{$_} ++;
}
say $result;
