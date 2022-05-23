my $input =
   '333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
    341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
    284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
    128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
    215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
    275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89';

# $input = '1,0 2,1 3,2 4,3'; # test with a negative intercept

my @points = $input.split(/\s+/)».split(/','/);
my ($slope, $intercept) = lsm(@points);
say "Slope: $slope, intercept = $intercept";
my $sign = $intercept < 0 ?? '-' !! '+';
printf "The equation of the line of best fit is: y = %.2f x %s %.2f \n", $slope, $sign, $intercept.abs;

sub lsm (@points) {
    my ($s-x, $s-y, $s-xy, $s-x2) = 0 xx 4;
    for @points -> $point {
        my ($x, $y) = $point[0, 1];
        $s-x += $x;
        $s-y += $y;
        $s-xy += $x * $y;
        $s-x2 += $x ** 2;
    }
    my $n = @points.elems;
    my $slope = ($n * $s-xy - $s-x * $s-y) / ($n * $s-x2 - $s-x ** 2);
    my $intercept = ($s-y - $slope * $s-x) / $n;
    return $slope, $intercept;
}
