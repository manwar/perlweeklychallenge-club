#!/usr/bin/env perl
# Perl weekly challenge 288
# Task 1:  Closest Palindrome
#
# See https://wlmb.github.io/2024/09/23/PWC288/#task-1-closest-palindrome
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to find the closest and smallest palindrome to the numbers N1 N2...
    FIN
for(@ARGV){
    say("Only digits allowed: $_"), next unless /^\d+$/;
    my $original=$_;
    s/^0+(.+)/$1/; # Remove leading zeroes
    my $result =
	  /^0$/
	  ? 1 # Zero? Add one
	  : /^\d$/
	  ? $_-1 # Single digit? Subtract one
	  : /^(.+)(.?)(??{reverse $1})$/
          ? ($1-1)   # Palindrome? Decrease first part
	    .
	    (length($1-1)==length($1)
	    ? $2  # Conserved length? Insert middle part.
	    : length($2)
	    ? 99 # Finite middle part? Replace by 99
	    : 9  # or add a 9
	    )
	    . reverse($1-1) # Finish palindrome
	  : /^(.+)(.?)(??{"."x length $1})$/ # Generic case
            && $1.$2.reverse $1 # Reverse first part
	;
    say "$original -> $result";
}
