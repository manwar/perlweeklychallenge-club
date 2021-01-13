use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:


my ($str, $C, $O) = @ARGV;

$str //= 'perlandraku';
$C   //= 3;
$O   //= 4;

say "Count   $C";
say "Offset  $O";
say "Start   ", $str =~ s/\B/ /gr;       ## easier to see if we spread things out a bit

$str = swap( $str, $C, $O );
say "Result  ", $str =~ s/\B/ /gr;

## ## ## ## ## SUBS:

sub swap {
    my ($str, $C, $O ) = @_;
    my $N = length $str;

    for my $i (1..$C) {
        substr( $str, ($i+$O) % $N, 1) =
            substr( $str, $i % $N, 1,
                substr( $str, ($i+$O) % $N, 1));
    }
    return $str;
}
