#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: The Weekly Challenge 131
#               Task 2 - Find Pairs
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 09/25/2021 10:07:38 AM
#===============================================================================

use strict;
use warnings;

sub find_pairs {
    my $what = shift;

    my $pairs = $what->[0];
    my $test_str = $what->[1];

    my %opening;
    my %closing;

    my $switch = 0;

    # load the dicts with the opening and closing chars
    for my $char (split //, $pairs) {
        if ($switch == 0) {
            # opening
            $opening{$char} = 1;
            $switch = 1;
        } else {
            # closing 
            $closing{$char} = 1;
            $switch = 0;
        }
    }

    my $out_opening = '';
    my $out_closing = '';

    for my $char (split //, $test_str) {
        $out_opening .= $char if $opening{$char};
        $out_closing .= $char if $closing{$char};
    }

    return [$out_opening, $out_closing];
}

use Test::More;

is_deeply(find_pairs(['""[]()', '"I like (parens) and the Apple ][+" they said.']), ['"(["', '")]"']);
is_deeply(find_pairs(['**//<>', '/* This is a comment (in some languages) */ <could be a tag>']), ['/**/<', '/**/>']);

done_testing;
