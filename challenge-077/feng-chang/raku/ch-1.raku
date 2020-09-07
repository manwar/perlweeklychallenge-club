#!/bin/env raku

my Bool $found = False;
my $Num;

sub fib-sum(Int:D $N, @fibs, @num) {
    if $N == 0 {
        say "{ @num.join(' + ') } = $Num";
        $found = True;
        return;
    }
    return unless @fibs;
    return if $N < @fibs[0];

    my @F = @fibs;
    my @N = @num;
    @N.push(@F.shift);
    fib-sum($N - @fibs[0], @F, @N);

    fib-sum($N, @F, @num);
}

sub MAIN(Int:D $N) {
    my Int @fibs = 1, 2, * + * ...^ * > $N;
    $Num = $N;

    fib-sum($N, @fibs, Array.new);
    0.say unless $found;
}
