#!/usr/bin/perl
use v5.10;
use strict;
use warnings FATAL => 'all';
our $VERSION = '0.01';

sub specialQuadruplets
{
    my (@nums) = @_;
    my $count = 0;

    for (my $x = 0; $x <= $#nums - 3; $x++)
    {
        for (my $y = $x + 1; $y <= $#nums - 2; $y++)
        {
            for (my $z = $y + 1; $z <= $#nums - 1; $z++)
            {
                for (my $d = $z + 1; $d <= $#nums; $d++)
                {
                    if ($nums[$x] + $nums[$y] + $nums[$z] == $nums[$d])
                    {
                        $count++;
                    }
                }
            }
        }
    }
    return $count;
}


use Test::More tests => 3;
ok specialQuadruplets(1, 2, 3, 6) == 1;
ok specialQuadruplets((1, 1, 1, 3, 5)) == 4;
ok specialQuadruplets(3, 3, 6, 4, 5) == 0;
