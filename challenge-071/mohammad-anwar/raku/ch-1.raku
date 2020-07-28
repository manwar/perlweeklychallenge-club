#!/usr/bin/env raku

#
# Perl Weekly Challenge - 071
#
# Task #1: Peak Elements
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-071
#

use v6.d;

sub MAIN(Int :$N where { $N > 1 } = 10) {
    my @random-array  = random-array($N);
    my @peak-elements = find-peak-elements-in(@random-array);

    say sprintf("Array: [%s]", join ', ', @random-array);
    say sprintf(" Peak: [%s]", join ', ', @peak-elements);
}

#
#
# METHODS

sub find-peak-elements-in($array where { $_ > 0 }) {

    my @peak-elements = Empty;
    if $array.elems >= 2 {

        if ($array[0] > $array[1]) {
            @peak-elements.push: $array[0];
        }

        for 1 .. $array.elems-2 -> $i {
            if $array[$i] > $array[$i-1]
               &&
               $array[$i] > $array[$i+1] {

               @peak-elements.push: $array[$i];
            }
        }

        if $array[*-1] > $array[*-2] {
            @peak-elements.push: $array[*-1];
        }
    }

    return |@peak-elements;
}

sub random-array(Int $size is copy) {

    my %elements = ();
    while $size >= 1 {
        my $element = (^50).pick;
        next if %elements{$element}:exists;
        %elements{$element} = 1;
        $size--;
    }

    return (%elements.keys);
}
