#!/usr/bin/env perl

# Perl Weekly Challenge 192 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-192/

use Modern::Perl;

sub flip {
    my($n)=@_;
    my $len=length(sprintf("%b",$n));
    my $mask=2**$len-1;
    return (~$n)&$mask;
}

@ARGV==1 or die "usage: ch-2.pl n\n";
my $n=shift||0;
say flip($n);
