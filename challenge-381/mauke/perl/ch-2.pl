use v5.36;
use List::Util qw(min max);

sub count_mid($ns) {
    my $min = min @$ns;
    my $max = max @$ns;
    scalar grep $min < $_ < $max, @$ns
}

say count_mid \@ARGV;
