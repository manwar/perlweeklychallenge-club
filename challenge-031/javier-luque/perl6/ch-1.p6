use v6.d;

sub MAIN () {
    # A few test cases
    my @array = ['1/0', '1/2', '0/100'];
    for @array -> $array-item {
        divide-by-zero-check($array-item);
    }
}

# Catch the error and say if we can't divide by 0
sub divide-by-zero-check(Str $statement) {
    try {
        my $answer = Rat($statement);
        say $answer;

        CATCH {
            default { say "divide by 0 error, $_" }
        }
    }
}
