sub task1_paired ( Str $s --> Str ) {
    my @great = $s.comb.classify(*.uc).grep(*.value.unique > 1)».key;

    return @great ?? @great.max !! '';
}
sub task1_bitmap ( Str $s --> Str ) {
    my %h;
    %h{ .uc } +|= (.uc eq $_ ?? 2 !! 1) for $s.comb;

    my @great = %h.grep(*.value == 3)».key;

    return @great ?? @great.max !! '';
}
sub task1_combed_regex_sets ( Str $s --> Str ) {
    # .comb with regex instead of m:g// keeps us from needing to convert the matches to .Str.
    my $uppers  = $s.comb(/<.upper>/).Set;
    my $downers = $s.comb(/<.lower>/)».uc.Set;

    return ('A'..'Z').first(:end, { $_ ∈ $uppers and $_ ∈ $downers }) // '';
}
sub task1_comb_hash ( Str $s --> Str ) {
    my %c = $s.comb.Set;

    return '' R// first { %c{.uc} and %c{.lc} }, ( 'Z' ... 'A' );
}


my @tests =
    ( 'L', 'PeRlwEeKLy' ),
    ( 'L', 'ChaLlenge' ),
    ( '',  'The' ),
;
my @subs =
    :&task1_paired,
    :&task1_bitmap,
    :&task1_combed_regex_sets,
    :&task1_comb_hash,
;
use Test; plan +@tests * +@subs;
for @subs -> ( :key($sub_name), :value(&task1) ) {
    for @tests -> ( $expected, $in ) {
        is task1($in), $expected, "$sub_name $in";
    }
}
