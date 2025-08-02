sub times_form_a_complete_day ( @times --> Bool ) { @times.sum %% 24 }

sub task1_combinations ( @ns --> UInt ) {
    return +grep &times_form_a_complete_day, combinations(@ns, 2);
}


sub dayness ( UInt $hours --> Str ) {

    my $n = $hours % 24;

    return $n ==  0 ?? 'FULL_DAY'
        !! $n == 12 ?? 'HALF_DAY'
        !! $n <  12 ?? 'LESS_DAY'
        !! $n >  12 ?? 'MOST_DAY'
        !!             die "Cannot happen"
        ;
}
# When you only need the counts, putting `+` in front of `combinations` makes it a lightning-fast calculation.
sub task1_classify_X ( @ns --> UInt ) {
    my ($full, $half, $less, $most) = @ns.classify(&dayness).<FULL_DAY HALF_DAY LESS_DAY MOST_DAY>;
    my $r = 0;

    $r += +$full.combinations(2);
    $r += +$half.combinations(2);

    if $less and $most {
        my @L = ($less »%» 24).Bag.sort;
        my @M = ($most »%» 24).Bag.sort.reverse;

        # I was planning to walk `while @L and @M {...}`, looking for a linear O(N) way to pair up sums-to-24 and skip over non-pairs, but I could not find it before I realized "just use a hash!", so I finished this sub with `@L X @M` instead, which will always outperform `combinations()`, then wrote `task1_classify_hash_partner` for top performance.

        for @L X @M {
            $r += [*] .list».value if .list».key.sum == 24;
        }
    }

    return $r;
}


sub task1_hash_partner ( @ns --> UInt ) {
    my BagHash $bh = ( @ns X% 24 ).BagHash;

    my $r = 0;
    $r += +combinations( $bh{ 0}:delete, 2 );
    $r += +combinations( $bh{12}:delete, 2 );
    $r += $bh.map({ .value * $bh{ 24 - .key } if .key < 12 }).sum;

    return $r;
}


constant @tests =
    ( 2, (12, 12, 30, 24, 24) ),
    ( 3, (72, 48, 24, 5) ),
    ( 0, (12, 18, 24) ),

    ( 5998000, ( |(12, 12, 30, 24, 24, 5, 6, 18) xx 1000 ) ),
;
my @subs =
    :&task1_combinations,
    :&task1_classify_X,
    :&task1_hash_partner,
;
use Test; plan +@tests * +@subs;
for @subs -> ( :key($sub_name), :value(&task1) ) {
    for @tests -> ( $expected, @in ) {
        my $sample = @in <= 9 ?? ~@in !! ~@in.head(9) ~ '...';
        my $desc = "$sub_name : $sample";

        skip("Too slow: $desc") and next if @in > 200 and $sub_name eq 'task1_combinations';

        is task1(@in), $expected, $desc;
    }
}
