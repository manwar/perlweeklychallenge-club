# The Weekly Challenge 177
# Task 1 Damm Algorithm
use v5.30.0;

say damm_check($ARGV[0] || 5724)? "valid": "invalid";


sub damm_check {
    my $num = $_[0];

    my @operation_table = ( 
        [0, 3, 1, 7, 5, 9, 8, 6, 4, 2],
        [7, 0, 9, 2, 1, 5, 4, 8, 6, 3],
        [4, 2, 0, 6, 8, 7, 1, 3, 5, 9],
        [1, 7, 5, 0, 9, 8, 3, 4, 2, 6],
        [6, 1, 2, 3, 0, 4, 5, 9, 7, 8],
        [3, 6, 7, 4, 2, 0, 9, 5, 8, 1],
        [5, 8, 6, 9, 7, 2, 0, 1, 3, 4],
        [8, 9, 4, 5, 3, 6, 2, 0, 1, 7],
        [9, 4, 3, 8, 6, 1, 7, 2, 0, 5],
        [2, 5, 8, 1, 4, 3, 6, 7, 9, 0]
    );

    my $interim = 0;

    my @digit = split "", $num;
    my $i = 0;

    while ($i < scalar @digit - 1) {
        $interim = $operation_table[$interim][$digit[$i]];
        $i++;
    }

    return $digit[$i] == $interim;
}

use Test::More tests => 2;

ok (damm_check(5724));
ok (!damm_check(5725));
