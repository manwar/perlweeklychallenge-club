#!/usr/bin/perl
use strict;
use Test::Simple tests => 3;


sub newlist {
    my @small = ();
    my @large = ();
    my ($K, @line) = @_;
    foreach(@line) {
    	if ($_ < $K) {
            push @small, $_;
        }
        else {
            push @large, $_;
        }
    }

    return (@small, @large);
}

print join "," , newlist @ARGV;
print "\n";

ok (newlist(3, 1, 4, 3, 2, 5, 2))==(1, 2, 2, 4, 3, 5) , "bad condition";
ok (newlist(6,5,6,3,2,7,9)) ==  (5,3,2,6,7,9), "bad";  
ok (newlist(2 , 3, 2, 1)) == (1, 3, 2), "too bad";

