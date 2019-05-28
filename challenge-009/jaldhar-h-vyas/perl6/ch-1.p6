#!/usr/bin/perl6

sub MAIN() {
    my $n = 100; # first number with a 5-digit square
    loop {
        my $nsquared = $n * $n;
        my %digits;
        $nsquared.comb.map({ %digits{$_} = True; });
        if (%digits.elems  == 5) { 
            say "$nsquared ($n * $n)";
            last;
        }
        $n++;
    }
}
