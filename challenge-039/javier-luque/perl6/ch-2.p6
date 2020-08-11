# Test: perl6 ./ch-2.p6 "15 7 1 1 + − ÷ 3 × 2 1 1 + + −"
use v6.d;

sub MAIN (Str $tokens) {
    say evaluate-stack($tokens.split(/\s/));
}

# Evaluate the stack
sub evaluate-stack(@tokens) {
    my @stack;

    # Some utf-8 friendly operations
    my %operations = (
        '+' => &add,
        '-' => &subtract,
        '−' => &subtract,
        '*' => &multiply,
        '×' => &multiply,
        '÷' => &divide,
        '/' => &divide,
    );

    # Process each token
    for (@tokens) -> $token {
        if (%operations.{$token}) {
            push @stack, %operations.{$token}(@stack);
        } elsif ($token ~~ /\d+/) {
            push @stack, $token;
        }
    }

    # Return the answer
    return pop(@stack);
}

# Operations
sub add(@s)      { return @s.pop + @s.pop }
sub subtract(@s) { return - @s.pop + @s.pop }
sub multiply(@s) { return @s.pop * @s.pop }
sub divide(@s)   { return (1 / @s.pop) * @s.pop }
