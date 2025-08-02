#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub title_capital($str) {
    join ' ', map length > 2 ? ucfirst lc : lc, split / /, $str
}

use Test::More tests => 3;

is title_capital('PERL IS gREAT'), 'Perl is Great', 'Example 1';
is title_capital('THE weekly challenge'), 'The Weekly Challenge', 'Example 2';
is title_capital('YoU ARE A stAR'), 'You Are a Star', 'Example 3';
