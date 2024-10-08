use strict; use warnings; use v5.10; use List::Util 'sum';

sub valid_luhns {
   sum(
     shift                     #get the input
     =~ s/\D//gr               #remove all non-digits
     =~ s/^.(..)+$/0$&/r       #prefix with 0 to make odd number of digits even
     =~ s/(.)(.)/$1*2 . $2/ger #for all pairs: change first digit to its double and keep second digit as is
     =~ /\d/g                  #split into single digits
   )                           #sum up single digits
   =~ /0$/                     #return true if the sum ends with 0 (divisible by 10 with a 0 remainder)
}

say valid_luhns("@ARGV") ? 'true' : 'false' and exit if @ARGV;

use Test::More;
my($true,$false)=(1,'');
is valid_luhns("17893729974")         => $true;
is valid_luhns("4137 8947 1175 5904") => $true;
is valid_luhns("4137 8974 1175 5904") => $false;
done_testing;

=pod

* Insert a 0 digit in front of the input to start with an even number of digits if the number of input digits isn't already even.
  To be able to split the digits into pairs.

* Then, for each pair of digits, starting from the front here (from the back would be the same), replace the first digits
  in each pair by the digit/digits of its double and keep the second digit of the pair as is.  By replacing for example 7
  by its double 14, we don't need to add those two digits in a special addition 1+4 first, as the challenge suggests.
  We can just add both 1 and 4 (from 14) directly (x+5 = x+1+4).

* The last "payload" digit doesn't have to be treated specially. Just add that too as a second digit of the last pair.

* If the sum now ends with a 0 digit (is divisible by 10 with a zero remainder), the input was a valid string.

=cut

__END__
#Further tests
use Algorithm::LUHN;
my @test = map { join'',map int(rand 10), 1 .. 1+rand(30)  } 1..1e5;
for(@test){
    my($l1, $l2) = (valid_luhns($_), Algorithm::LUHN::is_valid($_));
    say "ERROR: l1: $l1   l2: $l2" if $l1 xor $l2;
}

