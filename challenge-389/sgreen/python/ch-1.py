#!/usr/bin/env python3

"""Simon's solution to task 1 of The Weekly Challenge"""

import re
import sys


def reorder_notes(composer: str, notes: list[str], positions: list[int]) -> str:
    """
    Reconstruct the melody by using each permutation value as the destination
    position of the corresponding note. Use no explicit for, foreach, or
    while loops.

    Input:
        composer (str): The name of the composer
        notes (list[str]): The notes the composer used
        position (list[int]): The destination position of the corresponding note

    Returns:
        str: The composer name in upper case and the notes in the correct order
    """
    # Validate input
    if len(notes) != len(positions):
        raise ValueError("The two lists must be the same length")
    if list(filter(lambda note: not re.search("^[A-G][♯♭#b]?$", note), notes)):
        raise ValueError("Invalid note")
    if list(filter(lambda i: i not in positions, range(1, len(positions) + 1))):
        raise ValueError("Missing position")

    # Turn a dict of position and note
    music = dict(zip(positions, notes))

    # Sort the notes by their position and return the required string
    ordered_music = list(map(lambda note: music[note], sorted(music)))
    return composer.upper() + " => " + " ".join(ordered_music)


def main():
    """Convert command line input into parameters for the function and display result"""
    split_pos = len(sys.argv) // 2 + 1
    composer = sys.argv[1]
    notes = sys.argv[2:split_pos]
    position = list(map(int, sys.argv[split_pos:]))
    result = reorder_notes(composer, notes, position)
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
