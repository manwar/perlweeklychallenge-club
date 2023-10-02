#!/usr/bin/env raku
use Test;

is max-words(("Perl and Raku belong to the same family.",
              "I love Perl.",
              "The Perl and Raku Conference.")), 8;

is max-words(("The Weekly Challenge.",
              "Python is the most popular guest language.",
              "Team PWC has over 300 members.")), 7;

sub max-words($list)
{
    $list>>.words>>.elems.max
}
