use strict; use warnings; use v5.10; use List::Util 'sum'; 

sub valid_luhns {
   sum(
     shift                     #get the input
     =~ s/\D//gr               #remove all non-digits
     =~ s/^.(..)+$/0$&/r       #prefix with 0 if input have odd number of digits
     =~ s/(.)(.)/$1*2 . $2/ger #replace first digit in all pairs with its double
     =~ /\d/g                  #split into single digits
   )                           #sum up single digits
   % 10                        #get last digit of the sum
   == 0                        #return true if it's 0, or false otherwise 
}

say valid_luhns("@ARGV") ? 'true' : 'false' and exit if @ARGV;

use Test::More;
my($true,$false)=(1,'');
is valid_luhns("17893729974")         => $true;
is valid_luhns("4137 8947 1175 5904") => $true;
is valid_luhns("4137 8974 1175 5904") => $false;
done_testing;
