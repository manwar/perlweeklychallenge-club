#!/usr/bin/perl
# The Weekly Challenge - Perl & Raku
#          #077 Task 1 Fibonacci Sum
# task statement: 
# Write a script to find how many ways you make 
# sum $S from the Fibb numbers.
# You are NOT allowed to repeat a number. 
# Print 0 if none found. 
# 
# Usage: ch-1.pl $N
#
# Additional Usage: ch-1.pl $N -r  
#     for displaying terms from large to small
#
# verify code aided by this page by Dr Ron Knott:
# http://www.maths.surrey.ac.uk/hosted-sites/
# R.Knott/Fibonacci/fibrep.html#section3.2
use strict;
use warnings;

my $N;
if ($ARGV[0]) {$N = $ARGV[0];} else {$N = 1015;}

my @FIBSEQ = (1, 1);

sub generate_up_to_N {
    my $r = 1;
    while ($N > $FIBSEQ[$r]) {
        $FIBSEQ[$r+1] = $FIBSEQ[$r]+$FIBSEQ[$r-1];
        $r++;
    }
}

generate_up_to_N;

# Use Greedy Algorithm to get a first
#  Fibonacci number summation first
sub get_fibfundsum_index {
    my $target = $_[0];
    my @fans = ();
    my $s = $#FIBSEQ;
    while ($target != 0) {
        if ($target >= $FIBSEQ[$s]) {
            $target = $target - $FIBSEQ[$s];
            push @fans, $s;
        }
        $s--;
    }
    return @fans;
}

my @mainlist = ( [get_fibfundsum_index($N)] ); 

my %unique;       # avoid redundancy

# variable for the loop in subroutine fibsum
my $count = 1; 

#============================
# subrountines
#============================

# avoid redundancy instead of directly push
# also check if the loop modify the list of solutions 
sub is_it_new_discovery {
    if (not($unique{join",",@_})) {
        push @mainlist, [@_];
        $unique{join",",@_} = 1;
        $count++;
    }
}

# main dish
sub fibsum {
    while ($count > 0) {
        $count = 0;
        my @oldlist = @mainlist;
        my $size_of_oldlist = scalar @oldlist;
        for my $i (0..$size_of_oldlist-1) {
            for my $p (0..scalar @{$oldlist[$i]}) {
                expand( $p , $oldlist[$i] );
            } 
        }
    }
}

# turn a Fib num F_k into F_{k-1} + F_{k-2} 
#  if the latter two haven't appeared in the summation
sub expand {
    my $index = $_[0];
    my @arr = @{$_[1]};
  
    my @newarr = @arr;
    my $bool_expandable = undef;    

    if (defined($arr[$index+1])) {
        $bool_expandable = ($arr[$index] - $arr[$index+1] >= 3);
    }
    elsif ($index == $#arr) {
        $bool_expandable = ($arr[$index] >= 3);
    }

    while ($bool_expandable) {
        splice(@newarr, $index, 1,
               ($arr[$index]-1, $arr[$index]-2 ) ) ;
        is_it_new_discovery(@newarr);
        @arr = @newarr;
        $index = $index+1;
        $bool_expandable = ( ( $index == $#arr and $arr[$index] >= 3) or
                          ( defined($arr[$index+1]) 
                                  and ($arr[$index]-$arr[$index+1] >= 3)) );
    }

    my @recaddarray = @arr;
    $index = $index-3;
    if ( ($index >= 0)  && ($arr[$index]-$arr[$index+1] == 3)) {
        splice(@recaddarray, $index, 1,
               ( $arr[$index]-1, $arr[$index]-2 ) ) ;
        is_it_new_discovery(@recaddarray);
    }
}

#============================

fibsum;


print "number of summations: " , scalar @mainlist, "\n";
for my $array_k (@mainlist) {
    if ( defined($ARGV[1]) && ($ARGV[1] eq "-r") ) {
        print join " + ", map {$FIBSEQ[$_]} @{$array_k};
    }
    else {
        print join " + ", reverse map {$FIBSEQ[$_]} @{$array_k};
    }
    print " = $N\n";
}

