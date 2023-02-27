#!/usr/bin/env perl
=begin comment
-------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-02-20
Challenge 205 Maximum XOR ( Perl )
-------------------------------
=cut

use strict;
use warnings;
use Algorithm::Permute;

my $maxv = 0;
my @array = ([1,2,3,4,5,6,7], [2,4,1,3], [10,5,7,12,8]);

for (@array) {
    my @a = @$_;
    my @a_jn = join(",",@a);
    print("Input: \@array = (",@a_jn,")\n");
    my $p = Algorithm::Permute->new(\@a, 2);
    while (my @res = $p->next) {
        my $x = $res[0] ^ $res[1];
        if ($x > $maxv) {
            $maxv = $x;
        }
    }
    print("Output: $maxv\n");
    $maxv = 0;
    print("\n");
}

=begin comment
-------------------------------
SAMPLE OUTPUT
perl .\MaximumXOR.pl
Input: @array = (1,2,3,4,5,6,7)
Output: 7

Input: @array = (2,4,1,3)
Output: 7

Input: @array = (10,5,7,12,8)
Output: 15
-------------------------------


