#!/usr/bin/env raku

sub max_words(@arr)
{
  @arr.map({.split(' ').elems}).max;
}

say max_words(["Perl and Raku belong to the same family.",
	       "I love Perl.",
	       "The Perl and Raku Conference."]);
say max_words(["The Weekly Challenge.",
	       "Python is the most popular guest language.",
	       "Team PWC has over 300 members."]);

