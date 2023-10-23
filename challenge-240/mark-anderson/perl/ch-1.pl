#!/usr/bin/env perl
use List::Util   qw/all zip/;
use experimental qw/signatures/;
use Test2::V0;
plan 3;

ok     acronym([qw/Perl Python Pascal/], 'ppp');
ok not acronym([qw/Perl Raku/],           'rp');
ok     acronym([qw/Oracle Awk C/],       'oac');

sub acronym($arr, $ck)  
{
    all { uc $_->[1] eq substr $_->[0], 0, 1 } zip $arr, [split //, $ck] 
}
