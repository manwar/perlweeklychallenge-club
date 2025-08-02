#!/usr/bin/env perl
# Perl weekly challenge 300
# Task 1:  Beautiful Arrangement
#
# See https://wlmb.github.io/2024/12/15/PWC300/#task-1-beautiful-arrangement
use v5.36;
use Memoize;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to count beatiful sequences made up of numbers 1..Ni
    FIN

sub beautiful($index, @remaining){
    return 1 unless @remaining; # the empty sequence is beautiful
    my $count=0;
    for(0..@remaining-1){
	next if $index%$remaining[$_] && $remaining[$_]%$index; # fail unless one divides the other
	$count += beautiful($index+1,@remaining[0..$_-1,$_+1..@remaining-1]); # count beautiful subsequences
    }
    return $count;
}

memoize 'beautiful';
for (@ARGV){
    say "$_ -> ", beautiful(1, 1..$_);
}
