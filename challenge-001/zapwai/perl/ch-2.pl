#!/usr/bin/env perl
use v5.30.0;
# for my $i (1 .. 20) {
#     if ($i % 3 == 0) {    print "fizz" }
#     if ($i % 5 == 0) {   print "buzz" }
#     unless (($i % 3 == 0) or ($i % 5 == 0)) { print $i; };
#     print "\n";
# }

(($_ % 3 == 0) and ($_ % 5 == 0))?
    {
	say "fizzbuzz" }
    : {
	($_ % 3 == 0) ?
	    {
		say "fizz" }
	    : {
		($_ % 5 == 0) ?
		    {
			say "buzz" } 
		    : {
			say $_ }
		}
	}
    for (1 .. 20);
