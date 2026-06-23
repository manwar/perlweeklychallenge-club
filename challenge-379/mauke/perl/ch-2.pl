use v5.36;
use List::Util qw(sum0);

sub armstrong($digits) {
    sum0 map $_ ** @$digits, @$digits
}

sub based($num, $base) {
    my @digits;
    while ($num > 0) {
        push @digits, $num % $base;
        $num = int($num / $base);
    }
    \@digits
}

sub is_armstrong($num, $base) {
    $num == armstrong based $num, $base
}

(my ($base, $limit) = @ARGV) == 2
    or die "Usage: $0 BASE LIMIT\n";

say join ', ', grep is_armstrong($_, $base), 0 .. $limit - 1;
