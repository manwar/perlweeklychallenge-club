#!/usr/bin/env perl6
# 
#
#       change_is_gonna_come.raku
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
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ($S = 27, *@coins) ;

# cfg
@coins = (2,5,10,25) if @coins.elems == 0;
@coins .= sort( { $^a <=> $^b } );
my @solutions;

# work
get_coin_groups($S);

# out
print_output(@solutions);

## ## ## ## ##

sub get_coin_groups ($amt, @group = [], @bag = @coins) {

    ## base case, cashed out
    $amt == 0 and return @solutions.push: @group;

    ## limit coin bag to those smaller or equal to the current amount
    my @coin_bag = @bag.grep: { $_ <= $amt } ;
    
    ## edge case, cannot complete group with remaining coins
    @coin_bag == 0 and return;

    for @coin_bag -> $coin {
        ## limit coin bag to this coin or smaller than this coin
        ## keeps groups ordered and disallows duplicate rearrangements
        my @smaller_coin_bag = @bag.grep: { $_ <= $coin } ;
        get_coin_groups( $amt - $coin, ( |@group, $coin ) , @smaller_coin_bag );
    }
}

sub print_output ($output) {
    my $count = $output.elems;
    
    say "Input:\n    \@C = ", @coins;
    say "    \$S = $S\n";
    say "Output: $count";
    say $count == 1 
        ?? "There is one possible way to make sum $S"
        !! "There are $count ways to make sum $S";
        
    
    my @letter_prefixes = |('a'..'z'), |('aa'..'zz');
    say "\t", @letter_prefixes.shift, ') ', $_ for @solutions;

}


