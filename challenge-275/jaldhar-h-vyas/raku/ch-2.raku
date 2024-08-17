#!/usr/bin/raku

sub MAIN(
    Str $str,
 ) {
    my @input = $str.comb;
    my $output;
    my $current;

    for @input -> $c {
        if $c ~~ /\d/ {
            $output ~= chr($current.ord + $c);
        } else {
            $current = $c;
            $output ~= $c;
        }
    }

    say $output;
}