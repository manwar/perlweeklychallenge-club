use strict; use warnings; use List::Util 'max'; use Test::More tests=>3;


sub relative_sort {
    my( $list1, $list2 ) = @_;
    my %rank = map { $$list2[$_] => $_ } 0 .. $#$list2;
    sort { ( $rank{$a} // 9e9 ) <=> ( $rank{$b} // 9e9 ) or $a <=> $b } @$list1;
}

is_deeply [ relative_sort( [2,3,9,3,1,4,6,7,2,8,5], [2,1,4,3,5,6] ) ] => [2,2,1,4,3,3,5,6,7,8,9];
is_deeply [ relative_sort( [3,3,4,6,2,4,2,1,3],     [1,3,2]       ) ] => [1,3,3,3,2,2,4,4,6];
is_deeply [ relative_sort( [3,0,5,0,2,1,4,1,1],     [1,0,3,2]     ) ] => [1,1,1,0,0,3,2,4,5];
