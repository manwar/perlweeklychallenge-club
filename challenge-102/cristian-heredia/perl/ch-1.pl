=begin

    TASK #1 › Rare Numbers
    Submitted by: Mohammad S Anwar
    You are given a positive integer $N.
    
    Write a script to generate all Rare numbers of size $N if exists. Please checkout the page for more information about it.
    
    Examples
        (a) 2 digits: 65
        (b) 6 digits: 621770
        (c) 9 digits: 281089082

=end
=cut



use strict;
use warnings;
use Data::Dumper;


my $number = 2;
my $min = 1;
my $max = 9;
my @array;
my $revNumber;
my $check1;
my $check2;
my $i;

createNumbers();
operation();

#First, create the array with the naumbers with size N
sub createNumbers{
    $max .= '9' while $number > length $max;
    $min .= '0' while $number > length $min;
    @array = ($min..$max);
}

#R + R1 = X2 and R - R1 = Y2
sub operation {
    for ($i = 0; $i < @array; $i++) {
        $revNumber = reverse($array[$i]);
        $check1 = $array[$i] + $revNumber;
        $check2 = $array[$i] - $revNumber;
        if ($check2 > 0) {
            perfectSquare();
        }
    }
}

#Check that they're perfect square
sub perfectSquare {
    my $result1 = sqrt $check1;
    
    my $result2 = sqrt $check2;
    if ($result1 =~ /^\d+$/ and $result2 =~ /^\d+$/) {
      print "$array[$i]\n";
    }
}
