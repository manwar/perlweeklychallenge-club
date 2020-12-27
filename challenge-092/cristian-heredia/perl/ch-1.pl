=begin

    TASK #1 › Isomorphic Strings
    Submitted by: Mohammad S Anwar
    You are given two strings $A and $B.
    
    Write a script to check if the given strings are Isomorphic. Print 1 if they are otherwise 0.
    
        Example 1:
        Input: $A = "abc"; $B = "xyz"
        Output: 1
        Example 2:
        Input: $A = "abb"; $B = "xyy"
        Output: 1
        Example 3:
        Input: $A = "sum"; $B = "add"
        Output: 0
=end
=cut


use strict;
use warnings;
use Data::Dumper;

my $A = "abc"; 
my $B = "xyz";
my %hash;
my @sets;
my $C1;
my $C2;

#Convert into arrays
my @arrayA = split(//, $A);
my @arrayB = split(//, $B);

foreach (my $i=0; $i<@arrayA; $i++) {
    $C1 = $arrayA[$i];
    $C2 = $arrayB[$i];
    checkHash();
}

print "Output: 1\n";

sub addIntoHash {
    $hash{$C1} = $C2;
}

sub checkHash {
    if(!exists $hash{$C1}) {
        if(grep $_ eq $C2, @sets) {
            print "Output: 0\n";
            exit;
        }
        else {
            push @sets, $C2;
            addIntoHash();
        }
    }
    elsif ($hash{$C1} eq $C2) {
        addIntoHash();
    }
    else {
        print "Output: 0\n";
        exit;
    }
}






