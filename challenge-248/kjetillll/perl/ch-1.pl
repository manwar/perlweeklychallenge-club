#!/usr/bin/perl
#https://theweeklychallenge.org/blog/perl-weekly-challenge-248/
use strict; use warnings;
use Test::More tests=>2;
is_deeply [ SD("loveleetcode", "e") ] => [ 3,2,1,0,1,0,0,1,2,2,1,0 ];
is_deeply [ SD("aaab",         "b") ] => [ 3,2,1,0 ];

sub SD {
    my($str,$char)=@_;
    my @s = split//, $str;
    my $dist   = sub { my $d = 9e9; map $_ eq $char ? ($d=0) : ++$d, @_ };
    my @after  =         &$dist(         @s );
    my @before = reverse &$dist( reverse @s );
    map $after[$_] < $before[$_] ? $after[$_] : $before[$_], 0 .. $#s;
}
