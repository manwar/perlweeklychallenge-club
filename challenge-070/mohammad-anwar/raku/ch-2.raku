#!/usr/bin/env raku

#
# Perl Weekly Challenge - 070
#
# Task #2: Gray Code Sequence
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-070
#

use v6.d;

sub MAIN(Int :$N = 3) {
    say sprintf("%d-bit Gray Code Sequence:\n[%s]",
                $N, generate-gray-code-sequence($N).join(', '));
}

sub generate-gray-code-sequence(Int $n) {

    my %S = (
        2 => ['00', '01', '11', '10'],
    );

    for 3 .. $n -> $i {
        my $S1 = %S{$i - 1};
        my $S2 = [ |$S1.reverse ];
        $S1.map({ $_ = '0' ~ $_ });
        $S2.map({ $_ = '1' ~ $_ });
        %S{$i} = [ |$S1, |$S2 ];
    }

    my @gray_codes = ();
    for %S{$n} -> $list {
        for |$list -> $binary {
            @gray_codes.push: to-decimal($binary);
        }
    }

    return |@gray_codes;
}

sub to-decimal(Str $binary) {
    return ":2<$binary>".Int;
}
