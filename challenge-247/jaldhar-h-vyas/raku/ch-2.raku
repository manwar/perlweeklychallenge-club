#!/usr/bin/raku

sub MAIN(
    Str $s
) {
    my @chars = $s.comb;
    my %pairs;

    for 1 .. @chars.end -> $i {
        %pairs{(@chars[$i - 1], @chars[$i]).join}++;
    }

    say %pairs.keys.sort({ %pairs{$^b} <=> %pairs{$^a} || $^a cmp $^b })[0];
}