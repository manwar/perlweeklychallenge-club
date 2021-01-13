#!/usr/bin/env perl

use strict;
use warnings;
use List::Permute::Limit qw(permute_iter permute);
use feature qw/say/;

my @ok_rules = ( 'ae', 'ai', 'ei', 'ia', 'ie', 'io', 'iu', 'oa', 'ou', 'uo', 'ue' );
my %ok_hash = map { $_ => 1} @ok_rules;

sub check_perm {
    my $perm = shift;

    my @perm_arr = @$perm;

    for ( 0 .. scalar @perm_arr - 2 ) {
        return 0 unless $ok_hash{$perm_arr[$_] . $perm_arr[ $_ + 1 ]};
    }

    return 1;
}

sub get_permutations {
    my $count = shift;

    my @wovels = [ 'a', 'e', 'i', 'o', 'u' ];

    my @result;

    my $iter = permute_iter(items=>@wovels, nitems=>$count);
    while (my $ary = $iter->()) {
        say @$ary if check_perm($ary);
    }

}

get_permutations(2);
