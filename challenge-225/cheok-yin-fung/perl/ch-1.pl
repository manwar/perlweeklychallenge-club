# The Weekly Challenge 225
# Task 1 Max Words
use v5.30.0;
use warnings;
use List::Util qw/uniqstr/;

sub mw { 
    my @list = $_[0]->@*;
    my $max = 0;
    s/\p{PosixPunct}/ /g for @list;
    for my $sent (@list) {
        my @arr;
        push @arr, (split /\s+/, $sent);
        my $words = uniqstr @arr;
        $max = $words if $words > $max;
    }
    return $max;
}

use Test::More tests=>2;
ok 8 == mw(["Perl and Raku, belong to the same family.",
                "I love Perl.",
                "The Perl and Raku Conference."]);
ok 7 == mw(["The Weekly Challenge.",
                "Python is the most popular guest language.",
                "Team PWC has over 300 members."]);
