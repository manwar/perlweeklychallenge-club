sub max_pairs {
    my %maybe;
    my $pairs = 0;
    for( @_ ) {
        my $r = reverse;
        if( $maybe{ $r } > 0 ) {
            $maybe{ $r }--;
            $pairs++;
        }
        else {
            $maybe{ $_ }++;
        }
    }
    $pairs
}

use Test::More;
for (
    ["ab", "de", "ed", "bc"                         => 1],
    ["aa", "ba", "cd", "ed"                         => 0],
    ["uv",       "qp", "st", "vu", "mn", "pq"       => 2],
    ["uv", "uv", "qp", "st", "vu", "mn", "pq"       => 2],
    ["uv", "uv", "qp", "st", "vu", "mn", "pq", "vu" => 3]
){
    my $want = pop @$_;
    is( max_pairs(@$_), $want );
}
done_testing;
