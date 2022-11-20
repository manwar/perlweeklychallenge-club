#!/usr/bin/env perl

use strict;
use warnings;

use Algorithm::Permute qw(permute);

print &cute_list(2),"\n"; #2

sub cute_list {
    my ($n)=@_;
    my @list=(1 .. $n);
    my $ctr=0;
    
    permute {
        for my $j (1 .. $n) {
            (( ($list[$j-1] % $j) == 0) || ( ($j % $list[$j-1]) == 0)) || last;
            ($j==$n) && ($ctr++);
        }   
    } @list;
    $ctr;
}

