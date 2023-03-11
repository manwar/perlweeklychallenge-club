#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 207 Task 1: Keyboard Word
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;

sub keyboard_words {
    return grep /^( [qwertyuiop]* | [asdfghjkl]* | [zxcvbnm]* )$/xi, @_;
}

use Test::More;

do {
    is_deeply
        [ keyboard_words( @{$_->{INPUT}} ) ], $_->{EXPECTED},
        "keyboard_words( @{$_->{INPUT}} ) == ( @{$_->{EXPECTED}} )";
} for (
    { INPUT    => [ qw( Hello Alaska Dad Peace ) ],
      EXPECTED => [ qw( Alaska Dad ) ] },
    { INPUT    => [ "OMG","Bye" ],
      EXPECTED => [] },
);

done_testing;
