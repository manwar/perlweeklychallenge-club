# The Weekly Challenge 278
# Task 1 Sort String
use v5.30.0;
use warnings;

sub ss {
    my $str = $_[0];
    my @arr = split " ", $str;
    my @brr = (0..$#arr);
    for my $word (@arr) {
        if ($word =~ /^(\w+)(\d+)$/) {
            $brr[$2-1] = $1;
        }
    }
    return join " ", @brr;
}

use Test::More tests=>3;
ok ss("and2 Raku3 cousins5 Perl1 are4") eq  "Perl and Raku are cousins";
ok ss("guest6 Python1 most4 the3 popular5 is2 language7") eq "Python is the most popular guest language";
ok ss("Challenge3 The1 Weekly2") eq  "The Weekly Challenge";
