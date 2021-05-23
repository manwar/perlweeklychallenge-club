#!/usr/bin/env perl6
#
#
#       113-1-represent-yo.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ($target = 55, $digit = 7, $exclude_self = 1) ;


prefilter($target, $digit) 
    ?? say 1
    !! do { my @num = (1..$target-($exclude_self > 0)).grep: /$digit/;
            say sum_from_list( $target, @num ) }

sub sum_from_list( $target, @numbers = (), $sum = 0 ) {
    for @numbers -> $value {
        return 1 if $sum + $value == $target;
        my @filtered = @numbers.grep: {$_ >= $value and $_ <= $target-$sum-$value},;
        next if @filtered.elems == 0;
        
        return 1 if sum_from_list( $target, @filtered, $sum + $value );
    }
    return 0;
}

sub prefilter ($target, $digit) {
    return $target >= 10 * $digit + $digit;
}

