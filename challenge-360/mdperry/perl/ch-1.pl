#!/usr/bin/env perl

use strict;
use warnings;

my @inputs = ( ["Hi", 5], ["Code", 10], ["Hello", 9], ["Perl", 4], ["A", 7], ["", 5]);

foreach my $input ( @inputs ) {
    my ( $output, $pad1, $pad2, );
    my ( $str, $width ) = ($input->[0], $input->[1]);
    my $diff = $width - length($str);

    # This approach methodically assembles the desired padded string step
    # by step using Perl's concatenation operator: '.' and stores the
    # manipulations in the $output variable
    
    # if the string is empty then the output consists solely of padding
    if ( length($str) == 0 ) {
        $output = "*" x $width;
    }	
    else {
	# if the difference between the string length and the format width is
	# even then the padding is equal on each side of the string
	if ( $diff % 2 == 0 ) {
            $pad1 = $diff / 2;
            $pad2 = $pad1;
	    $output = "*" x $pad1 . $str . "*" x $pad2;
	}
        # but if the difference is odd, then we need adjust the number of
	# padding characters on each side of the string output
	else {
	    my $half = $diff / 2;
	    ($pad1) = $half =~ m/(\d+)\./;
            $pad2 = $diff - $pad1;
            $output = "*" x $pad1 . $str . "*" x $pad2;
	}
    }

    # My approach to printing the output shown in the challenge example
    # is cumbersome, to say the least.  There may be more elegant, and
    # faster ways to decide what to print, and how to assemble the
    # desired elements

    print "Input: \$str = \"", $str, "\", \$width = ", $width, "\n";
    print "Output: \"", $output, "\"\n\n";
    if ( length($str) == 0 ) {
        print "Text length = ", length($str), ", Width = ", $width, "\n";		
        print "Entire output is padding\n\n\n";
    }
    elsif ( length($str) == $width ) {
        print "No padding is needed\n\n\n";
    }
    else {
        print "Text length = ", length($str), ", Width = ", $width, "\n";	
        print "Need ", $diff, " padding characters total\n";
        print "Left padding: ", $pad1;
        $pad1 > 1 ? print " stars" : print " star";
        print ", Right padding: ", $pad2;
        $pad2 > 1 ? print " stars" : print " star";
        print "\n\n\n";
    }

}

exit;

