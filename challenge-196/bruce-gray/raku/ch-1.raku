# CAUTION: Written with Vacation Brain.

# Simplest, and always correct,
# but slow since it does not allow for short-circuiting.
sub task1 ( @a ) {
    return @a.combinations(3).first({ [<] .[0,2,1] }) // [];
}

# O(N³) worst case, but short-circuiting speeds up the common cases.
sub task1_ak_then_j ( @a ) {
    for @a.kv -> $i, $ai {
        for $i+2 .. @a.end -> $k {
            my $ak = @a[$k];
            next unless $ai < $ak;
            for @a[$i ^..^ $k] -> $aj {
                return $ai, $aj, $ak if $ai < $ak < $aj;
            }
        }
    }
    return [];
}

# Trades two extra linear passes,
# for (I think) a O(N²/4) worst case
# and a much better average case.
# Idea comes from the Water Collected problem.
sub task1_faster ( @a ) {
    my @R  =         [\min]         @a;
    my @L  = reverse [\min] reverse @a;
    my @LR = @L Zmax @R;

    my @js = (@a Z> @LR).grep: :k, *.so;
    return [] if not @js;

    for @js -> $j {
        my $aj = @a[$j];                     
        for     @a[  0  ..^ $j     ] -> $ai {
            for @a[ $j ^..  @a.end ] -> $ak {
                return $ai, $aj, $ak if $ai < $ak < $aj;
            }
        }
    }
    die "Can't happen";
}

# Translation of https://ayoubomari.medium.com/132-pattern-1b890c763bd5 ,
# , which is well worth reading for the walkthrough!
# It works perfectly to quickly (linear time!) find no-answer or some-132,
# but it does not give us the *first* 132 as the task requires.
sub find132pattern ( @ns ) {
    my @stack;
    for @ns -> $n {
        my $min_i = $n;
        if @stack and $n >= @stack.tail.min {
            $min_i = @stack.tail.min;
            pop @stack while @stack and $n > @stack.tail.max;
            return |@stack.tail.bounds, $n if @stack and $n ~~ @stack.tail;
        }
        push @stack, $min_i ^..^ $n;
    }
    return [];
}


my @subs =
    :&task1,
    :&task1_ak_then_j,
    :&task1_faster,
    :&find132pattern,
;
my @tests =
    ( (3, 1, 4, 2)       , (1,4,2) ),
    ( (1, 2, 3, 4)       , [] ),
    ( (1, 3, 2, 4, 6, 5) , (1,3,2) ),
    ( (1, 3, 4, 2)       , (1,3,2), (1,4,2) ),

    ( (3, 5, 0, 2, 8, 7)    , (3,8,7), (0,8,7) ),
    ( (3, 5, 0, 2, 8, 4)    , (3,5,4), (0,8,4) ),
    
    ( (2,9,|(1 xx 100),      |(1 xx 100),3), (2, 9, 3) ),
    ( (    |(1 xx 100),  2,9,|(1 xx 100),3), (1, 9, 3) ),
    ( (    |(9 xx 100),1,2,9,|(1 xx 100),3), (1, 9, 3) ),
;
use Test;
for @tests.kv -> $test_num, ($in, $expected, $expected_alt?) {
    for @subs -> $s {
        my ($sub_name, $sub_code) = $s.kv;

        my $exp = ($sub_name eq 'find132pattern' and $expected_alt.defined) ?? $expected_alt !! $expected;

        is $sub_code.($in), $exp, "{$test_num + 1} $sub_name";
    }
}
