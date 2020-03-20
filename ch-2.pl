#!/usr/bin/perl
use strict;
# I will use array implementation for the binary tree, 
# see https://en.wikipedia.org/wiki/Binary_tree#Arrays
# Usage: ch-2.pl LIST, 
# example: "ch-2.pl 2 5 3 1" returns first player wins

sub jumptoLc {
    return $_ * 2 + 1;
}

sub jumptoRc {
    return $_ * 2 + 2;
}


my $Plist;
$Plist->[0] = \@ARGV;

my $size = $#{$Plist->[0]}+1;

my @Pvaluef = (0);
my @Pvalues = (0);
my @Pdecision = (); # 'takesL' or 'takesR'
# type of P: 
#'N' for intermediate nodes, 'R' for the root, 'E' for end nodes
# type[0] = 'R';
# type[1.. or 2**($size-1)-1] = 'N';
# type[2**($size-1) .. or 2**$size-1] = 'E';

sub takesL {
    $Pdecision[$_] = 'takesL';
    $Pvaluef[$_] = $Pvaluef[jumptoLc $_];
    $Pvalues[$_] = $Pvalues[jumptoLc $_]; 
}

sub takesR {
    $Pdecision[$_] = 'takesR';
    $Pvaluef[$_] = $Pvaluef[jumptoRc $_];
    $Pvalues[$_] = $Pvalues[jumptoRc $_]; 
}

foreach (0..2**($size-1)-1) {

    my $side_sign = $#{$Plist->[$_]}+1;  
    
    my @temp0 = @{$Plist->[$_]};
    my $v0 = pop @temp0; 
    if ( ($side_sign-$size) % 2 == 0) {
        $Pvaluef[jumptoLc $_] = $v0 + $Pvaluef[$_]; 
        $Pvalues[jumptoLc $_] = $Pvalues[$_]; 
    } else {
        $Pvalues[jumptoLc $_] = $v0 + $Pvalues[$_];
        $Pvaluef[jumptoLc $_] = $Pvaluef[$_]; 
    }

    $Plist->[jumptoLc $_] = \@temp0; 


    my @temp1 = @{$Plist->[$_]};
    my $v1 = shift @temp1;    
    if (($side_sign-$size) % 2 == 0) {
        $Pvaluef[jumptoRc $_] = $v1 + $Pvaluef[$_]; 
        $Pvalues[jumptoRc $_] = $Pvalues[$_]; 
    } else {
        $Pvalues[jumptoRc $_] = $v1 + $Pvalues[$_] ;
        $Pvaluef[jumptoRc $_] = $Pvaluef[$_]; 
    }
    
    $Plist->[jumptoRc $_] = \@temp1; 
}

#the followings are for the end nodes
foreach (2**($size-1) .. 2**$size-1) {
    if ($size % 2 == 0) {
        $Pvalues[$_] += $Plist->[$_][0];
    } else {
        $Pvaluef[$_] += $Plist->[$_][0];
    } 
}

# backward induction of the game tree
foreach (reverse 0..2**($size-1)-1 ) {
    my $side_sign = $#{$Plist->[$_]}+1;
    if ($Pvaluef[jumptoLc $_]-$Pvalues[jumptoLc $_] >=
        $Pvaluef[jumptoRc $_]-$Pvalues[jumptoRc $_]    )  {
        if ( ($side_sign-$size) % 2 == 0) {
            takesL $_;
        } else { 
            takesR $_;
        }
    } elsif ( ($side_sign-$size) % 2 == 0) {
            takesR $_;
        } else {
            takesL $_;
        }
}

print "Optimal Play Diff: ".($Pvaluef[0]-$Pvalues[0])."\n";

if ($Pvaluef[0]-$Pvalues[0] > 0) {
    print "First player wins."
} elsif ($Pvaluef[0]==$Pvalues[0]) {
    print "Draw.";
} else {
    print "Second player wins.";
}
