#!/usr/bin/python3

import copy
import re

def main():
    examples = []
    examples.append( [ 2, 2, 2, 2 ] )
    examples.append( [ 1, 2, 2, 2, 1 ] )
    examples.append( [ 2, 2, 2, 4 ] )
    examples.append( [ 2, 2, 2, 2, 4 ] )
    examples.append( [ 3, 4, 1, 4, 3, 1 ] )
    examples.append( [ 1, 1, 1, 1, 1, 5, 2, 3, 4, 1 ] )
    examples.append( [ 2, 3, 2, 3, 4, 1, 4, 1 ] )
    for e in examples:
        output = matchstick_square(e)
        input = ', '.join(str(i) for i in e)
        print(f'Input:  input = [{input}]')
        print(f'Output:         "{output}"')
        print("")

def matchstick_square( sticks, board=[[],[],[],[]], side=0 ):
    if ( side > 3 ):
        summed = [sum(l) for l in board]
        if summed[0] == summed[1] and summed[0] == summed[2] and summed[0] == summed[3] and 0 == len(sticks):
            return True
        return False


    output = []
    sticks_copy = sticks.copy()
    sticks_len = len(sticks_copy)
    for i in range(0,sticks_len):
        if any(output):
            return True
        board_copy = copy.deepcopy(board)
        stick = sticks_copy.pop(0)
        board_copy[side].append(stick)
        if side == 0:
            output.append( matchstick_square( sticks_copy, board_copy, side ) )
            output.append( matchstick_square( sticks_copy, board_copy, side + 1 ) )
        if sum(board_copy[side]) == sum(board_copy[0]):
            output.append( matchstick_square( sticks_copy, board_copy, side + 1 ) )
        if sum(board_copy[side]) < sum(board_copy[0]):
            output.append( matchstick_square( sticks_copy, board_copy, side ) )
        sticks_copy.append(stick)
    return any(output)

# sub matchstick_square( $sticks, $board = [], $side = 0 ) {
#     if ( $side > 3 ) {
#         my @summed = map { sum0( $_->@* ) } $board->@*;
#         if (   $summed[0] == $summed[1]
#             && $summed[0] == $summed[2]
#             && $summed[0] == $summed[3]
#             && !scalar $sticks->@* )
#         {
#             return 'true';
#         }
#         return 'false';
#     }
#     my @output;
#     my @sticks = $sticks->@*;
#     for my $i ( 0 .. -1 + scalar @sticks ) {
#         my $stick = shift @sticks;
#         my @board = map { [@$_] } $board->@*;
#         push $board[$side]->@*, $stick;
#         if ( $side == 0 ) {
#             push @output, matchstick_square( \@sticks, \@board, $side + 1 );
#         }
#         elsif ( sum0( $board[$side] ) >= sum0( $board[0] ) ) {
#             push @output, matchstick_square( \@sticks, \@board, $side + 1 );
#         }
#         else {
#             push @output, matchstick_square( \@sticks, \@board, $side );
#         }
#         push @sticks, $stick;
#     }
#     if ( any { /true/mix } @output ) {
#         return 'true';
#     }
#     return 'false';
# }


if __name__ == '__main__':
    main()
