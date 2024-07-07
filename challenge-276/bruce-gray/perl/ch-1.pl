use v5.40;
use ntheory qw<forcomb vecsum>;

sub task1_comb ( $ns_aref ) {
    my @ns = $ns_aref->@*;

    my $r = 0;

    forcomb {
        $r++ if vecsum(@ns[@_]) % 24 == 0;
    } @ns, 2;

    return $r;
}


sub Triangle ($n) { $n * ($n-1) / 2 }

sub task1_hash ( $ns_aref ) {
    my %bh; # BagHash from Raku
    $bh{ $_ % 24 }++ for $ns_aref->@*;

    my $r = 0;
    $r += Triangle( delete $bh{ 0} // 0 );
    $r += Triangle( delete $bh{12} // 0 );

    $r += $bh{$_} * ($bh{24 - $_} // 0) for grep { $_ < 12 } keys %bh;

    return $r;
}


my @tests = (
    2, [12, 12, 30, 24, 24],
    3, [72, 48, 24, 5],
    0, [12, 18, 24],

    5998000, [ (12, 12, 30, 24, 24, 5, 6, 18) x 1000 ],
);
use Test2::V0 -no_srand => 1; plan @tests / 2 * 2;
for my ( $expected, $in_array ) (@tests) {
    is task1_comb($in_array), $expected, "task1_comb : @{$in_array}[0..2]";
    is task1_hash($in_array), $expected, "task1_hash : @{$in_array}[0..2]";
}
