#!perl.exe

use strict;
use warnings;
use IO::Prompter;
use List::MoreUtils qw / uniq /;

### Author: Robert DiCicco
### Date: 29-NOV-2021
### Challenge 141 Like Numbers

my $inp = prompt 'Input a 3 or 4 digit number : ', -integer => [100..9999];
$inp = int($inp);

my $dd = prompt 'Enter divisor : ', -integer => [2..99];
$dd = int($dd);

my @num = split(//,$inp);
my $len = scalar(@num);

if($len == 3){
    my @arr = (  $num[0],$num[1],$num[2],
                 "$num[0]$num[1]", "$num[0]$num[2]",
                 "$num[1]$num[2]",
              );
    @arr = uniq(@arr);
    printit( \@arr );
}
elsif ( $len == 4 ){
    my @arr2 = (  $num[0],$num[1],$num[2],$num[3],
                  "$num[0]$num[1]", "$num[0]$num[2]", "$num[0]$num[3]",
                  "$num[1]$num[2]",  "$num[1]$num[3]",
                  "$num[2]$num[3]",
                  "$num[0]$num[1]$num[2]",
                  "$num[0]$num[1]$num[3]",
                  "$num[0]$num[2]$num[3]",
                  "$num[1]$num[2]$num[3]",
               );
    @arr2 = uniq(@arr2);
    printit( \@arr2 );
}

sub printit {
    my $aref = shift;
    print("Possible integers created : ");
    foreach (@$aref){
        print("$_ ");
    }
    print("\n");
    print("Integers divisible by $dd : ");
    foreach (@$aref){
        if(($_ % $dd) == 0){
            print("$_ ");
        }
    }
    print("\n");
}
