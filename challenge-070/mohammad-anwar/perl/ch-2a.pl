#!/usr/bin/perl

#
# Perl Weekly Challenge - 070
#
# Task #2: Gray Code Sequence
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-070
#

use strict;
use warnings;

use Test::More;
use Test::Deep;

is_deeply( [ generate_gray_code_sequence(3) ],
           [ 0, 1, 3, 2, 6, 7, 5, 4 ],
           'testing 3-bit gray code sequence.' );
is_deeply( [ generate_gray_code_sequence(4) ],
           [ 0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8 ],
           'testing 4-bit gray code sequence.' );

done_testing;

sub generate_gray_code_sequence {
    my ($n) = @_;

    my %S = (
        2 => ['00', '01', '11', '10'],
    );

    foreach my $i (3 .. $n) {
        my $S1 = $S{$i - 1};
        my $S2 = [ reverse @$S1 ];
        $_ = '0' . $_ foreach @$S1;
        $_ = '1' . $_ foreach @$S2;
        $S{$i} = [ @$S1, @$S2 ];
    }

    my @gray_codes = ();
    push @gray_codes, bin2dec($_) foreach (@{$S{$n}});

    return @gray_codes;
}

# Borrowed from Perl Cookbook
# https://www.oreilly.com/library/view/perl-cookbook/1565922433/ch02s05.html

sub bin2dec {
    return unpack("N", pack("B32", substr("0" x 32 . shift, -32)));
}
