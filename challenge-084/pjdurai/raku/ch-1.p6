use Test;

# Positive
multi solve(Int $N where * >= 0){
    my $reversed-num = val $N.Str().flip();
    return 0 if $reversed-num > int32.Range[*-1];
    $reversed-num;
}

# Negative
multi solve(Int $N where * < 0){
    - solve abs $N;
}

multi MAIN() {
    ok solve(1234) == 4321, "1234  =>  4321";
    ok solve(1231230512) == 0, "1231230512 => 0";
    ok solve(-1234) == -4321, "-1234 => -4321";
}

multi MAIN(Int $N) {
    say solve($N);
}
