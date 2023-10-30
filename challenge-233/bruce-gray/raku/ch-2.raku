sub task2 ( @ns ) {
    return @ns.Bag.sort({ .value, -.key }).map({ .key xx .value }).flat;

    # My first version:
    # my $b = @ns.Bag;
    # return @ns.sort({ $b{$_}, -$_ });
}


my @tests = map { Hash.new: <in expected> Z=> .list },
    ( (1,1,2,2,2,3), (3,1,1,2,2,2) ),
    ( (2,3,1,3,2), (1,3,3,2,2) ),
    ( (-1,1,-6,4,5,-6,1,4,1), (5,-1,4,4,-6,-6,1,1,1) ),
;
use Test; plan +@tests;
is-deeply task2(.<in>), .<expected> for @tests;
