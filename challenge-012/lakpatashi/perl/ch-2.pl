#!/usr/bin/perl
use POSIX;
use strict;
use warnings;
use List::Util qw( min max sum);

my @arr = qw(/a/b/c/d /a/b/cd /a/b/cc /a/b/c/d/e);

my $n = -1;
my @prevPath;
for my $x (@arr){
	my @path = split '/',$x;
	if ($n == -1){
		$n = $#path;
	}else{
		$n = min($n, $#path);
		for my $i(reverse 1..$n){
			if($prevPath[$i] eq $path[$i]){
				$n = $i;
				last;
			}
			$n = 0 if $i == 1;
		}
		print "no common" unless $n;
	}
	@prevPath = @path;
}
print "base dir:: ",
join '/', @prevPath[0..$n],"\n" if $n>0;
