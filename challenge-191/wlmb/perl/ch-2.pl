#!/usr/bin/env perl
# Perl weekly challenge 191
# Task 2:  Cute List
#
# See https://wlmb.github.io/2022/11/15/PWC191/#task-2-cute-list
use v5.36;
use Algorithm::Combinatorics qw(permutations);
use List::Util qw(all);

sub cute($o){ # check @$o is a cute sequence
    my @o=@$o;
    return all {$o[$_-1]%$_==0||$_%$o[$_-1]==0} 1..@o;
}

die << "EOF" unless @ARGV;
Usage: $0 N1 [N2...]
to count the cute orderings of 1..Ni
EOF
die "Only numbers in the range 1..15 are allowed" unless all {1<=$_<=15} @ARGV;
for(@ARGV){
    my $iter=permutations[1..$_];
    my $count=0;
    my $o;
    cute($o) && ++$count while $o=$iter->next;
    say "$_ -> $count";
}
