#!/usr/bin/perl
use warnings; use strict; use List::Util 'reduce';

my @time = @ARGV;                                          #input from command line args
@time = ("10:10", "09:30", "09:00", "09:55") if not @time; #...or use test case

print "Input: @time\n";
print "Interval in minutes: ", shortest_time(@time), "\n";

sub shortest_time {
  (
    reduce {
	my($last,$min) = ref$a ? @$a : ($a,undef);
	my $diff = $b - $last;
	[$b, !defined$min || $diff < $min ? $diff : $min]
    }
    map{ my($hh,$mm) = split/:/; $hh*60 + $mm }
    sort @_
   )[0][1]
}
