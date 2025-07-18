#!/usr/bin/perl6

sub MAIN(
    Str $expression #= a string consisting of number and the operators +, -, *, /
) {
    my @tokens = $expression.words;
    my @stack;

    for @tokens -> $token {
        if $token.match(/^ <[+-]>? \d+ $/) {
            push @stack, $token;
        } else {
            my $b = @stack.pop;
            my $a = @stack.pop;

            unless $a.defined && $b.defined {
                die "Insufficient operands for '$token'\n";
            }

            my $result;
            given $token {
                when '+' {  $result = $a + $b; } 
                when '-' {  $result = $a - $b; }
                when '*' {  $result = $a * $b; }
                when '/' {
                            if ($b == 0) {
                                die "Division by zero\n";
                            }
                            $result = $a / $b;
                        }
                default { die "Unknown operator: '$token'\n"; }
            }
            push @stack, $result;
        }
    }

    if @stack.elems != 1 {
        die "Invalid expression: stack contains extra values\n";
    }

    say @stack[0];
}
