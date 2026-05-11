#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub rearrange_spaces($str) {
    my $space_count = $str =~ tr/ //;
    my @words = split ' ', $str;
    my $width = @words > 1 ? int($space_count / (@words - 1)) : 0;
    my $rest = @words > 1 ? $space_count % (@words - 1) : $space_count;
    return join(' ' x $width, @words) . ' ' x $rest
}

use Test::More tests => 5;

is rearrange_spaces('  challenge  '), 'challenge    ', 'Example 1';
is rearrange_spaces('coding  is  fun'), 'coding  is  fun', 'Example 2';
is rearrange_spaces('a b c  d'), 'a b c d ', 'Example 3';
is rearrange_spaces('  team      pwc  '), 'team          pwc', 'Example 4';
is rearrange_spaces('   the  weekly  challenge  '),
                    'the    weekly    challenge ',
                    'Example 5';
