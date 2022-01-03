#!/usr/bin/env perl
# Perl weekly challenge 146
# Task 2: Curious Fraction Tree
#
# See https://wlmb.github.io/2022/01/03/PWC146/#task-2-curious-fraction-tree
use v5.12;
use warnings;
use Try::Tiny;
foreach(@ARGV){
    try {
	my($n, $d)=($1,$2) if m{^\s*(\d+)\s*/\s*(\d+)\s*$};
	die "Wrong argument $_\n" unless defined $n and defined $d;
	die "Numerator and denominator in $_  should be positive\n"
	    unless $n>0 and $d>0;
	my $gcd=gcd($n, $d);
	say "Warning: $_ not reduced" unless $gcd==1;
	($n, $d)=map {$_/$gcd} ($n, $d);
	try {
	    my @parent=parent($n, $d);
	    try {
		my @grand_parent=parent(@parent);
		say "Input: $n/$d\nParent:$parent[0]/$parent[1]\n",
		    "Grand parent: $grand_parent[0]/$grand_parent[1]\n";
	    }
	    catch {
		die "No grandparent of $n/$d\n";
	    }

	}
	catch {
	    die $_;
	}
    }
    catch {
	say $_;
    }
}

sub gcd {
    my ($n, $m)=@_;
    ($n, $m)=($m, $n%$m) while ($m);
    return $n;
}
sub parent {
    my ($n, $d)=@_;
    die "No parent of $n/$d\n" if $n==$d;
    return $d>$n?($n,$d-$n):($n-$d,$d);
}
