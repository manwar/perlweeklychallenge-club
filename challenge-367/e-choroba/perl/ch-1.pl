#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub max_odd_binary($str) {
    die 'No ones' if -1 == index $str, 1;

    my %digit;
    ++$digit{$_} for split //, $str;
    return '1' x ($digit{1} - 1) . '0' x ($digit{0} // 0) . '1'
}

use Test::More tests => 5 + 3;

is max_odd_binary('1011'), '1101', 'Example 1';
is max_odd_binary('100'), '001', 'Example 2';
is max_odd_binary('111000'), '110001', 'Example 3';
is max_odd_binary('0101'), '1001', 'Example 4';
is max_odd_binary('1111'), '1111', 'Example 5';

is max_odd_binary('1'), '1', 'One';

my $z = eval { max_odd_binary('0') };
my $err = $@;
is $z, undef, 'No result';
like $err, qr/No ones/, 'Exception';
