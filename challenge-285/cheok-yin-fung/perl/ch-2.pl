# The Weekly Challenge 285
# Task 2 Making Change
use v5.30;
use warnings;
use List::Util qw/uniqstr/;

my @arr;
$arr[0] = [""];
$arr[1] = ["1"];


sub mc {
    my $amt = $_[0];
    return scalar $arr[$amt]->@* if defined $arr[$amt];
    for (2..$amt-1) {mc($_);}
    if ($amt >= 50) {
        $arr[$amt] = [uniqstr (map {add_amt($arr[$amt-$_], $_)->@*} (1,5,10,25,50))];
    } elsif ($amt >= 25) {
        $arr[$amt] = [uniqstr (map {add_amt($arr[$amt-$_], $_)->@*} (1,5,10,25))];
    } elsif ($amt >= 10) {
        $arr[$amt] = [uniqstr (map {add_amt($arr[$amt-$_], $_)->@*} (1,5,10))];
    } elsif ($amt >= 5) {
        $arr[$amt] = [uniqstr ( map {add_amt($arr[$amt-$_], $_)->@*} (1,5))];
    } elsif ($amt > 0) {
        $arr[$amt] = [uniqstr (add_amt($arr[$amt-1], 1)->@*) ];
    }
    # say join "\n", $arr[$amt]->@*;
    return scalar $arr[$amt]->@*;
}

sub add_amt {
    my @ways = $_[0]->@*;
    my @nways;
    my $c = $_[1];
    foreach my $way (@ways) {
        my @coins = split ",", $way;
        push @coins, $c;
        @coins = sort {$a<=>$b} @coins;
        my $nway = join ",", @coins;
        push @nways, $nway;
    }
    return [@nways];
}

use Test::More tests=>3;
ok mc(9) == 2;
ok mc(15) == 6;
ok mc(100) == 292;
