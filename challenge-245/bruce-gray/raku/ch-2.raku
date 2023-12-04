# First, note that the complexity of my solutions stems from solving
# the task as described ("integers", which can have multiple digits),
# rather than the task as demonstrated (all examples are digits 0..9).
#
# "Integers" instead of "digits" make the problem *much* harder to
# solve efficiently! You cannot optimize away the permutations by
# just pre-sorting when Ints of differing lengths are in play.
# We cannot even use descending combination size as an optimization,
# since [9876, 3](elems==2) has more digits than [1,2,3,6][elems==4].
#
# Credit to Michael Manring (pokgopun), whose test cases made me see
# my assumptions of "digits" from the task examples.
#   https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-245/pokgopun/python/ch-2.py
#
# Credit to W. Luis Mochán (wlmb), whose code clued me in to the
# "residue" aspect of the solution space. Even though his code addresses only "digits",
# that number theory insight was the key that broke me out of combinatoric jail,
# allowing me to tackle input with many more elements.
#   https://wlmb.github.io/2023/11/27/PWC245/
#
# Credit to Grondilu and TimToady for the `maximum_concated` code that simplifies the whole endeavor.
#   https://rosettacode.org/wiki/Largest_int_from_concatenated_ints#Raku

# Rough comparison:
#   33245    task2a, but would be *much* higher if not for the SKIPs.
#    1179    task2b
#    1443    task2c
#     668    task2d
#      12    task2e

# The hard way: combinations+permutations, with no clever `maximum_concated` code.
sub task2a ( @ns --> Int ) {
    if @ns.sum %% 3 {
        return @ns.permutations.map(+*.join).max;
    }

    # Trimming the invalid combinations via `grep(.sum%%3)` *before*
    # the permutations (instead of after via `grep(*%%3)`) is a big win.
    my @r = @ns.combinations(1..*)
               .grep(   *.sum %% 3 )
               .map(  | *.permutations )
               .map(  + *.join )
               # .grep(* %% 3)
    ;

    return @r ?? @r.max !! -1;
}

sub maximum_concated ( @ns where { .all ~~ UInt } --> UInt ) {
    return + [~] @ns.sort: { "$^b$^a" leg "$^a$^b" };
}

# 2a + `maximum_concated`
sub task2b ( @ns --> Int ) {
    return maximum_concated(@ns) if @ns.sum %% 3;

    my @r = @ns.combinations(1..*)
               .grep( *.sum %% 3 )
               .map(&maximum_concated)
    ;
    return @r ?? @r.max !! -1;
}

# 2b, spelled differently.
sub task2c ( @ns --> Int ) {
    return maximum_concated(@ns) if @ns.sum %% 3;

    my @r = @ns.combinations(1..*).grep( *.sum %% 3 );

    return @r ?? @r.map(&maximum_concated).max !! -1;
}

