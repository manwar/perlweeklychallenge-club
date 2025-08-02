import re
from collections import deque
from typing import Dict, Set, Tuple, List


def eliminate(board: str) -> str:
    """
    Eliminates consecutive groups of three or more identical balls from the board.
    Repeats the process until no more eliminations can occur.

    Args:
        board (str): The current state of the board.

    Returns:
        str: The board after all possible eliminations.
    """
    pattern = re.compile(r'(.)\1{2,}')
    changed = True
    while changed:
        # Substitute sequences of 3 or more identical balls with an empty string
        board, num_subs = pattern.subn('', board)
        changed = num_subs > 0
    return board


def find_min_steps(board: str, hand: str) -> int:
    """
    Finds the minimum number of balls to insert into the board to clear it, using the balls in hand.

    Args:
        board (str): The initial state of the board.
        hand (str): The balls available to insert.

    Returns:
        int: The minimum number of insertions needed to clear the board, or -1 if impossible.
    """
    # Initialize hand counts
    hand_counts: Dict[str, int] = {}
    for c in hand:
        hand_counts[c] = hand_counts.get(c, 0) + 1

    # Initialize queue for BFS
    queue: deque[Tuple[str, Dict[str, int], int]] = deque()
    queue.append((board, hand_counts.copy(), 0))

    # Visited states
    visited: Set[Tuple[str, Tuple[Tuple[str, int], ...]]] = set()

    while queue:
        current_board, current_hand, steps = queue.popleft()

        # If the board is empty, return the number of steps
        if not current_board:
            return steps

        # Generate a unique key for the current state
        # Using tuple of sorted items in current_hand for hashability
        hand_key = tuple(sorted(current_hand.items()))
        state_key = (current_board, hand_key)

        # Skip if we've already visited this state
        if state_key in visited:
            continue
        visited.add(state_key)

        # Try inserting each ball in hand at each position
        for i in range(len(current_board) + 1):
            for color in current_hand.keys():
                if current_hand[color] == 0:
                    continue

                # Insert the ball
                new_board = current_board[:i] + color + current_board[i:]

                # Eliminate balls
                new_board = eliminate(new_board)

                # Decrease the hand count
                new_hand = current_hand.copy()
                new_hand[color] -= 1
                if new_hand[color] == 0:
                    del new_hand[color]

                # Prepare the new state
                new_steps = steps + 1

                # Generate a unique key for the new state
                new_hand_key = tuple(sorted(new_hand.items()))
                new_state_key = (new_board, new_hand_key)

                # Skip if we've already visited this state
                if new_state_key in visited:
                    continue

                # Enqueue the new state
                queue.append((new_board, new_hand, new_steps))

    # If we cannot clear the board
    return -1


if __name__ == "__main__":
    # Test cases
    tests: List[Dict[str, any]] = [
        {
            'board': "WRRBBW",
            'hand': "RB",
            'expected': -1
        },
        {
            'board': "WWRRBBWW",
            'hand': "WRBRW",
            'expected': 2
        },
        {
            'board': "G",
            'hand': "GGGGG",
            'expected': 2
        },
        {
            'board': "RBYYBBRRB",
            'hand': "YRBGB",
            'expected': 3
        },
    ]

    for test in tests:
        result = find_min_steps(test['board'], test['hand'])
        print(f"Input: board = \"{test['board']}\", hand = \"{test['hand']}\"")
        print(f"Output: {result}")
        print(f"Expected: {test['expected']}")
        print("-" * 40)
