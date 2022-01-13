use strict;
use warnings;
use feature "say";

sub calc {
    my $expr = shift;
    return "Not a valid arithmetic expression" unless
        $expr =~ /^[-\d\s+*()]+$/;
    return eval $expr;
}
for my $test ("10 + 20 - 5", "(10 + 20 - 5) * 2", "7 + a", "6 * 7") {
    say calc $test;
}
