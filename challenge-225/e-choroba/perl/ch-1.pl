#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ max };

sub max_words(@list) {
    return max(map { my $c = () = /\w+/g } @list)
}

use Test::More tests => 2;

is max_words("Perl and Raku belong to the same family.",
             "I love Perl.",
             "The Perl and Raku Conference."),
    8, 'Example 1';

is max_words("The Weekly Challenge.",
             "Python is the most popular guest language.",
             "Team PWC has over 300 members."),
    7, 'Example 2';
