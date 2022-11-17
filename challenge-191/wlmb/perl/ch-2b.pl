#!/usr/bin/env perl
# Perl weekly challenge 191
# Task 2:  Cute List. Throw duplicates early.
#
# See https://wlmb.github.io/2022/11/14/PWC191/#task-2-cute-list
use v5.36;
use Set::CrossProduct;
use List::Util qw(all reduce);
sub cute($n){ # generate all cute sequences of length $n
    my @sets;
    for my $position(0..$n-1){
        for(1..$n){ # Build sets of divisors and multiples of $position+1
            push @{$sets[$position]}, $_ if ($position+1)%$_==0 || $_%($position+1)==0;
        }
    }
    my $x=reduce {cute_aux($a, $b)} [[]], @sets; # combine sets into cute sequences
    return $x;
}
sub cute_aux($seqs, $nums){ # combine an ongoing set of cute sequences with a set of numbers
    my $iter=Set::CrossProduct->new([$seqs, $nums]);
    my @combined;
    while(my $tuple=$iter->get){ # Cartesian product of a sequence and a number
        my @array=@{$tuple->[0]};
        my $num=$tuple->[1];
        my @seen;
        map {$seen[$_]=1} @array; # Seen numbers
        next if $seen[$num]; # Throw away repetitions
        push @array, $num; # add number to current sequence
        push @combined, [@array]; # add sequence to set of ongoing sequences
    }
    return [@combined];
}
die << "EOF" unless @ARGV;
Usage: $0 N1 [N2...]
to count the cute orderings of 1..Ni
EOF
die "Only numbers in the range 1..18 are allowed" unless all {1<=$_<=18} @ARGV;
say "$_ -> ", scalar @{cute($_)} for(@ARGV);
