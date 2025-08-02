# The Weekly Challenge 275
# Task 2 Replace Digits
use v5.30.0;
use warnings;

sub rd {
    my $str = $_[0];
    my @arr = split "", $str;
    my $pre_c = $arr[0];
    for my $i (1..$#arr) {
        if ($arr[$i] =~ /[a-z]/) {
            $pre_c = $arr[$i];
            next;
        }
        if ($arr[$i] =~ /\d/) {
            my $num = $arr[$i];
            my $the_a = ($pre_c eq lc $pre_c) ? 'a' : 'A';
            $arr[$i] = 
                chr(ord($the_a) + (ord($pre_c)-ord($the_a)+$num) % 26);
        }
    }
    say(join "", @arr);
    return join "", @arr;
}

use Test::More tests=>7;
ok rd('a1c1e1') eq 'abcdef';
ok rd('a1b2c3d4') eq 'abbdcfdh';
ok rd('b2b') eq 'bdb';
ok rd('a16z') eq 'abgz';
ok rd('a0') eq 'aa';
ok rd('Z1') eq 'ZA';
ok rd('abc') eq 'abc';
