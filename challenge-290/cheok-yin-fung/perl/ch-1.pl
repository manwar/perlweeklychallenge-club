# The Weekly Challenge 290
# Task 1 Double Exist
use v5.30;
use warnings;

sub de {
    my @arr = $_[0]->@*;
    my %save;
    my $i = 0;
    do {
        return 1 if $save{0} && $arr[$i] == 0; # special case
        $save{$arr[$i]*2} = 1;
        $save{$arr[$i]/2} = 1 if $arr[$i] % 2 == 0;
        $i++;
    } while ($i < @arr && (!defined $save{$arr[$i]} || $arr[$i] == 0));
    return 0 if $i == @arr;
    return $save{$arr[$i]};
}

use Test::More tests=>6;
ok de [6,2,3,3];
ok !de [3,1,4,13];
ok de [2,1,4,2];
ok de [0,0,1,5];
ok !de [3,0,1];
ok de [2,3,9,1];
