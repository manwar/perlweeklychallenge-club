#!/usr/env/perl
# Task 1 Challenge 049 Solution by saiftynet
# Smallest Multiple
# Write a script to accept a positive number as command line argument 
# and print the smallest multiple of the given number consists of 
# digits 0 and 1.
# For example:
# For given number 55, the smallest multiple is 110 consisting of 
# digits 0 and 1.
#
# This solution offers two methods of finding the answer. One is simple
# naive answer just incrementing multipliers until a suitable target found.
# It is offered just for illustration. method2() is significantly faster.

$input=$ARGV[0];   # if input offered, returns result as specified in task
if ($input){
   method2($input)  
}
else{              # interactive operation starts if no commandline parameter 
    while (1){
      print "Enter a number to process, or a non-number to quit >>";
      chomp( $input = <STDIN>);
      last if not $input or $input=~/[^\d]/;
      method2($input);
    };
}

# naive  routine...multiples of 9 and a few other numbers take a
# disproportionately long time.  The smallest number with 9 requires
# a muliplier of 12345679, 99 requires a multiplier 1122334455667789
# producing 111_111_111_111_111_111. To save that trouble, the routine
# simply refuses to even try....
sub method1{
    my $input=shift;
    return print "Computer says NO!\n",
                 "Multiples of 9 are quicker with method2\n"
                       unless $input % 9;
    my $multiplier=1;
    while ((($input*$multiplier)."")=~/[2-9]/){$multiplier++}; increment unt
    print "Input: $input, Multiplier: $multiplier Result: ", $input*$multiplier,"\n";
}

# Method2 in contrast is comparatively lightning fast.  It builds up
# progressively larger strings consisting of 1s and 0s stored in
# @list and tests them for divisibility by the input
sub method2{
   my $input=shift;
   my $found=0;                        # no answer yet
   my @list=(1);                       # start with @list containing 1
   while (!$found){                  
      @list=map{$_."0",$_."1"} @list;  # appends "0" or "1" to each element
      foreach (@list){
          $found=$_ unless $_ % $input;# $result stored in $found if multiple found
          last if $found;              # exit loop once $found
      }
   }
   print "Input: $input, Multiplier: ",$found/$input, "  Result: ",  $found,"\n";
}

