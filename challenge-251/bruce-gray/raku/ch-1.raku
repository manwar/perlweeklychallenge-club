sub task1a ( @ns --> Numeric ) {
    my $half = +@ns div 2;
    my $odd  = +@ns !%% 2;

    my @left   = @ns.head($half);
    my $middle = @ns.skip($half)[0] if $odd;
    my @right  = @ns.skip($half + (1 if $odd));

    return (@left »~« @right.reverse).sum + ($middle // 0);
}
sub task1b ( @ns --> Numeric ) {
    my @r = @ns;
    my @l = @r.splice(0, * div 2);
    my $m = @r.splice(0,   1)[0] if @ns % 2;

    die "Cannot happen" if +@l != +@r;

    return (@l »~« @r.reverse).sum
         + ($m // 0);
}
sub task1c ( @ns --> Numeric ) {
    return (@ns.head(@ns/2) »~« @ns.tail(@ns/2).reverse).sum
         + (@ns.skip(@ns/2)[0] if @ns % 2);
}
sub task1d ( @ns_in --> Numeric ) {
    my @ns = @ns_in;

    my $ret = 0;
    $ret += @ns.shift ~ @ns.pop while @ns > 1;
    $ret += @ns.shift              if @ns;

    return $ret;
}
sub task1e ( @ns --> Numeric ) {
    my ($i, $j) = 0, @ns.end;

    my $ret = 0;
    $ret += @ns[$i++, $j--].join while $i <  $j;
    $ret += @ns[$i]                 if $i == $j;

    return $ret;
}

my @subs =
    :&task1a,
    :&task1b,
    :&task1c,
    :&task1d,
    :&task1e,
;
my @tests =
    ( 1286, (  6, 12, 25, 1 ) ),
    (  489, ( 10,  7, 31, 5, 2, 2 ) ),
    (  112, (  1,  2, 10 ) ),
    (    0, [] ),
;
use Test; plan +@tests * @subs;
for @subs -> ( :key($sub_name), :value(&task1) ) {
    for @tests -> ( $expected, @in ) {
        is task1(@in), $expected, "$sub_name : $expected";
    }
}
