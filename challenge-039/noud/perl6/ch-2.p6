# Write a script to demonstrate Reverse Polish notation(RPN). Checkout the wiki
# page for more information about RPN.

my %operator = (
    '+' => {$^a + $^b;},
    '-' => {$^a - $^b;},
    '*' => {$^a * $^b;},
    '/' => {$^a / $^b;},
    '%' => {$^a % $^b;},
);

sub rpn($s) {
    my @stack = [];

    for $s.split(/\s+/) -> $a {
        if (%operator{$a}:exists) {
            if (@stack.elems < 2) {
                die "Invalid expression";
            }
            # Don't forget that the last two elements on the stack need to be
            # reversed in the operation.
            my $y = @stack.pop();
            my $x = @stack.pop();
            @stack.push(%operator{$a}($x, $y));
        } elsif ($a ~~ /\d+/) {
            @stack.push(Int($a));
        } else {
            die "Unknown operator $a";
        }
    }

    return @stack.pop();
}


my $s = "";

# (1 + (2 + 3)) + 5 = 11
$s = "1 2 3 + + 5 +";
say "$s " ~ rpn($s) ~ " =";

# (15 / (7 - (1 + 1))) * 3 + (2 + (1 - 1)) = 5
$s = "15 7 1 1 + - / 3 * 2 1 1 + + -";
say "$s " ~ rpn($s) ~ " =";

# (7 * 6) % 7 = 0
$s = "7 6 * 7 %";
say "$s " ~ rpn($s) ~ " =";
