#!/usr/bin/env perl

use v5.40;

use Test2::V0;

sub title_capital ($string) {
    my @words = split / /, $string;
    foreach (@words) {
        $_ = lc;
        $_ = ucfirst if length > 2;
    }
    return join ' ', @words;
}

is title_capital('PERL IS gREAT'), 'Perl is Great', 'Example 1';
is title_capital('THE weekly challenge'), 'The Weekly Challenge', 'Example 2';
is title_capital('YoU ARE A stAR'), 'You Are a Star', 'Example 3';

done_testing;
