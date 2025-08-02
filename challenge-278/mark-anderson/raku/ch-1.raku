#!/usr/bin/env raku
use Test;

is sort-string("and2 Raku3 cousins5 Perl1 are4"),
               "Perl and Raku are cousins";

is sort-string("guest6 Python1 most4 the3 popular5 is2 language7"),
               "Python is the most popular guest language";

is sort-string("Challenge3 The1 Weekly2"),
               "The Weekly Challenge";

sub sort-string($str is copy)
{
    my @i = $str ~~ s:g/ <.digit>+ >> //;
    my %m is Map = @i Z=> $str.words;
    ~%m{ 1..%m }
}
