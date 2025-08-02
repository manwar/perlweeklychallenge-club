sub merge {
    my($a, $b, $s) = @_;
    $a =~ s/.//s ? merge($b, $a, $s.$&) : "$s$b"
}

use Test::More;
for(
    [ "abcd", "1234", "a1b2c3d4" ],
    [ "abc", "12345", "a1b2c345" ],
    [ "abcde", "123", "a1b2c3de" ],
    [ "", "xyz", "xyz" ],
    [ "123", "", "123" ],
    [ "", "", "" ],
){
    my( $str1, $str2, $want ) = @$_;
    is( merge( $str1, $str2), $want );
}
done_testing;
