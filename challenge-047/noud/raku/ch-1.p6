# Roman Calculator
#
# Write a script that accepts two roman numbers and operation. It should then
# perform the operation on the give roman numbers and print the result.
#
# For example,
#
#   perl ch-1.pl V + VI
#
# It should print
#
#   XI


my @roman-symbols = [
    1_000, "M",
    900, "CM",
    500, "D",
    400, "CD",
    100, "C",
    90, "XC",
    50, "L",
    40, "CL",
    10, "X",
    9, "IX",
    5, "V",
    4, "IV",
    1, "I"
];

sub to-roman($i) {
    for @roman-symbols -> $k, $v {
        if ($i >= $k) {
            return $v ~ to-roman($i - $k);
        }
    }
    return '';
}

# It's assumed that the input is always a ROMAN number. No validation checks
# are done.
sub from-roman($s) {
    for @roman-symbols -> $k, $v {
        my $r = $s ~~ / ^$v(\w*) /;
        if ($r) {
            return $k + from-roman(Str($r[0]));
        }
    }
    return 0;
}

my %operators =
    '+' => { $_[0] + $_[1] },
    '*' => { $_[0] * $_[1] },
    '-' => { $_[0] - $_[1] },
    '/' => { Int($_[0] / $_[1]) },
    '%' => { $_[0] % $_[1] },
;

sub MAIN($a, $op, $b) {
    say to-roman(%operators{$op}((from-roman($a), from-roman($b))));
}
