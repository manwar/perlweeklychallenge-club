#!perl.exe

use strict;
use warnings;
use ntheory qw/ divisors /;
use IO::Prompter;

### AUTHOR: Robert DiCicco
### DATE: 06-DEC-2021
### Challenge #142 Divisor Last Digit

my @outlist = ();

my $fnum = prompt 'Input the first number : ', -integer => [ 1 .. 99999 ];
chomp($fnum);
$fnum = int($fnum);

my $snum = prompt 'Input the second number (last digit) : ',
  -integer => [ 0 .. 9 ];
chomp($snum);
$snum = int($snum);

# Get list of divisors for $fnum
my @d = divisors($fnum);

# And get rid of the last entry, which is $fnum
pop(@d);

# Check to see if we have saved anything to our array
if ( scalar(@d) ) {
    print("The divisors of $fnum are : @d\n");
}
else {
    die "There are no divisors. Aborting\n";
}

# Foreach divisor in our array
# get its last digit and save it in the outlist array

foreach my $n (@d) {
    my $retval = lastdigit($n);
    if ( ( $retval == $snum ) and ( $fnum != $snum ) ) {
        push( @outlist, $n );
    }
}

# Print the count of those divisors that have the proper last digit,
# and the list of those divisors

if ( scalar(@outlist) ) {
    print(  "There are only "
          . scalar(@outlist)
          . " divisor\(s\) having last digit $snum\n" );
    print("They are :  @outlist\n");
}
else {
    die "There are no divisors that have a last digit of $snum\n";
}

# Given an integer, return its last digit

sub lastdigit {
    my $len = length( $_[0] ) - 1;
                # Return the number if it is only one digit long
    if ( $len == 0 ) {
        return ( $_[0] );
    }
    else {
        # split into digits
        my @spl = split( //, $_[0] );
        return ( $spl[$len] );
    }
}