# Recognizing that all the elements divisible by 3 will *always* be components of the largest combination,
# there is no need to "combinate" over them. So, we separate the %%3 from the non-%%3,
# do .combinations() on the non-%%3, filter on `.sum%%3`, and add the %%3 back into each combination.
# Note that this buys us nothing if none of the elements are %%3.
sub task2d ( @ns --> Int ) {
    return maximum_concated(@ns) if @ns.sum %% 3;

    my ( $div, $non_div ) = @ns.classify(* %% 3){True, False}.map({ $_ // [] });

    my @r = $non_div.combinations(1..*).grep( *.sum %% 3 ).map(*.Array);

    for @r -> @a {
        @a.append: |$div;
    }

    return @r ?? @r.map(&maximum_concated).max !! -1;
}

sub task2e ( @ns --> Int ) {
    return maximum_concated(@ns) if @ns.sum %% 3;

    my $total_residue = @ns.sum % 3;

    # XXX Document why!
    # XXX flawed logic???
    # XXX change to forward order and no "ab" to stress difference?
# XXX Ack! Would need to order by length of Int, since that is the dominate characteristic in devaluing a concat number

    # Digits win. Any 4-digit number is greater than every 3-digit number.
    # So, no matter what positive integer might be constructed from concatenating a set of Ints,
    # removing a N digit element will always yield a larger number than removing a N-1 digit element.
    #
    # XXX My logic on sorting this on number of digits is sound, *but* my use
    # of `"$^b$^a" leg "$^a$^b"` (just copied from `maximum_concated`)
    # may not be sound, and I just have not had time to spot it.
    # If so, worst case is a O(N²) cost, instead of the O(N!) cost of full combinatorics.
    my @ordered = @ns.sort: {     $^b.chars <=>  $^a.chars
                              or "$^b$^a"   leg "$^a$^b"    };


    # Indexes of residue group members.
    # i.e. locations in @r to each number that is `N % 3 == 0`, `N % 3 == 1`, `N % 3 == 2`
    my ($R0, $R1, $R2) = @ordered.keys.classify({ @ordered[$_] % 3 }){0,1,2}.map({ $_ // [] });

    # R1    = 1
    # R1+R1 = 2
    # R2    = 2
    # R2+R2 = 1
    # Crazy optimized.
    # If total_residue == 1, then just omit one R1's, or two R2's.
    # If total_residue == 2, then just omit one R2's, or two R1's.
    my @cand = gather {
        if $total_residue == 1 {
            if $R1.elems >= 1 {
                my   @removing_1_ones = @ordered;
                     @removing_1_ones.splice( $R1.pop, 1 );
                take @removing_1_ones;
            }
            if $R2.elems >= 2 {
                my   @removing_2_twos = @ordered;
                     @removing_2_twos.splice( $R2.pop, 1 );
                     @removing_2_twos.splice( $R2.pop, 1 );
                take @removing_2_twos;
            }
        }
        elsif $total_residue == 2 {
            if $R1.elems >= 2 {
                my   @removing_2_ones = @ordered;
                     @removing_2_ones.splice( $R1.pop, 1 );
                     @removing_2_ones.splice( $R1.pop, 1 );
                take @removing_2_ones;
            }
            if $R2.elems >= 1 {
                my   @removing_1_twos = @ordered;
                     @removing_1_twos.splice( $R2.pop, 1 );
                take @removing_1_twos;
            }
        }
    }

    @cand .= grep: *.elems; # Remove empty sub-arrays.
    @cand .= map: &maximum_concated;

    return @cand ?? @cand.max !! -1;
}


my @tests =
    # Test cases from task.
    (  981, (8, 1, 9) ),
    ( 8760, (8, 6, 7, 1, 0) ),
    (   -1, (1,) ),

    # # Extra tests from pokgopun:
    (    0, (0,  0,   0) ),
    ( 9114, (4,  8, 911) ),
    ( 8850, (8, 85,   0) ),
    ( 8982, (8, 89,   2) ),
    ( 8760, (8, 76,   0) ),
    ( 9480, (8, 94,   0) ),

    # # My invented tests:
    ( 987654321, (1, 2, 3, 4, 5, 6, 7, 8, 9) ),
    (  87654321, (1, 2, 3, 4, 5, 6, 7, 8   ) ),
    (   9765432, (1, 2, 3, 4, 5, 6, 7,    9) ),
    (   9865431, (1, 2, 3, 4, 5, 6,    8, 9) ),

    # Random numbers of residue 1 and residue 2 came from:
    # raku -e 'my @z = (1..999).grep(* % 3 == 1); say @z.pick(20);'
    # (46, 577, 184, 13, 865, 22, 643, 445, 175, 421, 355, 280, 511, 166, 625, 742, 646, 358, 571, 469)
    # raku -e 'my @z = (1..999).grep(* % 3 == 2); say @z.pick(20);'
    # (845, 626, 533, 329, 38, 416, 515, 212, 581, 287, 383, 803, 275, 80, 164, 341, 914, 764, 29, 800)

    # All residue 1.
    (    8656435775114644542135528022184175 , ( 46, 577, 184,  13, 865,  22, 643, 445, 175, 421, 355, 280,   511      ) ),
    (    86564357751146445421355280184175166, ( 46, 577, 184,  13, 865,  22, 643, 445, 175, 421, 355, 280,   511, 166 ) ),
    # All residue 2.
    (   845803626581533515416383329287275212, (845, 626, 533, 329,  38, 416, 515, 212, 581, 287, 383, 803,   275      ) ),
    (   845803626581533515416383329287275212, (845, 626, 533, 329,  38, 416, 515, 212, 581, 287, 383, 803,   275, 164 ) ),

    # 3,6,9, all residue 1.
    (   96577463184 , (3,6,9, 46, 577, 184, 13,      ) ),
    (   986565773184, (3,6,9, 46, 577, 184, 13, 865, ) ),
    # 3,6,9, all residue 2.
    ( 98456626533416383329, (3,6,9, 845, 626, 533, 329, 38, 416 ) ),
    (         984566265333, (3,6,9, 845, 626, 533, 329, 38      ) ),
    (         984566265333, (3,6,9, 845, 626, 533, 329,         ) ),

    # 3,6,9, mix residue 1&2.
    # 7R2 + (5...1)R1
    ( 9845662653344542141638383553329280, (3,6,9, 845, 626, 533, 329, 38, 416, 38,   445, 175, 421, 355, 280 ) ), # 7x2 + 5x1
    ( 9845662653344542141638383553329175, (3,6,9, 845, 626, 533, 329, 38, 416, 38,   445, 175, 421, 355      ) ), # 7x2 + 4x1
    (      98456626533445421416383329175, (3,6,9, 845, 626, 533, 329, 38, 416, 38,   445, 175, 421,          ) ), # 7x2 + 3x1
    (          9845662653344541638383329, (3,6,9, 845, 626, 533, 329, 38, 416, 38,   445, 175                ) ), # 7x2 + 2x1
    (          9845662653344541638383329, (3,6,9, 845, 626, 533, 329, 38, 416, 38,   445                     ) ), # 7x2 + 1x1

    # (7...1)R2 + 5R1
    ( 9845662653344542141638383553329280, (3,6,9, 845, 626, 533, 329, 38, 416, 38,   445, 175, 421, 355, 280 ) ), # 7x2 + 5x1
    (  984566265334454214163553329280175, (3,6,9, 845, 626, 533, 329, 38, 416,       445, 175, 421, 355, 280 ) ), # 6x2 + 5x1
    (   98456626533445421383553329280175, (3,6,9, 845, 626, 533, 329, 38,            445, 175, 421, 355, 280 ) ), # 5x2 + 5x1
    (        984566265334454213553329280, (3,6,9, 845, 626, 533, 329,                445, 175, 421, 355, 280 ) ), # 4x2 + 5x1
    (           984566264454213553280175, (3,6,9, 845, 626, 533,                     445, 175, 421, 355, 280 ) ), # 3x2 + 5x1
    (           984566264454213553280175, (3,6,9, 845, 626,                          445, 175, 421, 355, 280 ) ), # 2x2 + 5x1
    (                 984564454213553280, (3,6,9, 845,                               445, 175, 421, 355, 280 ) ), # 1x2 + 5x1
    # (7...1)R2 + 4R1
    ( 9845662653344542141638383553329175, (3,6,9, 845, 626, 533, 329, 38, 416, 38,   445, 175, 421, 355      ) ), # 7x2 + 4x1
    (      98456626533445421416383553329, (3,6,9, 845, 626, 533, 329, 38, 416,       445, 175, 421, 355      ) ), # 6x2 + 4x1
    (        984566265334454213553329175, (3,6,9, 845, 626, 533, 329, 38,            445, 175, 421, 355      ) ), # 5x2 + 4x1
    (        984566265334454213553329175, (3,6,9, 845, 626, 533, 329,                445, 175, 421, 355      ) ), # 4x2 + 4x1
    (              984566265334454213553, (3,6,9, 845, 626, 533,                     445, 175, 421, 355      ) ), # 3x2 + 4x1
    (                 984564454213553175, (3,6,9, 845, 626,                          445, 175, 421, 355      ) ), # 2x2 + 4x1
    (                 984564454213553175, (3,6,9, 845,                               445, 175, 421, 355      ) ), # 1x2 + 4x1
;
my @subs =
    :&task2b,
    :&task2c,
    :&task2d,
    :&task2e,
    :&task2a,
;

# BEGIN %*ENV<RAKU_TEST_TIMES> = 1; # Uncomment to get crude per-test timings.

use Test; plan +@tests * @subs;

my @timings; # XXX *Not* a proper benchmark!
for @subs -> ( :key($sub_name), :value(&task2) ) {
    my $t = now;
    for @tests.kv -> $k, ( $expected, @in ) {
        my $test_num = $k+1;
        my $desc = "$sub_name $test_num";
        if $sub_name eq 'task2a' and @in > 10 {
            skip "$desc - too many for combinatorics";
            next;
        }
        is task2(@in), $expected, $desc;
    }
    my $cost = ( now - $t ) * 1000;
    push @timings, ( $cost, $sub_name );
}
note 'Rough totals:';
note .[0].fmt("%7d\t"), .[1] for @timings;
