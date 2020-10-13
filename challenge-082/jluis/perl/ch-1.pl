#!/usr/bin/env perl
# common divisors 
#

use strict;
use warnings;

use 5.010;

if (2 > @ARGV ) {
	say STDERR qq(you sould pass 2 integer numbers ex : ./ch-1.pl 30 50);
}

my ($M,$N) = @ARGV;

if (qq($M$N) !~ /^\d+$/xms) {
	say STDERR qq(only integers are allowed "$M$N");
}

# by the examples we should discard that any number is a factor of itself 1*n == n and n/n = 1 
# 
sub factors {
    my $num   = shift;
    if ($num > 0) {
    	my $upper = int $num / 2;
    	return ( 1,grep {! ($num % $_) } (2..$upper) )
    } 
    return ();
}

sub comon {
    my @a = factors shift;
    say join "a",@a;
    my @b = factors shift;
    say join "b",@b;
    if ($#a == 0 or $#b == 0) {
	    return ();
    }
    my ($i,$j) = (1,1);
    my @common = ();
    while ($i <= $#a and $j <= $#b) {
	    if ($a[$i] == $b[$j]) {
		    push @common, $a[$i] ;
		    $i += 1;
		    $j += 1;
	    } elsif ($a[$i] > $b[$j]) {
	            $j += 1;
	    } else {
		    $i += 1;
	    }
    }
    return (1,@common);
}    
   
say join q{,} , comon $M,$N; 
