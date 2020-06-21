#!/usr/bin/perl
use strict;
use List::Util qw/sum/;

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


sub digitsum {
    my $candidate = $_[0];
    my @digits = split //, $candidate;
    return sum @digits;
}

sub is {
    my $candidate = $_[0];
    return 1 if $S == digitsum $candidate;
    return 0; #return false
}

my $start = 10**($N-1);
my $end = 10**$N - 1;

for ($start..$end) {
    print $_,"\n" if is($_);
}
