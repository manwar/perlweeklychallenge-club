use strict;
use warnings;

sub calculate {
    my ($expression) = @_;
    return eval $expression;
}

print calculate("10 + 20 - 5");  # Outputs: 25
print calculate("(10 + 20 - 5) * 2");  # Outputs: 50

