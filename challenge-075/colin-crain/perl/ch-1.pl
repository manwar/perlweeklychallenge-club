#! /opt/local/bin/perl
#
#       change_is_gonna_come.pl
#
#         TASK #1 › Coins Sum
#             Submitted by: Mohammad S Anwar
#             You are given a set of coins @C, assuming you have infinite amount of each coin in the set.
# 
#             Write a script to find how many ways you make sum $S using the coins from the set @C.
# 
#         Example:
#         Input:
#             @C = (1, 2, 4)
#             $S = 6
# 
#         Output: 6
#             There are 6 possible ways to make sum 6.
#                 a) (1, 1, 1, 1, 1, 1)
#                 b) (1, 1, 1, 1, 2)
#                 c) (1, 1, 2, 2)
#                 d) (1, 1, 4)
#                 e) (2, 2, 2)
#                 f) (2, 4)
# 
#         method:
#             Recursive routine that diminishes the options available in the
#             coin bag as the total anount remaining decreases. Builds a
#             branching tree of coin groupings until no more coins can be used
#             or remaining amount to be tendered is 0.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

## in
my $S      = shift @ARGV // 27;
our @coins = sort { $a <=> $b} @ARGV;
@coins     = (2,5,10,25) if ! @ARGV;
our @solutions;

## work
get_coin_groups($S);

## out
print_output(\@solutions);

## ## ## ## ## SUBS:

sub get_coin_groups {
    my ($amt, $group, $bag) = @_;
    $group //= [];
    $bag     //= \@coins;
    
    ## base case, cashed out
    if ($amt == 0) {
        push @solutions, $group;
        return;
    }
    
    ## limit coin bag to those smaller or equal to the current amount
    my @coin_bag = grep { $_ <= $amt } $bag->@*;
    
    ## edge case, cannot complete group with remaining coins
    if (@coin_bag == 0) {
        return;
    }
    
    for my $coin ( @coin_bag ) {        
        ## limit coin bag to this coin or smaller
        ## keeps groups ordered and disallows duplicate rearrangements
        my @smaller_coin_bag = grep { $_ <= $coin } $bag->@*; 
        get_coin_groups( $amt - $coin, [@$group, $coin], \@smaller_coin_bag );
    }
}

sub print_output {
use Lingua::EN::Inflexion;
    my ($output, $sum ) = @_;
    my $count = scalar $output->@*;
    
    say<<"__EOD__";
Input:
    \@C = (@coins)
    \$S = $S
__EOD__
 
    say "Output: $count";
    my $str = inflect("<#d:$count>There <V:is> <#wnc:$count> possible <N:ways> to make the sum $S.");
    say $str;
    
    my @letter_prefixes = ('a'..'z', 'aa'..'zz');
    say "\t", shift @letter_prefixes, ')  (', (join ', ', $_->@*), ')' for @solutions;

}

