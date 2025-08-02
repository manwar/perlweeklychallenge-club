use v5.36;
use List::Util qw( sum );
for my $num (1 .. 50) {
    say $num if is_niven($num);
}
sub is_niven ($num) {
    $num % (sum split("", $num)) == 0
}
