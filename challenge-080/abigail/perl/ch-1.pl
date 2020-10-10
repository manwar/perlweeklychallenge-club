#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';


#
# Challenge 1:
#
#     You are given unsorted list of integers @N.
# 
#     Write a script to find out the smallest positive number missing.
#

while (<>) {
    #
    # Read a line of input, extract the integers, and store
    # them in a hash %N.
    #
    my %N;
    @N {/-?[0-9]+/g} = ();

    #
    # Find the missing number: start with 1, increament as long
    # as it's in %N. We'll stop as soon as we find the missing number.
    #
    my $try = 1;
    $try ++ while exists $N {$try};
    say $try;
}

__END__
