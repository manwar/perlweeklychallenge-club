# The Weekly Challenge 210
# Task 2 Number Collision
use v5.30.0;
use warnings;
sub nc {
    my @a = $_[0]->@*;
    my $num_of_coll;
    do {
        my @remain = ();
        my $last_ind = -1;
        $num_of_coll = 0;
        for my $i (1..$#a) {
            if ($a[$i-1] >= 0 && $a[$i] <= 0) {
                if ($a[$i-1] != 0 || $a[$i] != 0) {
                    push @remain, $a[$i-1] if abs($a[$i-1]) > abs($a[$i]);
                    push @remain, $a[$i] if abs($a[$i-1]) < abs($a[$i]);
                    $num_of_coll++;
                    $last_ind = $i;
                    last;
                }
            }
            else {
                push @remain, $a[$i-1];
                $last_ind = $i-1;
            }
        }
        push @remain, @a[$last_ind+1..$#a];
        @a = @remain;
    } until ($num_of_coll == 0);
    return [@a];
}



use Test::More tests=>4;
use Test::Deep;
cmp_deeply nc([2, 3, -1]), [2, 3];
cmp_deeply nc([3, 2, -4]), [-4];
cmp_deeply nc([1, -1]), [];
cmp_deeply nc([-1, 1]), [-1, 1];
