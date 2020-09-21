#!/bin/env raku

my Bool $found = False;
my $Num;

# $N:    = (intial N) - @num.sum
# @fibs: fibonacci numbers as candidates
# @num:  solution
sub fib-sum(Int:D $N, @fibs, @num) {
    if $N == 0 {
        say "{ @num.join(' + ') } = $Num";
        $found = True;
        return;
    }
    return unless @fibs;        # all fibonacci numbers are exhausted
    return if $N < @fibs[0];    # impossible to find a solution

    my @F = @fibs;
    my @N = @num;
    @N.push(@F.shift);
    fib-sum($N - @fibs[0], @F, @N);     # try all possibilities that includes current candidate

    fib-sum($N, @F, @num);              # try all possibilities that excludes current candidate
}

sub MAIN(Int:D $N) {
    my Int @fibs = 1, 2, * + * ...^ * > $N;
    $Num = $N;      # remember the initial N

    fib-sum($N, @fibs, Array.new);
    0.say unless $found;
}
