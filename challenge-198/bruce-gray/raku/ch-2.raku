sub task2a ( UInt $n --> UInt ) { return +grep &is-prime, ^$n }
sub task2b ( UInt $n --> UInt ) {
    constant @A230980 = [\+] map +*.is-prime, ^Inf;
    return   @A230980[$n - 1];
}
sub task2c ( UInt $n --> UInt ) {
    use Math::Prime::Util:from<Perl5> <prime_count>;
    return prime_count(1, $n-1);
}


my @tests =
    ( 10, 4 ),
    ( 15, 6 ),
    (  1, 0 ),
    ( 25, 9 ),
;
my @subs = :&task2a, :&task2b, :&task2c;

use Test;
plan (+@tests + 1) * +@subs;

for @subs {
    my ( $sub_name, $sub_code ) = .kv;
    for @tests.pairs {
        my $test_num = .key + 1;
        my ($in, $expected) = .value.list;

        is $sub_code.($in), $expected, "$test_num : $sub_name";
    }
    is-deeply (map $sub_code, 1..30),
              (0,0,1,2,2,3,3,4,4,4,4,5,5,6,6,6,6,7,7,8,8,8,8,9,9,9,9,9,9,10),
              "A230980 : $sub_name"; # https://oeis.org/A230980
}
