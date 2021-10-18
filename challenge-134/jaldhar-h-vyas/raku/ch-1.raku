#!/usr/bin/raku

sub MAIN {

    my $prefix = '102345';

    (<6 7 8 9>
        .permutations 
        .map({ $_.join })
        .map({ $prefix ~ $_ })
        .sort({$^a <=> $^b}))[^10]
        .join(q{ })
        .say;
}