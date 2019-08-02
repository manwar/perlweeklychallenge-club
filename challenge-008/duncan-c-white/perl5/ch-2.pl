#!/usr/bin/perl

# Challenge 2: "Write a function, center, whose argument is a list of
# strings, which will be lines of text. The function should insert spaces
# at the beginning of the lines of text so that if they were printed,
# the text would be centered, and return the modified lines."

use strict;
use warnings;
use Function::Parameters;
use File::Slurp;
use Data::Dumper;

die "Usage: ch-2.pl [DATAFILE]\n" if @ARGV > 1;
my $datafilename = shift // $0;


#
# my $maxlen = maxlength( @data );
#       Find and return the maximum length of any string
#       element of @data.
#
fun maxlength( @data )
{
        my $maxlen = 0;
        foreach my $s (@data)
        {
                my $l = length($s);
                $maxlen = $l if $l>$maxlen;
        }
        return $maxlen;
}


#
# my @centred = center( @data );
#       Center every element of @data, building
#       and returning a new @centred array, in
#       which every element is the original element
#       of @data, padded with leading spaces to centere it.
#
fun center( @data )
{
        my @result;
        my $maxlen = maxlength( @data );
        foreach my $s (@data)
        {
                my $l = length($s);
                my $pad = ($maxlen - $l)/2;
                my $centred = (' 'x$pad).$s;
                push @result, $centred;
        }
        return @result;
}


my @data = read_file( $datafilename );
my @centered = center( @data );
map { print } @centered;
