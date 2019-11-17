#!/usr/bin/env perl6
use v6;

sub MAIN(UInt:D $max = 11) {
    die "Max must be ≥ 1" if $max < 1;

    my $maxlen  = (~ $max).chars;
    my $prodlen = (~ $max²).chars;

    # Header line
    print "x".fmt("%{$maxlen+1}s") ~ "|";
    say (1..$max)».fmt("%{$prodlen+1}d").join;

    # Seperator line
    say '-' x ($maxlen+1) ~ '+' ~ '-' x $max*($prodlen+1);

    for 1..$max -> $i {
        # New row
        print $i.fmt("%{$maxlen+1}d") ~ '|';

        for 1..$max -> $j {
            if ($i ≤ $j) {
                print ($i*$j).fmt("%{$prodlen+1}d");
            } else {
                print " " x ($prodlen+1);
            }
        }

        print "\n";
    }
}


