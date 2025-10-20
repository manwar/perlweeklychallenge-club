#!/usr/bin/env perl
# Perl weekly challenge 344
# Task 2:  Array Formation
#
# See https://wlmb.github.io/2025/10/20/PWC344/#task-2-array-formation
use v5.36;
use feature qw(try);
use PDL;
use PDL::NiceSlice;
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 S0 T0 S1 T1...
    to match the source arrays Si to the target array Ti.
    The sources are comma separated strings of the form "s0, s1..." where
    each string contains an array of space separated numbers within square brackets
    of the form "[n0 n1...]"
    FIN
my $result;
for my($sources, $target)(@ARGV){
    try {
	my @sources = map {pdl($_)} split /\s*,\s*/, $sources;
	my $ptarget = pdl($target);
	do{die "Expected 1D arrays of numbers: $_" unless $_->ndims==1;} for @sources, $ptarget;
	$result=0, next unless pdl(map{$_->nelem} @sources)->sum == $ptarget->nelem;
	my @tested=();
	while(@sources){
	    $result = test([@tested],[@sources],$ptarget) and last;
	    push @tested, shift @sources;
	}
    }
    catch($e){ warn $e; }
}
continue{
    say "$sources, $target -> ", $result?"True":"False";
}
sub test($tested, $untested, $target){
    my @tested=@$tested;
    my @untested=@$untested;
    return 1 unless @untested;
    while(@untested){
        my $current=shift @untested;
	my $result=all($current==$target(0:$current->nelem-1));  # assume target is large enough
	$result=test([], [@tested, @untested], $target($current->nelem:-1)) if $result;
        return 1 if $result;
        push @tested, $current;
    }
    return 0;
}
