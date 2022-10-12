#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my @a = qw{ 1 2 3 };
my @b = qw{ a b c };

{
my $aa = join ' ' , @a;
my $bb =  join ' ', @b;
my @output1 = zip( @a, @b );
my $output1 = join ' ', @output1;
my @output2 = zip( @b, @a );
my $output2 = join ' ', @output2;
say <<"END";
    Input:  \@a = qw/$aa/; \@b = qw/$bb/;
    Output: zip(\@a, \@b ) returns qw/$output1/
            zip(\@b, \@a ) returns qw/$output2/
END
}

# we are told to create a subroutine sub zip(@a,@b) that merges two lists
#
# the problem is that ( @a, @b ) makes them one big @_ for the function
#
# there are two ways to handle this: pass array references or rely on the
# fact that they're the same size

sub zip ( @array ) {
    my @output;
    if ( !scalar @array % 2 ) {
        my @second;
        while ( scalar @second != scalar @array ) {
            push @second, shift @array;
        }
        while ( scalar @second ) {
            push @output, shift @second;
            push @output, shift @array;
        }
    }
    return @output;
}
