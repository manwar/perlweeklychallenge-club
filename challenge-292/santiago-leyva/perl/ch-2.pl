=begin
You are given a single row of colored balls, $row and a random number of colored balls in $hand.

Here is the variation of Zuma game as your goal is to clear all of the balls from the board. Pick any ball from your hand and insert it in between two balls in the row or on either end of the row. If there is a group of three or more consecutive balls of the same color then remove the group of balls from the board. If there are no more balls on the board then you win the game. Repeat this process until you either win or do not have any more balls in your hand.

Write a script to minimum number of balls you have to insert to clear all the balls from the board. If you cannot clear all the balls from the board using the balls in your hand, return -1.

Example 1
Input: $board = "WRRBBW", $hand = "RB"
Output: -1

It is impossible to clear all the balls. The best you can do is:
- Insert 'R' so the board becomes WRRRBBW. WRRRBBW -> WBBW.
- Insert 'B' so the board becomes WBBBW. WBBBW -> WW.
There are still balls remaining on the board, and you are out of balls to insert.
Example 2
Input: $board = "WWRRBBWW", $hand = "WRBRW"
Output: 2

To make the board empty:
- Insert 'R' so the board becomes WWRRRBBWW. WWRRRBBWW -> WWBBWW.
- Insert 'B' so the board becomes WWBBBWW. WWBBBWW -> WWWW -> empty.
2 balls from your hand were needed to clear the board.
Example 3
Input: $board = "G", $hand = "GGGGG"
Output: 2

To make the board empty:
- Insert 'G' so the board becomes GG.
- Insert 'G' so the board becomes GGG. GGG -> empty.
2 balls from your hand were needed to clear the board.
=cut

use strict;
use warnings;
use Data::Dumper;

my @sets = (['WWRRRBBWW','WRBRW'],["WRRBBW","RB"]);
#my @sets = (["WRRBBW","RB"]);

foreach(@sets){
    my $balls_ = @$_[0];
    my $hand_ = @$_[1];
    my $needed = playZuma($balls_,$hand_);
    print "for $balls_ the balls needed were -> $needed\n";
}

sub playZuma {
    my ($balls,$hand) = @_;

    my @B = split("",$balls);
    print "balls : ",join("",@B),"\n";
    my %hand_set = setHand($hand);
    my $need = 0;
    #WWRRBBWW  // WRBRW
    #WRRBBW // RB -> WBBW // B -> WW
    while(scalar @B > 0){
        my $cur = $B[0];
        my $count = 1;
        for(my $i=1;$i<(scalar @B);$i++){
            if($B[$i] eq $cur){
                $count += 1;
                if($count == 2 and exists($hand_set{$cur})){ # assuming we can only insert one at a time
                    my $pos = $i - ($count-1);
                    splice(@B,$pos,$count);
                    print join("",@B)."\n";
                    $hand_set{$cur} -= 1;
                    delete $hand_set{$cur} if $hand_set{$cur} == 0;
                    $need += 1;
                    $i = $pos;
                }
            }else{
                $count = 1;
                $cur = $B[$i];
            }
        }
        if(scalar @B > 1 and !(%hand_set)){
            return -1;
        }
    }

    return $need;
    
}

sub setHand {
    my $input = shift;
    my @A = split("",$input);
    my %set;
    foreach(@A){
        if(exists($set{$_})){
            $set{$_} += 1;
        }else{
            $set{$_} = 1;
        }
    }

    return %set;
}
