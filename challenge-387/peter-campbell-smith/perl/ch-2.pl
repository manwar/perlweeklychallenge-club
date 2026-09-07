#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/387/2

use v5.26;    # The Weekly Challenge - 2026-08-17
use utf8;     # Week 387 - task 2 - Atoms count
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

atoms_count('((N2O)3(H2O)2)2');
atoms_count('Mg3(PO4)2');
atoms_count('(((H)2)3)4');
atoms_count('NaCl3(O2(S10)2)2Mg');
atoms_count('Z2Y3(X2W)2');

sub atoms_count {
	
	my ($f, $m, $n, %c, @s, $k);
	
	# initialise
	$f = shift;
	say qq[\nInput:  '$f'];
	$m = $n = 1;
	%c = ();

	# tokenise
	$f = reverse($f);
    while ($f) {
    	# digits + close bracket
	    if ($f =~ m|^(\d+)\)(.*)|) {
		    push @s, $1;
            $m *= $1;		    
		
		# digits
	    } elsif ($f =~ m|^(\d+)(.*)|) {
		    $n = reverse($1);

		# symbol A or Ab		    
    	} elsif ($f =~ m|^([a-z]?[A-Z])(.*)|) {
    		$c{reverse($1)} += $n * $m;
		    $n = 1;
		
        # open bracket
		} elsif ($f =~ m|^(\()(.*)|) {
			$m /= pop @s;
			
	    # close bracket
	    } elsif ($f =~ m|^(\))(.*)|) {
			
		} else { 
			last;
        }
		$f = $2;
	}
	
	# report
	print qq[Output: '];
	for $k (sort keys %c) {
		$c{$k} = '' if $c{$k} < 2;
		print qq[$k$c{$k}];
	}
	say q['];
}
 