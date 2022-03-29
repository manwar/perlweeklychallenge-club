use strict;
use warnings;
use feature qw /say/;
use constant DIGITS => ('0'..'9', 'A'..'Z');

sub to_base_b { # Converts decimal number to base b string
    my($dec, $base) = @_;
    my @digits;
    while ($dec) {
        unshift @digits, (DIGITS)[$dec % $base];
        $dec = int($dec/$base);
    }
    return join "", @digits;
}

sub is_brazilian {
    my $n = shift;
    return 1 if $n % 2 == 0 and $n >= 8;
    return 0 if $n <= 3;
    for my $base (2..$n-2) {
        return 1 if to_base_b($n, $base) =~ /^(\d)\1+$/;
    }
    0;
}

say "Brazilian numbers less than or equal to 36 are:";
for my $m (1..36) {
    print "$m " if is_brazilian($m);
}
say "";
