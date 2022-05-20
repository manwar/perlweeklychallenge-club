use strict;
use warnings;
use feature "say";

my $input =
   '333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
    341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
    284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
    128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
    215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
    275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89';

# $input = '1,0 2,1 3,2 4,3';   # test with a negative intercept

my @points = map { [split /,/, $_] } split /\s+/, $input;
my ($sl, $inter) = lsm(@points);
say "Slope: $sl, intercept = $inter";
my $sign = $inter < 0 ? '-' : '+';
printf "The equation of the line of best fit is: y = %.2f x %s %.2f \n", $sl, $sign, abs $inter;

sub lsm {
    my @points = @_;
    my ($s_x, $s_y, $s_xy, $s_x2) = (0, 0, 0, 0);
    for my $point (@points) {
        my ($x, $y) = ($point->[0], $point->[1]);
        $s_x += $x;
        $s_y += $y;
        $s_xy += $x * $y;
        $s_x2 += $x ** 2;
    }
    my $n = scalar @points;
    my $slope = ($n * $s_xy - $s_x * $s_y) / ($n * $s_x2 - $s_x ** 2);
    my $intercept = ($s_y - $slope * $s_x) / $n;
    return $slope, $intercept;
}
