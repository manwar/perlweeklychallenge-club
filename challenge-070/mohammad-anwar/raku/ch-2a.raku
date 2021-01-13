#!/usr/bin/env raku

#
# Perl Weekly Challenge - 070
#
# Task #2: Gray Code Sequence
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-070
#

use Test;

is-deeply generate-gray-code-sequence(3),
          (0, 1, 3, 2, 6, 7, 5, 4),
          'testing 3-bin grey code sequence.';

is-deeply generate-gray-code-sequence(4),
          (0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8),
          'testing 4-bit grey code sequence.';

done-testing;

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
