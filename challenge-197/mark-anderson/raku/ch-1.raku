#!/usr/bin/env raku
use Test;

is-deeply move-zero(1,0,3,0,0,5), (1,3,5,0,0,0);
is-deeply move-zero(1,6,4),       (1,6,4);
is-deeply move-zero(0,1,0,2,0),   (1,2,0,0,0);

sub move-zero(*@arr)
{
    my $c := classify { $_ == 0 ?? 'zeros' !! 'non-zeros' }, @arr;
    $c<non-zeros>.append: flat $c<zeros> if $c<zeros>;
    $c<non-zeros>.List
}
