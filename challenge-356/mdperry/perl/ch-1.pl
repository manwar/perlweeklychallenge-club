#!/usr/bin/env perl

# https://theweeklychallenge.org/blog/perl-weekly-challenge-356/#TASK1

use strict;
use warnings;


=head1 Context

My new mantra is, "Just because you're really good at counting things
that doesn't mean you are good at math . . . "

Full disclosure, it took me a very long time to wrap my head around
whatever the heck this Kolakoski Sequence is (or does).  And even
then figuring out a satisfactory algorithm took a lot of tweaking.

As a bioinformatician, I think the key insight was to realize that
there are two separate but related processes taking place to
generate the correct sequence.

By analogy with a nucleotide sequence (i.e., a growing string
made up from "letters" in a defined alphabet), one activity,
or function, is like a reading head that proceeds along the
nucleotide sequence, one base at a time, and determines which
alphabet letter is there.  Then there is a separate function,
like a polymerase, that wants to add on to the end of the sequence
by adding new letters (or bases).  This synthesis activity
needs the information from the reading head to know
(A.) which letter to add on to the end, and
(B.) How many copies of that letter to add

In this Perl Weekly Challenge, there are no nucleotide bases
instead the alphabet is the set {1,2}, and the run lengths of
letters ("numbers") that you insert can be either one, or two.

So, '1', '2', '11, or '22' those are your only choices.


=cut


foreach my $n ( 4, 5, 6, 7, 8 ) {

    # This is probably "cheating", but I use the first three positions
    # as the seed, and the algorithm below works if you want to calculate
    # sequences that are 4 or higher in length
    my @sequence = (1,2,2);
    my $read_pos = 2; # This is where the reading head is pointing right now
    my $current_symbol = 1; # Next run will use this symbol
    my @out = ();

    # This is a hack to get my output to look like the example's output
    # I build up a separate array with the just these "patterns" to be printed out
    my @patterns = ( '1', '22',);

    for (my $i = $read_pos; $i < $n; $i++) {
        my $run_length = $sequence[$read_pos]; ## Run length can only be 1, or 2
        my $pattern = q{};

        if ( $run_length == 1 ) {
            if ( $current_symbol == 1 ) {
                @out = (1);
	        $pattern = '1';
            }
            else {
                @out = (2);
                $pattern ='2';
            }
        }
        else {
            if ( $current_symbol == 1 ) {
                @out = (1,1);
                $pattern = '11';
    	    }
            else {
                @out = (2,2);
                $pattern = '22';
            }
        }

        push( @sequence, @out );
        push( @patterns, $pattern);
    
        $current_symbol = ($current_symbol == 1) ? 2 : 1;
        $read_pos++;
    }


    # Array slice to print just the first n elements
    @sequence = @sequence[0..$n-1];

    my @ones = grep {/1/} @sequence;

    my $one_count = scalar( @ones );

    print "Input: \$int = $n\n";
    print "Output: $one_count\n\n";

    print '(', join( ")(", @patterns ), ') => ';
    print join('', @sequence), "\n\n";

}
    

__END__

    
