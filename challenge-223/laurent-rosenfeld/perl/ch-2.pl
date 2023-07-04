use strict;
use warnings;
use feature 'say';

sub min_index {
    my @in = @_;
    my $min = 0;
    for my $i (0..$#in) {
        $min = $i if $in[$i] < $in[$min];
    }
    return $min;
}
sub max {
    my $max = 0;
    for (@_) {
        $max = $_ if $_ > $max;
    }
    return $max;
}
sub collect {
    my @box = @_;
    my $collected = 0;
    while (@box > 3) {
        my $min = min_index @box;
        $collected += (($box[$min-1 ] // 1) * $box[$min] * ($box[$min+1 ] // 1));
        @box = @box[0..$min-1, $min+1.. $#box];
    }
    $collected += $box[0] * ($box[1] // 1) * ($box[2] // 1) ;
    $collected += (($box[0] ) * ($box[2] // 1)) if @box == 3;
    $collected +=  max(@box);
    return $collected;
}
for my $test  ([3, 1, 5, 8], [1, 5]) {
    printf "%-15s => ", "@$test";
    say collect @$test;
}
