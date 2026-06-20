use v5.36;

(my ($x, $y, $z) = @ARGV) == 3
    or die "Usage: STR1 STR2 STR3\n";

tr/a-j/0-9/ for $x, $y, $z;
say qw(false true)[$x + $y == $z];
