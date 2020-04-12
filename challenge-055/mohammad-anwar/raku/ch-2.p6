#!/usr/bin/env perl6

use v6.c;

multi sub MAIN(*@) is hidden-from-USAGE {
    say $*USAGE;
    say "\nERROR: Invalid array size !!!";
}

multi sub MAIN(Int :$N = 4) {
    my @wave = fetch-wave-array($N);
    @wave.map({ print sprintf("[%s]\n", join(",", @$_)) });
}

sub fetch-wave-array($size) {
    die "ERROR: Invalid array size [$size]\n"
        unless ($size ~~ /^\d+$/ && $size > 0);

    my @N = (1 .. $size).permutations();
    my @wave = ();
    for @N -> @array {
        push @wave, @array if is-wave(@array);
    }

    return @wave;
}

sub is-wave(@array) {

    my $is-wave = 1;
    for 1 .. @array.elems-1 -> $i {
        ($i mod 2 == 1)
        ??
        (@array[$i] <= @array[$i-1])
        !!
        (@array[$i] >= @array[$i-1])
        and next;

        $is-wave = 0;
        last;
    }

    return $is-wave;
}
