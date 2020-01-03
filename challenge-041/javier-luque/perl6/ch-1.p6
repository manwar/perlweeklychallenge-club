# Test: perl6 ch1.p6
use v6.d;

sub MAIN() {
    for (1..50) -> $i {
        my @factors = factors($i);
        say $i if @factors.elems.is-prime;
    }
}

# This was blatantly copied
sub factors (Int $n) {
    my @list;
    my @prime = grep {.is-prime}, 1..*;
    my $pos = 0;
    my $check = $n;

    while $check > 1 {
        my $factor = @prime[$pos];
        $pos++;
        next unless $check %% $factor;

        $pos = 0;
        $check /= $factor;
        push @list, $factor;
    }

    return @list;
}
