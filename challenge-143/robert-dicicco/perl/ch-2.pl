#!perl.exe

use strict;
use warnings;
use ntheory qw/divisors/;
use IO::Prompter;

### Author: Robert DiCicco
### Date: 13-DEC-2021
### Challenge #143 Stealthy Number

# initialize vars
# array to hold list of divisors
my @final = ();

# sum of initial set of divisors
my $target = 0;

# limit to single digits
my $limit = 10;

# Get number from user
my $inp = prompt 'Input the number : ', -integer => [ 1 .. 999 ];
chomp($inp);
$inp = int($inp);

# calculate list of divisors
my @d = divisors($inp);

# get divisors and their sums
foreach(sort @d){
    #skip if divisor is greater than $limit
    next if($_ >= $limit);

    my $val = $inp / $_;

    # is single digit
    if($val < $limit) {
        my $digit_sum = $val + $_;
        if($target == 0){
            $target = $digit_sum;
            push(@final,$val,$_);
        }

        if($digit_sum == ($target - 1)){
            push(@final,$val,$_);
            last;
        }
    }
}

# if we have 4 divisors that meet the criteria, print
if(scalar(@final) == 4){
    print("$final[0] x $final[1] = $final[2] x $final[3] and $final[0] + $final[1] = $final[2] + $final[3] + 1\n");
} else {
    print("Not Stealthy!\n");
}
