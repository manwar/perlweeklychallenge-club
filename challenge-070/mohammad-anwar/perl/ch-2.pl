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

my $N = $ARGV[0] || 3;

print sprintf("%d-bit Gray Code Sequence:\n[%s]\n",
              $N, join ', ', generate_gray_code_sequence($N));

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
