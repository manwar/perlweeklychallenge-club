#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ maxstr };

sub greatest_english_letter($str) {
    my %lower;
    undef @lower{ map ucfirst, $str =~ /[[:lower:]]/g };
    my $l = uc join "", keys %lower;
    return maxstr($str =~ /[$l]/g) // ""
}

use Test::More tests => 3;

is greatest_english_letter('PeRlwEeKLy'), 'L', 'Example 1';
is greatest_english_letter('ChaLlenge'), 'L', 'Example 2';
is greatest_english_letter('The'), "", 'Example 3';
