#!/usr/bin/env perl6
#
#
#       one-two-up-we-go.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN () ;

sub fib ( $n ){ 
    state @fib;
    return @fib[$n] when @fib[$n].defined;
    return @fib[$n] = $n if $n < 2;
    @fib[$n] = fib($n-1) + fib($n-2);
}

for 1..20 {
    my ($s, $v, $p) = ('s', 'are', 'them');
    $_ == 1 and ($s, $v, $p) = (' ', 'is ', 'it');
    printf "for %2d step%s there %s %5d way%s to climb %s\n", 
        $_, $s, $v, fib($_+1), $s, $p;

}


# for  1 step  there is      1 way  to climb it
# for  2 steps there are     2 ways to climb them
# for  3 steps there are     3 ways to climb them
# for  4 steps there are     5 ways to climb them
# for  5 steps there are     8 ways to climb them
# for  6 steps there are    13 ways to climb them
# for  7 steps there are    21 ways to climb them
# for  8 steps there are    34 ways to climb them
# for  9 steps there are    55 ways to climb them
# for 10 steps there are    89 ways to climb them
# for 11 steps there are   144 ways to climb them
# for 12 steps there are   233 ways to climb them
# for 13 steps there are   377 ways to climb them
# for 14 steps there are   610 ways to climb them
# for 15 steps there are   987 ways to climb them
# for 16 steps there are  1597 ways to climb them
# for 17 steps there are  2584 ways to climb them
# for 18 steps there are  4181 ways to climb them
# for 19 steps there are  6765 ways to climb them
# for 20 steps there are 10946 ways to climb them
