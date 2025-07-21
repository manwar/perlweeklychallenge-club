#!/usr/bin/perl
use warnings;
use strict;
use feature qw( bitwise );
use experimental qw( signatures );

sub buddy_strings($source, $target) {
    my $xor = $source ^. $target;
    return $xor =~ /^\x00*([^\x00])\1\x00*$/        ? 1
         : $source eq $target && $source =~ /(.)\1/ ? 1
         :                                            0
}

use Test2::V0;
use constant {
    true  => bool(1),
    false => bool(0)
};

plan(4 + 1);

is buddy_strings('fuck', 'fcuk'), true,  'Example 1';
is buddy_strings('love', 'love'), false, 'Example 2';
is buddy_strings('fodo', 'food'), true,  'Example 3';
is buddy_strings('feed', 'feed'), true,  'Example 4';

is buddy_strings('nuclear', 'unclear'), true, 'Beginning';
