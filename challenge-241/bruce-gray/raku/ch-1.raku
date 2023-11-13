# Six solutions.
# Timings, in seconds, best to worst:
#   Rnd50   A1000
#   -----   -----
#   0.008   1.210 intersection
#   0.009   1.699 set_scan
#   0.017   3.695 all_diffs
#   0.027   5.721 single_pass
#   0.229 985.264 comb2
#   3.942     N/A comb3 (estimated 11.4 days to complete 1..1000 x 0..500)

sub task1_comb3 ( UInt $diff, @ns --> UInt ) {
    die unless [<] @ns;

    return +grep {     ([-] .[1,0])==$diff
                   and ([-] .[2,1])==$diff }, combinations(@ns, 3);
}

sub task1_comb2 ( UInt $diff, @ns --> UInt ) {
    die unless [<] @ns;

    my @cand = @ns.combinations(2).grep({ $diff == [-] .[1,0] });

    my Set $starts = @cand».[0].Set;

    return $starts{ @cand».[1] }.grep(*.so).elems;
}

sub task1_set_scan ( UInt $diff, @ns --> UInt ) {
    return 0 if $diff == 0;
    die if @ns.repeated;

    my Set $s = @ns.Set;
    my $d2 = $diff * 2;
    return +grep { $s{ $_ + $diff, $_ + $d2 }.all }, @ns;
}

sub task1_single_pass ( UInt $diff, @ns --> UInt ) {
    die unless [<] @ns;

    my $r = 0;
    my SetHash $seen;
    my @dd = $diff, $diff + $diff;

    for @ns {
        $r++ if $seen{ $_ X- @dd }.all;
        $seen{$_} = True;
    }

    return $r;
}

sub task1_set_intersection ( UInt $diff, @ns --> UInt ) {
    return 0 if $diff == 0;
    die if @ns.repeated;

    return elems [∩]  @ns,
                    ( @ns X+ $diff           ),
                    ( @ns X+ ($diff + $diff) );
}

sub find_all_diffs ( @ns --> Hash ) {
    my @cand = @ns.combinations(2).classify({ ([-] .[1,0]).abs }).grep(*.value.elems >= 2);
    
    my %r;
    for @cand {
        my Set $starts = .value».[0].Set;
        my $count = $starts{ .value».[1] }.grep(*.so).elems;
        %r{.key} = $count if $count;
    }

    return %r;
}
sub task1_from_all_diffs ( UInt $diff, @ns --> UInt ) {
    state %cache;
    my %h = ( %cache{@ns.Str} //= find_all_diffs(@ns) );
    return %h{$diff} // 0;
}

constant @tests =
    ( 2, 3, (0, 1, 4, 6, 7, 10) ),
    ( 2, 2, (4, 5, 6, 7, 8,  9) ),
;
constant @subs =
    :&task1_from_all_diffs,
    :&task1_set_intersection,
    :&task1_single_pass,
    :&task1_set_scan,
    :&task1_comb2,
    :&task1_comb3,
;
use Test; plan +@tests * +@subs  + +@subs + (+@subs - 1);
for @subs -> ( :key($sub_name), :value(&task1) ) {
    for @tests -> ( $expected, $diff, @ns ) {
        is task1($diff, @ns), $expected, "$sub_name $diff";
    }
}

# Tests of larger arrays (50, 1000), across ranges of diffs (46, 501).

# From `raku -e 'say (10..99).pick(50).sort.join: ","'`
constant @random_50 = 10,11,12,14,15,17,18,20,21,25,26,27,28,29,31,33,35,37,39,41,42,46,48,49,50,51,52,54,56,59,60,61,62,63,65,67,71,73,79,82,85,86,87,88,89,92,93,94,97,98;
constant @all_1000  = 1..1000;
my @random_50_expected = 0,14,16,12,16,10,15,8,10,7,10,12,9,10,9,13,4,12,5,12,5,12,6,8,8,9,6,3,5,3,5,5,4,4,7,4,6,4,5,4,2,3,2,1,1,0;
my @all_1000_expected = 0, |(998, *-2 ... 0);
for @subs -> ( :key($sub_name), :value(&task1) ) {
    my Instant $n = now;
    my @got = map { task1($_, @random_50) }, 0..45;
    is-deeply @got, @random_50_expected, "$sub_name random_50";
    say now - $n;
}
for @subs -> ( :key($sub_name), :value(&task1) ) {
    my Instant $n = now;
    next if $sub_name eq 'task1_comb3'; # Don't. Just don't.
    my @got = map { task1($_, @all_1000) }, 0..500;
    is-deeply @got, @all_1000_expected, "$sub_name all_1000";
    say now - $n;
}
