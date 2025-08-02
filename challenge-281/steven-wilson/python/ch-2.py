#!/usr/bin/env python3

from collections import deque


def knights_move(start, end):
    """ A Knight in chess can move from its current position to any square two
    rows or columns plus one column or row away.  Take a starting position and
    an ending position and calculate the least number of moves required.

    >>> knights_move('g2', 'a8') # g2 -> e3 -> d5 -> c7 -> a8
    4
    >>> knights_move('g2', 'h2') # g2 -> e3 -> f1 -> h2
    3
    """
    start_p = (ord(start[0]) - 96, int(start[1]))
    end_p = (ord(end[0]) - 96, int(end[1]))
    queue = deque([start_p])
    visited = {start_p}
    number_moves = 0
    while queue:
        for _ in range(len(queue)):
            current = queue.popleft()

            if current == end_p:
                return number_moves

            for position in possible_moves(current):
                if position not in visited:
                    visited.add(position)
                    queue.append(position)
        number_moves += 1
    return -1


def possible_moves(position):
    '''
    Return all possible knight moves within the board from a position

    >>> possible_moves((4, 4))
    [(6, 5), (5, 6), (3, 6), (2, 5), (2, 3), (3, 2), (5, 2), (6, 3)]
    >>> possible_moves((1, 1))
    [(3, 2), (2, 3)]
    '''
    moves = ([2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, -2],
             [2, -1])
    return [(position[0] + move[0], position[1] + move[1])
            for move in moves
            if (position[0] + move[0]) in range(1, 9)
            and (position[1] + move[1]) in range(1, 9)]


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
