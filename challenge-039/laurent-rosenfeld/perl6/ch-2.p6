use v6;
use Test;

my %operations = (
    '+' => { $^a + $^b; },
    '-' => { $^a - $^b; }, # hyphen
    '−' => { $^a - $^b; }, # dash
    'x' => { $^a * $^b; },
    '*' => { $^a * $^b; },
    '×' => { $^a * $^b; },
    '/' => { $^a / $^b; },
    '÷' => { $^a / $^b; },
);

sub parse_operation (Str $expr) {
    my @stack;
    for $expr.split(/\s+/) -> $token {
        if $token ~~ /^ \d+ $/ {
            push @stack, $token ;
        } elsif (%operations{$token}:exists) {
            return "Invalid RPN expression" if @stack.elems < 2;
            my $op2 = pop @stack;
            my $op1 = pop @stack;
            push @stack, %operations{$token}($op1, $op2);
        } else {
            die "Invalid token $token.";
        }
    }
    return @stack[0]
}
plan 5;
is parse_operation("1 2 +"), 3, "2 operands";
is parse_operation("1 2 + 4 ×"), 12, "3 operands, a Unicode multiplication operator";
is parse_operation("1 2 + 4 * 5 + 3 -"), 14, "5 operands";
is parse_operation("3 4 5 x -"), -17, "Start with 3 operands and then two operators";
is parse_operation("15 7 1 1 + − ÷ 3 × 2 1 1 + + −"), 5, "8 operands, 4 Unicode operators";
