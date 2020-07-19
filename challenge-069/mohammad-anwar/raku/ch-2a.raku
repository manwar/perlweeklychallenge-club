#!/usr/bin/env raku

#
# Perl Weekly Challenge - 069
#
# Task #2: 0/1 String
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-069
#

use Test;

is string_0_1('S2'), '001',             'testing S2';
is string_0_1('S3'), '0010011',         'testing S3';
is string_0_1('S4'), '001001100011011', 'testing S4';

done-testing;

sub string_0_1($string) {

    my $limit = .Int for $string ~~ m/(\d+)/;
    die "ERROR: Invalid string [$string]. S30 is the limit.\n"
        if $limit > 30;

    my $string_0_1 = '';
    for 1 .. $limit {
        my $_string_0_1 =  $string_0_1.flip;
        $_string_0_1    ~~ tr/[01]/[10]/;
        $_string_0_1    =  '0' ~ $_string_0_1;
        $string_0_1     =  $string_0_1 ~ $_string_0_1;
    }

    return $string_0_1;
}
