#!/usr/bin/perl
#
# Perl Weekly Challenge #071 Task 1 Peak Elements
#
# Usage: ch-1.pl $N

use strict;
use warnings;

my $N;
my @seq = ();
my @peak_eles = ();
my %unique = ();  #edited on 13th Aug

if ($ARGV[0]) {$N = $ARGV[0];} else {$N = 10;}



while ($#seq < $N-1) {  #edited on 13th Aug
    my $a = 1+int(rand(50));
    push @seq, $a unless exists $unique{$a} ; 
    $unique{ $a } = 1;
    #  notes on 10min before deadline: I forgot to implement the uniqueness
    #  requirement until I saw laurent_r's blog.
    #  Therefore, The code of generating the close to his.
}

sub checkpeak_inside {
    my $p = $_[0];
    if ($seq[$p-1] < $seq[$p] and $seq[$p+1] < $seq[$p]) {
        push @peak_eles, $seq[$p];
    }
}

if ($seq[0]>$seq[1]) {push @peak_eles, $seq[0];} #edited on 13th Aug

for (1..$#seq-1) {
    checkpeak_inside($_);
}

if ($seq[-1]>$seq[-2]) {push @peak_eles, $seq[-1];} #edited on 13th Aug

print "Array: [ ", join ", ", @seq;
print "]\n";
print "Peak: [ ", join ", ", @peak_eles;
print "]\n";
