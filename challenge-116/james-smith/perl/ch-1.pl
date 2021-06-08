#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my $nspace = join '', 1..1000;
my $ncomma = join ',',1..1000;
my $lint_x = my $lint   = ('9' x 999).'8';
my $lint_y = ++$lint_x;
$lint_y++;

my @tests = (
 [ 1234,  '1,2,3,4' ],
 [ 91011, '9,10,11' ],
 [ 10203, '10203'   ],
 ## Numerical comparisons don't work....
 [ $nspace, $ncomma ],                                     ## 2895 digit no -> 1..1000
 ## Have to store range as can't use range operator here...
 [ $lint.$lint_x.$lint_y, $lint.','.$lint_x.','.$lint_y ], ## 3001 digit no -> 2 x 1000 digit + 1001 digit no.
 [ $lint.$lint_x, $lint.','.$lint_x ],                     ## 2000 digit no -> 2 x 1000 digit
 [ $lint_x.$lint_y, $lint_x.','.$lint_y ],                 ## 2001 digit no ->     1000 digit + 1001 digit no.
 [ $nspace.'99', $nspace.'99' ],                           ## 2895 digit no -> 2895 digit no
);

is( join(',',@{splitnum($_->[0])}),$_->[1] ) foreach @tests;
is( join(',',@{splitnum_no_comments($_->[0])}),$_->[1] ) foreach @tests;

done_testing();

sub splitnum {
  my( $in, $start ) = ( shift, '' );
  for( split //, substr $in, 0, (my $len = length $in) >> 1) {
    ## $start contains the first number of sequence
    ## each time through the loop we will add the
    ## next digit eg 1, 12, 123
    ##
    ## $end contains a copy of this, which we will
    ## then incremement as we generate the sum

    my @range = ( my $str = my $end = $start .= $_ );

    ## We concatenate the of "end" onto $string until
    ## it is equal to or larger than the input number

    ($str .= ++$end) && push @range, $end while $len > length $str;

    ## Finally we return the list if the input and
    ## string are the same. Note we will always get
    ## a true value as in the last loop
    ##   $in == $start == $end == $string

    return \@range if $str eq $in;
  }
  return [$in];
}


## We work in string space - as this works best for large values of input
## like the 123....9991000 example above..
##
## There are some optimizations you could try {e.g. looping up to half the
## length of $n - but only really valid if you are getting very large
## values of $n...}

## Below is the code above with the comments removed
sub splitnum_no_comments {
  my( $in, $start ) = ( shift, '' );
  for( split //, substr $in, 0, (my $len = length $in) >> 1) {
    my @range = ( my $str = my $end = $start .= $_ );
    ($str .= ++$end) && push @range,$end while $len > length $str;
    return \@range if $str eq $in;
  }
  return [$in];
}

