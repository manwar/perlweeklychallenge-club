#!/usr/bin/env perl
# Perl weekly challenge 191
# Task 2:  Cute List. Throw duplicates early.
#
# See https://wlmb.github.io/2022/11/14/PWC191/#task-2-cute-list
use v5.36;
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
    my @combined =
        map {
            my $seq=$_;
            map {
                my @seq=@$seq;
                my @seen;
                map {$seen[$_]=1} @seq;
                push @seq, $_;
                $seen[$_]?():[@seq]
            } @$nums
    }
    @$seqs;
    [@combined];
}
die << "EOF" unless @ARGV;
Usage: $0 N1 [N2...]
to count the cute orderings of 1..Ni
EOF
die "Only numbers in the range 1..18 are allowed" unless all {1<=$_<=18} @ARGV;
say "$_ -> ", scalar @{cute($_)} for(@ARGV);
