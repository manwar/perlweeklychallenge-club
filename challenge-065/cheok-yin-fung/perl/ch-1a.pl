#!/usr/bin/perl
use strict;

my $N;
my $S;

if ($ARGV[0] and $ARGV[1]) {
    $N = $ARGV[0];
    $S = $ARGV[1];
}
else {  #example
    $N = 2;   
    $S = 4;
}

sub boofoo {
    my $dSum = $_[0];
    my $dNumber = $_[1];
    my $start = $_[2];    #  $start = 1 if $tf == 1
    my $tf = $_[3];
    my @ans = ();
    $start = 0 if $start < 0;  #line added after official deadline
    my $end = ($dSum >= 9 ? 9 : $dSum );
    if ($dNumber > 1) {
        for my $lfs ($start..$end) {  # lfs , shorthand for largest sig fig
            for my $baby 
              (boofoo($dSum-$lfs, $dNumber-1, int ($dSum-$lfs-1)/9, 0)){ 
                                                     # -1 is the key
                push @ans, $lfs.$baby;
            }
        }
    } 
    else {
        push @ans, ($dSum != 0 ? $dSum : "0") if $dSum<10; 
        #if condition of above line has been added after official deadline
   }
    
    return @ans;
}


if ($N*9 < $S ) {
    print "\n";
} 
else {
    my @result = boofoo($S,$N,1, 1);
    print join "\n", @result;
    print "\n";
}
