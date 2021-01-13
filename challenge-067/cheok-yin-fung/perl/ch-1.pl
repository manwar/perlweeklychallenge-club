#!/usr/bin/perl
use strict;
use Data::Dumper;

# Usage:   ch-1.pl [m] [n (also size of the combinations)]
# Main Idea: use the combinatorical identity  C(n-1,r)+C(n-1,r-1)==C(n,r)

my $m = 5;
my $n = 2;
if ($ARGV[0] and $ARGV[1]) {
    $m = $ARGV[0];
    $n = $ARGV[1]; 
}

my @A =( [] , [[ []  ] ,[[1]]]  ,  [ [ []  ], [ [1],[2] ], [ [1,2] ]] );

#my $x = Data::Dumper->new(\@A);    # lines for testing
#print $x->Dump;
#print "\n";


my $i = 3;
my $csize;     #the size of the combination(s)

while ($i<=$m) {
    $A[$i][0] = [];
    my @tempA1 = map {[$_]} (1..$i);
    $A[$i][1] = \@tempA1;
    $csize = 2;
    while ($csize+1<=$i) {            
        my @temp0 = @{$A[$i-1][$csize]} ;
        my @temp1 = map{ [ @{$_}, ] } @temp0;      # C(n-1,r)
        my @temp2 = @{$A[$i-1][$csize-1]};         # C(n-1,r-1)
        push @temp1, map { [ @{$_} , $i] } @temp2; # addition   
        $A[$i][$csize] = \@temp1;
        $csize++;
    }
    $A[$i][$i] =[[1..$i]];
    $i++;
}

#$x = Data::Dumper->new(\@A);        # lines for testing
#print $x->Dump;                     # lines for testing

print "\$m = $m ; \$n = $n  \n";
print "\n";


my @temp = @{ $A[$m][$n] };
foreach my $arr (@temp) {
    print "[", join ",", @{$arr}; print "]";
    print "\n";
}

print "\n";
