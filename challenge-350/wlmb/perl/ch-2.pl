#!/usr/bin/env perl
# Perl weekly challenge 350
# Task 2:  Shuffle Pairs
#
# See https://wlmb.github.io/2025/12/01/PWC350/#task-2-shuffle-pairs
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV and @ARGV%3==0;
    Usage: $0 f0 t0 c0 f1 t1 c1...
    to find how many integers from fn up to tn have cn or more
    shuffle pairs, i.e., integer multiples with the same digits.
    FIN
my $result;
for my($low, $high, $count)(@ARGV){
    try {
	do {die "Only digits allowed: $_" unless /^\d+$/} for $low, $high, $count;
	$result=0;
	my $current=$low;
	$current += 3 - $current%3 if $current%3; # skip upto multiple of 3
	next if $count > 9;
	while($current <= $high){
	    my $multiple_of_9 = $current%9==0;
	    next if !$multiple_of_9 && $count > 2; # at most two witnesses
	    my $pairs=0;
	    my $original=digits($current);
	    for($current%9==0?(2..9):(4,7)){
		my $multiplied=digits($current*$_);
		++$pairs if $original==$multiplied;
	    }
	    ++$result if $pairs >= $count;
	}
	continue {
	    $current+=3; # next multiple of 3
	    }
    }
    catch($e){ warn $e; }
}
continue{
    	say "$low, $high, $count -> $result";
}

sub digits($x){
    join "", sort {$b<=>$a} split "", $x;
}
