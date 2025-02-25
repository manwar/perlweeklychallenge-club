use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';
use Data::Dumper;

sub run($words, $alien) {
    my %sorting_table;
    my $leading_zeros = length(scalar(@$alien));
    foreach my $c (@$alien) {
        $sorting_table{$c} = sprintf("%0${leading_zeros}d", keys(%sorting_table) + 1);
    }
    return sort { get_sortable($a, \%sorting_table) cmp get_sortable($b, \%sorting_table) } @$words;
}

sub get_sortable($word, $sorting_table) {
    my $sortable;
    for my $c (split //, $word) {
        $sortable .= $sorting_table->{$c};
    }
    return $sortable;
}

is_deeply([run(["perl", "python", "raku"], [qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/])], [("raku", "python", "perl")], "Example 1");
is_deeply([run(["the", "weekly", "challenge"], [qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/])], [("challenge", "the", "weekly")], "Example 2");
