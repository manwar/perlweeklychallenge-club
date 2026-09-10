#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-09-07
use utf8;     # Week 390 - task 1 - Decode string
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

decode_string('2[3[a]]');
decode_string('10[a]');
decode_string('a2[b]c3[d]e');
decode_string('2[a2[b]c]');
decode_string('1[a]2[b3[c]]');
decode_string('4[x3[y2[f]]]');
decode_string('co2[m]i2[t]2[e]');
decode_string('3[bang]');

sub decode_string {
	
	my ($f, $m, %c, @s, $o);
		    
    # initialise
    $f = shift;
    say qq[\nInput:  '$f'];
    $m = 1;
    %c = ();

    # scan input
    while ($f) {
        
        # [ = increase multiplier
        if ($f =~ m|^(\d+)\[(.*)|) {
            push @s, $1;
            $m *= $1;
        
        # repeat letter $m times
        } elsif ($f =~ m|^([a-z]+)(.*)|) {
			$o .= $1 x $m;
        
        # ] = decrease multiplier
        } elsif ($f =~ m|^(\])(.*)|) {
            $m /= pop @s;
        
		} else {
			last;
		}
        $f = $2;
    }
    
    # report
    say qq[Output: '$o'];
}
