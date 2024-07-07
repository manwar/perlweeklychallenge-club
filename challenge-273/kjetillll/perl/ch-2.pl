use strict; use warnings; use Test::More tests=>4;

sub b_after_a {
    local $_ = shift;
    s/^.*?b// and /b/ and !/a/
}

my @tests = <<'' =~ /"(.*?)".*?(true|false)/g;
    Input: $str = "aabb"  Output: true
    Input: $str = "abab"  Output: false
    Input: $str = "aaa"   Output: false
    Input: $str = "bbb"   Output: true

while( @tests ){
    my( $str, $output ) = splice @tests, 0, 2;
    my $got = b_after_a( $str ) ? 'true' : 'false';
    is $got, $output, "want: $output   got: $got";
}
