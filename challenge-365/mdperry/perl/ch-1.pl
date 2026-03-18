#!/usr/bin/env perl

use v5.38;


=head1 COMMENTS

 Task 1: Alphabet Index Digit Sum

 You are given a string $str consisting of lowercase English letters, and an integer $k.

 Write a script to convert a lowercase string into numbers using alphabet positions (a=1 . . z=26),
 concatenate them to form an integer, then compute the sum of its digits repeatedly $k times,
 returning the final value.


=cut


# Very basic, a plain vanilla hash of arrayrefs
my %examples = ( Example_1 => [ "abc", 1 ],
		 Example_2 => [ "az" , 2 ], 
		 Example_3 => [ "cat", 1 ],
                 Example_4 => [ "dog", 2 ],
		 Example_5 => [ "perl", 3 ],
 	       );

# Laboriously creating our lookup table at the keyboard, I suspect
# the cool kids will have derived some devilishly clever ways to accomplish
# this with much less data entry.  Who knows, there may even be a CPAN module
# that provides this function?
my %lut = ( a => 1, b => 2, c => 3, d => 4, e => 5, f => 6, g => 7, h => 8, i => 9,
	    j => 10, k => 11, l => 12, m => 13, n => 14, o => 15, p => 16, q => 17,
	    r => 18, s => 19, t => 20, u => 21, v => 22, w => 23, x => 24, y => 25, z => 26 );


foreach my $example ( sort keys %examples ) {
    my ( $str, $k, ) = $examples{$example}->@*;		 
    my $int = q{};
    # Getting a bit lazy and using the builtin
    # loop variable instead of declaring our own
    # Don't try this at home with your production code
    foreach ( split(//, $str) ) {
        $int .= $lut{$_};
    }

    # When $int only contains a single numeral then we no
    # longer need to call our subroutine
    for (1..$k) {
        # The subroutine gets called on the return value of the
	# subroutine until output is complete 
        $int = add_them_up( $int ) if length $int > 1;
    }
    
    print "$example\n";
    print "Input: \$str = \"", $str, "\", \$k = ", $k, "\n";
    print "Output: $int\n\n";

}

# Very old school
# I would not be surprised to learn that there is some nifty way to
# calculate this with fewer coding key strokes.
sub add_them_up {
    my $int = shift @_;
    my @digits = split(//, $int );
    my $sum = 0;
    foreach ( @digits ) {
        $sum += $_;
    }
    return $sum;
}    

__END__

Results from running this Script:

Example_1
Input: $str = "abc", $k = 1
Output: 6

Example_2
Input: $str = "az", $k = 2
Output: 9

Example_3
Input: $str = "cat", $k = 1
Output: 6

Example_4
Input: $str = "dog", $k = 2
Output: 8

Example_5
Input: $str = "perl", $k = 3
Output: 6

