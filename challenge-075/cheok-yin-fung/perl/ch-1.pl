#!/usr/bin/perl
# Perl Weekly Challenge #075 Task 1 Coins Sum
# task statement: 
# You are given a set of coins @C, assuming you have 
# infinite amount of each coin in the set.
# Write a script to find how many ways you make 
# sum $S using the coins from the set @C.
# Usage: ch-1a.pl $S @C
use strict;
use warnings;
use Data::Dumper;
#use Test::More tests => 4;

my $S;
my @C;
if ($ARGV[1]) {$S = shift @ARGV; @C = @ARGV;} else {$S = 6; @C = (1,2,4);}


sub contain {
    my @small = @{ $_[0] };
    my $size_of_smaller_arr = scalar @small;
    my @set_of_partitions = @{ $_[1] }; 
    my $size_of_the_set_of_parts = scalar @set_of_partitions;
    my $index = 0;
    my $tf_found = undef;
    while ( not($tf_found) && ($index < $size_of_the_set_of_parts) ) {
        my @a_partition = @{ $set_of_partitions[$index] };
        my $k = 0;
        $tf_found = ( scalar @a_partition == scalar @a_partition ); 
        while ($tf_found && ($k < $size_of_smaller_arr)) {
            $tf_found = $tf_found && ($a_partition[$k] == $small[$k]);
            $k++;
        }
        $index++;
    }
    return $tf_found;
}

sub coins_sum {
    my $total = shift @_;
    my @coins = @_;
    my @EMPTYARR = [];
    my @arr_for_dp = ();

    # initialize the array for dynamic programming
    $arr_for_dp[0] = (@EMPTYARR);
    for my $i (1..$total) {
        @{$arr_for_dp[$i]} = ();
    }
    for my $coin_v (@coins) {
        push @{$arr_for_dp[$coin_v]}, [$coin_v] if $coin_v <= $total;  
        # the "if" condition avoids array overflow 
    }


    for my $i (1..$total) {
        for my $coin_v (@coins) {
            if ($i-$coin_v > 0) {
                for my $r (@{$arr_for_dp[$i-$coin_v]}) {
                    my @temp = @{$r};
                    push @temp, $coin_v;
                    @temp = sort {$a <=> $b } @temp;
                    if (!contain([@temp], $arr_for_dp[$i])) {
                        push @{$arr_for_dp[$i]}, [@temp] ;
                    }
                }
            }
        }
    }

    #print the combinations of coins
    for my $partition (@{$arr_for_dp[$total]}) {
        print join " ", @{$partition};
        print "\n";
    }

    print "\n";
    #return answer
    return scalar @{$arr_for_dp[$total]};
}

print "total number of ways: ", coins_sum($S, @C);
print "\n";

=pod
ok coins_sum(6, 1, 2, 4) == 6, "test 1";
ok coins_sum(5, 1, 2, 3, 5) == 6, "test 2";
ok coins_sum(5, 1, 2, 3, 4, 5) == 7, "test 3";
ok coins_sum(20, 1, 2, 4) == 36, "test 4";
=cut
