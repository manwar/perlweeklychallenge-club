use strict;
use warnings;

sub merge_strings {
    my ($str1, $str2) = @_;
    my $length = length($str1) < length($str2) ? length($str1) : length($str2);
    my $merged = '';
    for my $i (0 .. $length - 1) {
        $merged .= substr($str1, $i, 1) . substr($str2, $i, 1);
    }
    $merged .= length($str1) > $length ? substr($str1, $length) : substr($str2, $length);
    return $merged;
}

# Tests
use Test::More;
is(merge_strings("abcd", "1234"), "a1b2c3d4");
is(merge_strings("abc", "12345"), "a1b2c345");
is(merge_strings("abcde", "123"), "a1b2c3de");
done_testing();
