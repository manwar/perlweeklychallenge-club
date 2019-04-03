use strict;
use warnings;
##
# Challenge #2
# Write one-liner to solve FizzBuzz problem and print number 1-20.
# However, any number divisible by 3 should be replaced by the word fizz
# and any divisible by 5 by the word buzz. Numbers divisible by both become fizz buzz.
##
use experimental q/switch/;
my $i = 1;
{
    given($i){
        when($i % 3 == 0 && $i % 5 == 0){
            print "fizz buzz\n";
        }
        when($i % 5 == 0){
            print "buzz\n";
        }
        when($i % 3 == 0){
            print "fizz\n";
        }
        default{
            print "$i\n";
        }
    }
    $i++;
    redo until ($i > 20);
}
