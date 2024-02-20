sub merge-strings($str1, $str2) {
    my @str1-chars = $str1.comb;
    my @str2-chars = $str2.comb;
    my $merged = (@str1-chars Z @str2-chars).flat.map(*.join).join;
    my $longer-part = $str1.chars > $str2.chars ?? $str1.substr($str2.chars) !! $str2.substr($str1.chars);
    return $merged ~ $longer-part;
}

# Tests
use Test;
is merge-strings("abcd", "1234"), "a1b2c3d4", 'Test 1';
is merge-strings("abc", "12345"), "a1b2c345", 'Test 2';
is merge-strings("abcde", "123"), "a1b2c3de", 'Test 3';
done-testing();
