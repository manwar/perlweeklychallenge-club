#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);

sub max_words
{
  max map{scalar split ' ',$_} @{$_[0]};
}

printf "%d\n", max_words(["Perl and Raku belong to the same family.",
			  "I love Perl.",
			  "The Perl and Raku Conference."]);
printf "%d\n", max_words(["The Weekly Challenge.",
			  "Python is the most popular guest language.",
			  "Team PWC has over 300 members."]);
