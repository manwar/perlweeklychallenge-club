#!/usr/bin/perl
#
# Perl Weekly Challenge #069 Task 2
# Usage: ch-2.pl $N

# SN = SN-1 + “0” + switch(reverse(SN-1))
# SN = SN-2 + “0” + switch(reverse(SN-2)) + "0" + SN-2 + "1" + switch(reverse(SN-2))
# on my computer, ordinary action goes "out of memory" when $N>26.
# Therefore I write a roundabout to tackle $N=30


use strict;
use warnings;

my $N = 3;

if ($ARGV[0]) {
    $N = $ARGV[0];
}

sub sr {
    my @digits = split // , $_[0]; 
    my @newdigits;
    for (@digits) {
        unshift @newdigits, (1+$_) % 2;
    }
    return join "", @newdigits;
}


my @S = ("", "0");
my @R;

for (my $d = $N % 2 + 2; $d <= $N and $d<=26 ; $d += 2) {
    $R[$d-2] = sr($S[$d-2]);
    $S[$d] = $S[$d-2] . "0" . $R[$d-2]. "0" . $S[$d-2]. "1". $R[$d-2];
}

if ($N <= 26) {
    print $S[$N];
} elsif ($N !=30) {
    print "too large!";
}

print "\n";


#the following are for $N=30

#   $S[$d] = $S[$d-2] . "0" . $R[$d-2]. "0" . $S[$d-2]. "1". $R[$d-2];
#   $R[$d] = $S[$d-2] . "0" . $R[$d-2]. "1" . $S[$d-2]. "1". $R[$d-2];
sub print_S28 {
    print $S[26];
    print "0";
    print $R[26];
    print "0";
    print $S[26];
    print "1";
    print $R[26];
}

sub print_R28 {
    print $S[26];
    print "0";
    print $R[26];
    print "1";
    print $S[26];
    print "1";
    print $R[26];
}
if ($N == 30) {
    $R[26] = $S[24]."0".$R[24]."1".$S[24]."1".$R[24];
    print_S28;
    print "0";
    print_R28;
    print "0";
    print_S28;
    print "1";
    print_R28;
    
} 
print "\n";


# $N = 25 -->
# real	0m7.241s
# user	0m3.701s
# sys	0m0.681s
#
#
#$ perl ch-2.pl 7
#0010011000110110001001110011011000100110001101110010011100110110001001100011011000100111001101110010011000110111001001110011011

# $ time perl ch-2.pl 26 > S26.txt
# 
# real	0m8.045s
# user	0m7.172s
# sys	0m0.863s

#$ time perl ch-2.pl 30 > S30.txt
#
# real	0m12.099s
# user	0m7.873s
# sys	0m1.432s
# 
# size of S26.txt : 67.1 MB
# size of S30.txt :  1.1 GB
