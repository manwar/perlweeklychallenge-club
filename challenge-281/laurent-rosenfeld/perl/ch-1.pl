use strict;
use warnings;
use feature 'say';

sub check_color {
    my ($abscissa, $ordinate) = split //, shift;
    my $code = 1;
    $code = 0 if $abscissa =~ /[aceg]/;
    return "True" if ($code + $ordinate) % 2 == 0;
    return "False";
}

for my $coordinates (qw<a1 d3 g5 e6 h8>) {
    printf "%-2s => ", $coordinates;
    say check_color $coordinates;
}
