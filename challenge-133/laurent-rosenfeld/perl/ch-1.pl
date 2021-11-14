use strict;
use warnings;
use feature "say";

sub sqroot {
    # Bisection method
    my $c = shift;
    my $start = 1;
    my $end = $c;
    my $est = 2 ** (int((log($c)/log(2))/2) + 1);
    while (1) {
        say "\tIntermediate values: $start, $est, and $end";
        last if abs($end-$start) <= 1;
        if ($est ** 2 > $c) {
            $end = $est;
        } else {
            $start = $est;
        }
        $est = int (($end + $start) / 2);
    }
    return $est;
}
say "$_\t", sqroot $_ for 85, 101, 200_000_000;
