#!/usr/bin/perl6

sub backtrack($n, @vanEcks) {
    loop (my $i = @vanEcks.elems - 1; $i > 0; $i--) {
        if @vanEcks[$i - 1] == $n {
            return @vanEcks.elems - $i;
        }
    }
    return 0;
}

multi sub MAIN() {
    my @vanEcks = (0);
    my $n = 0;

    while @vanEcks.elems <= 100 {
        @vanEcks.push($n);
        $n = backtrack($n, @vanEcks);
    }

    @vanEcks.join(", ").say;
}
