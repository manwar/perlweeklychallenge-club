#!/usr/env perl
# Perl Weekly Challenge 42-1 Script
# Octal Number System Write a script to print decimal number 0 to 50
# in Octal Number System.
# Task extended to allow conversion into any base
# from 2 to 36 (using A-Z), and also converts back from any base 
# back to decimal

use strict; use warnings;

my $base=8;

print "Converting from decimal to octal (base 8)\n";

for my $n (1..50){
  printf ("Decimal %2s is %2s in base %1s\n",$n, decimalTobaseN($base,$n), $base) ; 
}

sub decimalTobaseN{
   my ($base,$number)=@_;                   # Function receives base and the number to convert
   my @digits=(0..9,'A'..'Z');              # potential output characters

   my $string="";                           # holds the output as string of characters
   
   while ($number>0){                       # continue until no more required
      my $remainder=$number % $base;        # get the remainder after division with base
      $string=$digits[$remainder].$string;  # add that to the left most side of string 
      $number=($number-$remainder)/$base;   # divide the residual number by base
   }
   
   return $string                           # return the result
}

# The following section describes a function inverse of decimalToBaseN()
# Goal is to convert baseN string generated above back to decimal

print "\n\nPress any key to continue\n";
<STDIN>;
print "Converting decimal 100 into bases 2 to 36 and then back again\n\n";

for $base (2..36){                         # for each valid base
	  my $a = decimalTobaseN($base,100);   # convert decimal 100 into that base
	  my $b = baseNToDecimal($base,$a);    # then convert result back to decimal
	  
	  printf ("Decimal 100 in base %2s is %2s and converted back is %2s\n",$base, $a, $b) ; 
}

sub baseNToDecimal{
   my ($base,$string)=@_;                   # Function receives base and the string to convert
   my %baseValues;                          # the base characters to decimal value are 
   @baseValues{(0..9,'A'..'Z')}=(0..36);    # stored in a hash 
   my $result=0;                            # initial value is zero
   foreach (split //,$string){              # go over each character in the string
	                                        # multiplying result by the base before adding
	   $result=$result*$base+$baseValues{$_};  # next character value to result
   }
   return $result;                          # return the result
}
