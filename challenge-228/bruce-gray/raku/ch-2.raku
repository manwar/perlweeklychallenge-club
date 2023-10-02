# Efficient - uses .sort to get all the minimums at once; no re-scanning for .min .
sub task2a ( @ns --> UInt ) {
    my @a = @ns;
    my @s = @ns.sort;
    my $r = 0;
    while @a {
        while @a[0] != @s[0] {
            @a .= rotate;
            $r++;
        }
        $r++;
        shift @a;
        shift @s;
    }
    return $r;
}

# Clearer/denser, but needs inefficient repeated calls to .min.
sub task2b ( @ns ) {
    my @a = @ns;

    return sum gather while @a {
        my $head = @a.shift;
        @a.push: $head if $head > @a.min;
        take 1;
    }
}

# Concise evil; inefficent *and* overly subtle.
# Note well the addition of the @ns element count
# to the gathered sum!
sub task2c ( @ns ) {
    my @a = @ns;

    return @ns + sum gather while @a {
        @a = @a.rotate( take @a.minpairs[0].key ).skip;
    }
}

# Hybrid evil; efficient and dense,
# but uses side-effects and a
# non-intuitive .first instead of a counter.
sub task2d ( @ns ) {
    my @a = @ns;
    my @s = @ns.sort;

    return first {
        my $a_head = @a.shift;
        if $a_head > @s.head { @a.push: $a_head }
        else                 { @s.shift         }
        !@a;
    }, 1..Inf;
}


constant @tests = map { Hash.new: <in expected> Z=> .list },
    ( (3, 4, 2), 5 ),
    ( (1, 2, 3), 3 ),
;
constant @fs = :&task2a, :&task2b, :&task2c, :&task2d;
use Test;
plan @fs * @tests;
for @fs -> ( :key($f_name), :value(&f) ) {
    is f(.<in>), .<expected>, "{$f_name} : {.<in>}" for @tests;
}
