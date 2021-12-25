use v6;
use MONKEY-SEE-NO-EVAL;

sub calc (Str $expr) {
    return "Not a valid arithmetic expression" unless
        $expr ~~ /^<[-\d \s +*()]>+$/;
    return EVAL $expr;
}
for "10 + 20 - 5", "(10 + 20 - 5) * 2", "7 + a", "6 * 7" -> $test {
    say calc $test;
}
