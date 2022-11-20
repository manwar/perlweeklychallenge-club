#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.d;
use Test;

=begin comment

191-2: Cute List            Submitted by: Mohammad S Anwar
Given an integer, 0 < $n <= 15, find the number of orderings of numbers
that form a cute list.

With an input @list = (1, 2, 3, .. $n) for positive integer $n, an ordering of @list is cute if for every entry, indexed with a base of 1, either

1) $list[$i] is evenly divisible by $i
or
2) $i is evenly divisible by $list[$i]
Example
Input: $n = 2
Ouput: 2

Since $n = 2, the list can be made up of two integers only i.e. 1 and 2.
Therefore we can have two list i.e. (1,2) and (2,1).

@list = (1,2) is cute since $list[1] = 1 is divisible by 1
    and $list[2] = 2 is divisible by 2.

=end comment

# naive implementation -- I don't have much math
sub swap( @a, $l, $r --> Nil ) {
     (@a[$l], @a[$r]) = @a[$r], @a[$l];
        return;
}

multi is-cute(  @a  --> Bool) {

    for (0 ..^@a) -> $i {       # check hi-prime first
        return False unless ( @a[$i] %% ($i+1) or ($i+1) %% @a[$i] );
    }
    return True;
}

=begin comment
multi make-cute( @a ) {
    my $in = @a.elems;
    my $middle = $in div 2;         # end of swappables
    my $ret = 1;                    # count of valid permutations

    my @factor = 2 .. $middle;      #  1 is special case
    my @swap =  X=> @factor,  @factor;

# purge conflicting swaps

 for 1..^@swap -> $window-size {
   for 2 .. (@swap.elems - $window-size )
 }

    # get index zero swap count
    #my $izsc = +@half-rtn + +@half-rtn × ($in -1);
    #say "\$izsc: ", $izsc;

    return ;
}

=end comment

multi gen-cute( $n --> Int) {
    return $n if $n ≤ 3;

    # state $prev = 3;        # if called as a sequence maker, could expand
                            # previous permutations.

    my $rtn = 0;
    my @pmute =  ( 1 .. $n ).permutations;
    for @pmute -> @a {
        ++$rtn if is-cute @a ;
    }
    return $rtn;
}

say gen-cute( 8);


=finish

multi MAIN ( $t where * = < T t>.any ) {
    my @Test =
         0 =>   Any,   1 =>   1,   2 =>   2,    3 =>    3,   4 =>    8,
         5 =>    10,   6 =>  36,   7 =>   41,   8 =>  132,   9 =>  250,
        10 =>   700,  11 => 750,
        # 12 => 4010,  13 => 4237,  14 => 10680, 15 => 24679
    ;
    my @T-is-cute-true =
        (1,2,3,4), (1,4,3,2), (2,1,3,4), (2,4,3,1),
        (3,2,1,4), (3,4,1,2), (4,1,3,2), (4,2,3,1),
        (1,8,3,4,10,6,7,2,9,5,11,12),
    ;
    my @T-is-cute-false =
        (1,2,4,3), (1,3,2,4), (1,3,4,2), (1,4,2,3),
        (2,1,4,3), (2,3,1,4), (2,3,4,1), (2,4,1,3),
        (3,1,2,4), (3,1,4,2), (3,2,4,1), (3,4,2,1),
        (4,1,2,3), (4,2,1,3), (4,3,1,2), (4,3,2,1),
        (1,3,2,4,5,6,7,8,9,11,10,12),
        (1,3,2,4,5,6,7,8,9,10,11,12),
    ;
    plan @Test.elems + @T-is-cute-true + @T-is-cute-false;

    for @T-is-cute-true -> @t {
        ok is-cute( @t), " is cute @t[]";
    }
    for @T-is-cute-false -> @t {
        nok is-cute( @t), "not cute @t[]";
    }

    for @Test -> $p {
        is @cute-count[ $p.key], $p.value, "$p.key() --> "~ $p.value.raku;
    }
    done-testing;
}

