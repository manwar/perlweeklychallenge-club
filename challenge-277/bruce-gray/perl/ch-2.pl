use v5.40;
use List::Util qw<uniq min>;
use ntheory    qw<forcomb>;

sub Triangle       ($n) {      $n * ($n-1) / 2   }  # https://oeis.org/A000217
sub Quarter_square ($n) { int( $n *  $n    / 4 ) }  # https://oeis.org/A002620
sub N42            ($n) { 4 ** $n   -   2 ** $n  }  # https://oeis.org/A020522

# From Raku: task2_combo_unique
sub task2a ($unordered_nonunique_numbers_aref) {
    my @ns = uniq @{$unordered_nonunique_numbers_aref};

    my $r = 0;
    forcomb {
        my ( $x, $y ) = @ns[@_];
        my $s = abs( $x - $y );
        $r++ if 0 < $s and $s < min($x, $y);
    } @ns, 2;

    return $r;
}

# From Raku: task2_linear_after_sort_early_return
sub task2b ($unordered_nonunique_numbers_aref) {
    my @ns = sort { $a <=> $b }
             uniq @{$unordered_nonunique_numbers_aref};

    my $highest = $ns[-1];

    my $y = 0;
    my $r = 0;
    for my $x ( keys @ns ) {
        my $xv2 = $ns[$x] * 2;

        if ($xv2 > $highest) {
            $r += Triangle(+@ns - $x);
            last;
        }

        $y++ while ($y+1) <= $#ns and $ns[$y+1] < $xv2;

        $r += $y - $x;
    }

    return $r;
}


my @tests = (
    [ 4, [1, 2, 3, 4, 5] ],
    [ 1, [5, 7, 1, 7] ],

    [    3, [6, 7, 8] ],
    [  241, [ 2,2,2,2,2,2,2,2,2,2,4,3,4,4,3,4,4,4,3,3,5,6,7,7,8,8,5,5,5,5,16,14,15,10,12,16,13,13,14,10,22,24,27,23,21,31,27,25,23,28,42,53,60,58,57,58,33,39,62,38,88,115,108,79,80,90,101,79,127,96 ] ],
    [  467, [ 2,2,2,2,2,2,2,2,2,2,4,3,4,4,3,3,3,3,3,4,7,6,8,8,8,6,6,5,5,5,12,16,12,12,13,16,15,9,16,14,25,26,21,18,21,32,29,25,25,25,54,51,49,46,39,54,49,64,37,42,86,93,123,101,70,96,71,125,86,104,131,165,160,217,241,239,217,234,210,193,409,376,390,419,501,313,387,500,403,465,646,564,639,997,720,513,928,796,848,869 ] ],
);

my $EXTRA_TESTS = true;
if ($EXTRA_TESTS) {

    for my $i (1..100) {
        my $Qi1 = Quarter_square($i-1);
        push @tests, [ $Qi1     , [1..$i] ] if $i > 1+1;
        push @tests, [ $Qi1     , [2..$i] ] if $i > 2+1;
        push @tests, [ $Qi1 -  1, [3..$i] ] if $i > 3+1;
        push @tests, [ $Qi1 -  3, [4..$i] ] if $i > 4+1;
        push @tests, [ $Qi1 -  6, [5..$i] ] if $i > 5+1;
        push @tests, [ $Qi1 - 10, [6..$i] ] if $i > 6+2;
        push @tests, [ $Qi1 - 15, [7..$i] ] if $i > 7+3;
        push @tests, [ $Qi1 - 21, [8..$i] ] if $i > 8+4;
    }

    for my $N (1..100) {
        push @tests, [ Triangle($N) , [$N .. (2*$N)-1] ];
    }

    for my $N (2..11) {
        push @tests, [ N42($N) , [1 .. (2 ** ($N+1))] ];
    }

}
my @subs = (
    # Fastest to slowest
    [ task2b => \&task2b ],
    [ task2a => \&task2a ],
);
use Test::More; plan tests => @subs * @tests;
for my $aref (@subs) {
    my ($sub_name, $task2_subref) = @{$aref};
    for (@tests) {
        my ( $expected, $ns ) = @{$_};
        is $task2_subref->($ns), $expected;
    }
}
