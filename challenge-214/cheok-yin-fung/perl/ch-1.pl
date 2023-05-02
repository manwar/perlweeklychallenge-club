# The Weekly Challenge 214
# Task 1 Rank Score
use v5.30.0;
use warnings;


sub rs {
    my @scores = @_; 
    my @mscores = sort {$b<=>$a} @scores;

    my @mrank = (1);
    my %s_r;
    my $i = 1;
    my $acc = 0;
    $s_r{$mscores[0]} = 1;
    for my $s (1..$#mscores) {
        if ($mscores[$s-1] == $mscores[$s]) {
            $acc++;
        } else {
            $i = $i + $acc + 1;
            $acc = 0;
        }
        push @mrank, $i;
    }
    $s_r{$mscores[$_]} = $mrank[$_] for (0..$#scores);
    my @numeric_rank = map { $s_r{$_} } @scores;
    my @rank = map { $_ == 1 ? "G"
                   : $_ == 2 ? "S"
                   : $_ == 3 ? "B"
                   : $_ } @numeric_rank;
    return @rank;
}

use Test::More tests=>4;
use Test::Deep;
cmp_deeply [rs(1,2,4,3,5)], [5,4,"S","B","G"];
cmp_deeply [rs(8,5,6,7,4)], ["G",4,"B","S",5];
cmp_deeply [rs(3,5,4,2)], ["B","G","S",4];
cmp_deeply [rs(2,5,2,1,7,5,1)], [4,"S",4,6,"G","S",6];

