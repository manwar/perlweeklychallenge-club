# The Weekly Challenge 256
# Task 2 Merge Strings
use v5.30.0;
use warnings;
use List::MoreUtils qw/zip/;
sub ms {
    my $str1 = $_[0];
    my $str2 = $_[1];
    my @arr1 = split "", $str1;
    my @arr2 = split "", $str2;
    my @arr = grep { defined($_) } zip @arr1, @arr2;
    my $str = join "", @arr;
    return $str;
}

use Test::More tests=>3;
ok ms("abcd", "1234") eq "a1b2c3d4";
ok ms("abc", "12345") eq "a1b2c345";
ok ms("abcde", "123") eq "a1b2c3de";
