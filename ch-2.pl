#!/usr/bin/perl
# Perl Weekly Challenge #054 Task 2
# Usage: ch-2.pl [TARGET_BEGIN] [TARGET_END]
# It creates a file "ch-2_logfile" saving the seqence length.
# (recommend setting:)
# while TARGET_BEGIN <=1 , TARGET_END <= 200_000
use strict;
use integer;

my $MAX_U = 134217728; #(2^27)
if ($ARGV[0] == undef or $ARGV[1] == undef) {
    die "not enough arguments";
}

my $TARGET_BEGIN = $ARGV[0];
my $TARGET_END = $ARGV[1];  

open LOG, ">", "logfile";   # Use for the extra credit

#BEGIN: space allocation, Use for the extra credit
my @seqlength ;#= (undef) x (100000+1); 
my @indexT ;#= (undef) x ($MAX_U+1);     
#END
my %SeqlengthLargeInt;



$seqlength[1] = 1;
$indexT[1] = 0; 

foreach (1..27) {
    $seqlength[2**$_] = 1+$_; 
    $indexT[2**$_] = $_; 
}

foreach ($TARGET_BEGIN..$TARGET_END) {
    my @temp;
    push @temp, $_;
    my $mazed = $_;
    while( not(defined($indexT[$mazed])) 
                 and $mazed<$MAX_U 
    ) {
        if ($mazed % 2 == 1) {
           $mazed = $mazed*3+1;
           push @temp, $mazed;
        } else {
            $mazed = $mazed/2;
            push @temp, $mazed;
        } 
    }
    if ($mazed<$MAX_U) {
        #if the mazed person doesn't go far from $MAX_U
        traceSmallint(@temp);
        printing($_); #EXCLUDE when for extra credit
        print "\n"; #EXCLUDE when for extra credit
    } else { #Use for the extra credit
        my @tempB;
        push @tempB, $mazed;
        while ($mazed != 1 and
            not(defined($SeqlengthLargeInt{$mazed})) 
        ) {
            if ($mazed % 2 == 1) {
                $mazed = $mazed*3+1;
                push @tempB, $mazed;
            } else {
                $mazed = $mazed/2;
                push @tempB, $mazed;
            }    
        }
        if ($mazed == 1) {       
            $seqlength[$_] = $#tempB + $#temp + 1;
        } else {
            $seqlength[$_] = $#tempB + $#temp + $SeqlengthLargeInt{$mazed};
        }
        $SeqlengthLargeInt{$_} = $seqlength[$_];
        printing($_);  #EXCLUDE when for extra credit
    }

    print LOG $seqlength[$_], "\n";          # Use for the extra credit
}


sub printing {
    my $mazed = $_; 
    print $mazed, " ";
    while ($mazed != 1) {
        if ($mazed % 2 == 1) {
            $mazed = $mazed*3+1;
        } else {
            $mazed = $mazed/2;
            } 
        print $mazed, " ";
        }
}

sub traceSmallint {
    my @route = reverse @_;

    my $treeid = $indexT[$route[0]];

    my $h = shift @route;
    my $ref;
    foreach $ref (@route) {
        $indexT[$ref] = $treeid;
        $seqlength[$ref] = 1 + $seqlength[$h]; 

        $h = $ref;
    }
    $SeqlengthLargeInt{$route[0]} = $seqlength[$route[0]];
}
        

close LOG;     # Use for the extra credit
# My laptop spent roughly 40.5 hours 
# (from 02nd Apr 14:30 to 04th Apr 06:53)
# for getting the 
# sequence length(s) for N = 1 to 1e6 .
# This version optimzed and skip some unsuccessful 
# functionalities, but probably not more than 15%.
# For the unsuccessful functionalities, refer to the blog
# http://blogs.perl.org/users/c_y_fung/2020/03
