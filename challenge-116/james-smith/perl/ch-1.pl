#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my $nspace = join '', 1..1000;
my $ncomma = join ',',1..1000;
my @tests = (
 [ 1234,  '1,2,3,4' ],
 [ 91011, '9,10,11' ],
 [ 10203, '10203'   ],
 [ $nspace, $ncomma ],
);

is( join(',',@{splitnum($_->[0])}),$_->[1] ) foreach @tests;

done_testing();

sub splitnum {
  my( $in, $start ) = ( shift, '' );
  foreach( split //, $in ) {
    ## $start contains the first number of sequence
    ## each time through the loop we will add the
    ## next digit eg 1, 12, 123, 124
    ##
    ## $end contains a copy of this, which we will
    ## then incremement as we generate the sum

    my $string = my $end = $start .= $_;

    ## We concatenate the of "end" onto $string until
    ## it is equal to or larger than the input number

    $string .= ++$end while $in gt $string && length $in > length $string;

    ## Finally we return the list if the input and
    ## string are the same. Note we will always get
    ## a true value as in the last loop
    ##   $in == $start == $end == $string

    return [$start..$end] if $string eq $in;

  }
}


## We work in string space - as this works best for large values of input
## like the 123....9991000 example above..
##
## There are some optimizations you could try {e.g. looping up to half the
## length of $n - but only really valid if you are getting very large
## values of $n...}

sub splitnum_no_comments {
  my($in,$st) = (shift,'');
  for( split //, $in ) {
    my $t = my $en = $st .= $_;
    $t .= ++$en while $in gt $t && length $in > length $t;
    return [$st..$en] if $t eq $in;
  }
}

