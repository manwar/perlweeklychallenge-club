#!perl.exe

use strict;
use warnings;
use threads;
use Time::HiRes qw/ usleep /;

### AUTHOR: Robert DiCicco
### DATE: 07-DEC-2021
### Challenge #142 Sleep Sort

my $start = Time::HiRes::time();
print("\nStart Time : $start\n\n");

# Original array to be sorted
my @arr = qw/ 9 8 z g R o p x u a b 0 /;

my @threads = ();

# '0' = 48
my $offset = 48;

my $item = '';
print("Array to be sorted : ");

print("@arr\n");

print("Sorted array          : ");

# Create a thread for each item in the source array
# Send the item and its adjusted value to the sub

foreach $item ( @arr ){
    my $t = threads->create(\&sub1, $item,ord($item) - $offset);
    # push the thread id into an array
    push(@threads, $t);
}

# Join threads, read from array

foreach (@threads) {
    $_->join;
}

my $end = Time::HiRes::time();

print("\n\nEnd Time : $end\n");
print("\nElapsed Time : " . ($end - $start) . "\n");

sub sub1 {
    my $message = $_[0];
    # HiRes microseconds are too quick, adjusted by multiplying by 10000
    usleep($_[1] * 10000);
    print(" $message");
}
