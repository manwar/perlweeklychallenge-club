=begin

TASK #2 › Binary Substings
Submitted by: Mohammad S Anwar
You are given a binary string $B and an integer $S.

Write a script to split the binary string $B of size $S and then find the minimum number of flips required to make it all the same.

    Example 1:
        Input: $B = “101100101”, $S = 3
        Output: 1
        
        Binary Substrings:
            "101": 0 flip
            "100": 1 flip to make it "101"
            "101": 0 flip
    Example 2:
        Input $B = “10110111”, $S = 4
        Output: 2
        
        Binary Substrings:
            "1011": 0 flip
            "0111": 2 flips to make it "1011"

=end
=cut

use strict;
use warnings;
use Data::Dumper;

my $B = 101100101;
my $S = 3;
my @cutBinary;
my @C1;
my @C2;
my %hash;

splitBinary();
checkBinaries();

sub splitBinary {
    @cutBinary = $B =~ /\d{1,$S}/g;
}

sub checkBinaries {
    foreach(my $i = 0; $i <@cutBinary; $i++) {
        
        @C1 = split(//,$cutBinary[$i]);
        if (!exists $hash{$cutBinary[$i]}) {
            addKey($cutBinary[$i]);
        }
        else{
            next;
        }
        foreach(my $j = 0; $j <@cutBinary; $j++){
            if($i != $j) {
                @C2 = split(//,$cutBinary[$j]);
                my $total = compareValors(\@C1, \@C2);
                $hash{$cutBinary[$i]} = $hash{$cutBinary[$i]} + $total;
            }
        }
    }
}

sub addKey{
    my $key = shift;
    if(!exists $hash{$key}) {
        $hash{$key} = 0;
    }
}

sub compareValors {
    my @array1 = @{$_[0]};
    my @array2 = @{$_[1]};
    my $counter = 0;
    foreach(my $k = 0; $k <@array1; $k++){
        if ($array1[$k] != $array2[$k]){
            $counter++;
        }
    }
    return $counter;
}

my @small = sort { $hash{$a} <=> $hash{$b} } keys %hash;
my $smallest = $hash{$small[0]};
print "$smallest\n";
