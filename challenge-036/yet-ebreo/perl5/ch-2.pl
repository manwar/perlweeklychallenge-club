#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my %boxes = (
    R => {w => 1,   v => 1},
    B => {w => 1,   v => 2},
    G => {w => 2,   v => 2},
    Y => {w => 12,  v => 4},
    P => {w => 4,   v => 10}
);

if (@ARGV < 2) {
    die "Usage:\n\tperl ch-2.pl <max_item> <max_weight>\n\n";
}
my $max_item    = $ARGV[0];
my $max_weight  = $ARGV[1];

my @g_keys  = keys %boxes;
my @g_wt    = map { $boxes{$_}{w} } @g_keys;
my @g_val   = map { $boxes{$_}{v} } @g_keys;
my $max     = 0;
my $mask;

for my $bitmask (1..2**@g_keys) {

    my ($c_weight,$c_value,$c_item_cnt) = (0) x 3;

    for my $p (0..~-@g_keys) {
        if ($bitmask & 1<<$p) {
            
            if ((++$c_item_cnt <= $max_item) && ($c_weight + $boxes{$g_keys[$p]}{w} <= $max_weight)) {
                $c_value    += $boxes{$g_keys[$p]}{v};
                $c_weight   += $boxes{$g_keys[$p]}{w};
            } 
        }
    }
    if ($c_value > $max) {
        $max  = $c_value;
        $mask = $bitmask;
    }
}

say "Color  Value   Weight";
map { ($mask & 1 << $_) && printf ("$g_keys[$_]      %02d      %02d\n", $boxes{$g_keys[$_]}{v}, $boxes{$g_keys[$_]}{w}) } (0..~-@g_keys);
say "Max Value: $max";
=begin
perl .\ch-2.pl 2 15
Color  Value   Weight
B      02      01
P      10      04
Max Value: 12

perl .\ch-2.pl 5 15
Color  Value   Weight
G      02      02
B      02      01
P      10      04
R      01      01
Max Value: 15

perl .\ch-2.pl 1 15
Color  Value   Weight
P      10      04
Max Value: 10
=cut