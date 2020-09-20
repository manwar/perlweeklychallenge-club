#!perl

use strict;
use warnings;
use List::Util qw(reduce);
use experimental 'signatures';

sub get_leaders {
    my @A           =               ( 9, 10, 7, 5, 6, 1 );
    my $a_indexes   = sub           { 0 .. @A - 1 };
    my $is_last     = sub($i)       { $i == @A - 1 };
    my $current     = sub($i)       { $A[$i] };
    my $following   = sub($i)       { $A[$i + 1] };
    my $is_leading  = sub($i)       { $current->($i) > $following->($i) };
    my $is_leader   = sub($i)       { $is_last->($i) || $is_leading->($i) };
    my $if_leader   = sub($i)       { $is_leader->($i) ? $current->($i) : () };
    my $push_leader = sub($lst, $i) { push @{$lst}, $if_leader->($i); $lst };

    my $result = reduce { $push_leader->($a, $b) } [], $a_indexes->();

    @A == 0 ? (0) : $result->@*;
}

print join q(, ), get_leaders();