use strict;
use warnings;
use List::Util qw(any);

# Give the integer for the upper limit of 1 - $N
my $N = 25;

# This array contains the range of numbers we want to check
my @list = (1..$N);

my @count = ();

# find all the numbers that dont contain 1
@count = @count = grep { $_  if $_ !~ /1/g } @list;

# print them
my $count = 0;
print "There are " . scalar(@count) . " numbers between 1 and $N that don't contain digit 1.\n";
foreach (@count) {
    if ($count != $#count){
        print("$_, ");
    } else {
        print ("$_.\n");
    }
$count++;
}