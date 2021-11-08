#!/usr/bin/env raku
use v6;

# run as <script> <number $n> to return the first $n ugly numbers

my %memo=((1,2,3,5) X=> 1).Hash;

sub smth5p($n) { %memo{$n} && return True; return (my $den=(2,3,5).first({ $n %% $_ })) ?? (%memo{$n div $den} && (%memo{$n}=1).Bool || False) !! (False) }

my ($count,$nr)=(0,0);
while ($count < @*ARGS[0].Int) {
    $nr+=1;
    ($nr.&smth5p) && do { say $nr; $count+=1; };    
}
