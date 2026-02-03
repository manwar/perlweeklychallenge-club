use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str, $int) {
    # only covering strings consting of lowercase letters
    return undef unless $str =~ /^[a-z]+$/;
    my $result;
    my $max = ord('z');
    foreach my $c (split //, $str) {
        my $char_num = ord($c) + $int;
        $char_num -= 26 if $char_num > $max;
        $result .= chr($char_num);
    }
    return $result;
}

is(run('abc',1), 'bcd', 'Example 1');
is(run('xyz',2), 'zab', 'Example 2');
is(run('abc',27), 'bcd', 'Example 3');
is(run('hello',5), 'mjqqt', 'Example 4');
is(run('perl',26), 'perl', 'Example 5');
is(run('Perl',26), undef, 'Example 6');
