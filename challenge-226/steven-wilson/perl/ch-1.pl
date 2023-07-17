#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

my $t_s1 = "lacelengh";
my @t_i1 = (3,2,0,5,4,8,6,7,1);
my $t_s2 = "rulepark";
my @t_i2 = (4,7,3,1,0,5,2,6);
cmp_ok( reorder_string( $t_s1, @t_i1 ), "eq", "challenge", "Example 1");
cmp_ok( reorder_string( $t_s2, @t_i2 ), "eq", "perlraku", "Example 2");
done_testing();

sub reorder_string {
    my ($s, @i) = @_;
    my @return_s;
    for (  0 .. (length ($s) - 1) ){
        $return_s[ $i[$_]  ] = substr( $s, $_, 1 );
    }
    local $" = '';
    return "@return_s";
}

