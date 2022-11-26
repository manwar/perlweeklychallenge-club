# The Weekly Challenge 192
# Task 2 Equal Distribution

use v5.30.0;
use List::Util qw/sum/;

say eq_dist(@ARGV) if defined($ARGV[0]);

sub eq_dist {
    my @list = @_;
    my $n = scalar @list;
    my $avg = (sum @list)/$n;
    return -1 if $avg =~ /\./;
    say "start: ", join ", ", @list;
    my $move = 0;
    for my $i (0..$n-1) {
        while ($list[$i] < $avg) {
            my $j = $i;
            while ($list[$j]-sum(@list[$i..$j-1]) < $avg
                    && $list[$j] <= $avg)
            {
                $j++;
            }
            if ($j>$i) {
                for (1..$list[$j]-$avg) {
                    $list[$j-1]++;
                    $list[$j]--;
                    say join ", ", @list;
                    $move++;
                    last if sum(@list[$i..$j-1]) == $avg*($j-$i);
                }
            }
        }
        if ($list[$i] > $avg) {
            for (1..$list[$i]-$avg) {
                $list[$i+1]++;
                $list[$i]--;
                say join ", ", @list;
                $move++;
            }
        }
    }
    return $move;
}


use Test::More tests=>6;
ok eq_dist(1, 0, 5) == 4;
ok eq_dist(0, 2, 0) == -1;
ok eq_dist(0, 3, 0) == 2;

ok eq_dist(3, 3, 3, 3) == 0;
ok eq_dist(5, 0, 1) == 4;
ok eq_dist(5, 6, 0, 1) == 9;
