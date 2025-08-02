#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List, Set, Tuple
import re


def load_grid(file_path: str) -> List[List[str]]:
    """Load the word search grid from a file."""
    with open(file_path, "r") as file:
        grid = [list(line.strip().upper()) for line in file]
    return grid


def load_words(file_path: str) -> Set[str]:
    """Load the list of words from a file."""
    with open(file_path, "r") as file:
        words = {line.strip().upper() for line in file}
    return words


def find_words_in_grid(grid: List[List[str]], words: Set[str]) -> Set[str]:
    """Find all words in the grid."""
    found_words = set()
    rows, cols = len(grid), len(grid[0])
    directions = [
        (dx, dy)
        for dx in range(-1, 2)
        for dy in range(-1, 2)
        if not (dx == 0 and dy == 0)
    ]

    def word_at_position(x: int, y: int, dx: int, dy: int) -> str:
        """Generate a word starting at (x, y) in direction (dx, dy)."""
        word = ""
        while 0 <= x < rows and 0 <= y < cols:
            word += grid[x][y]
            if word in words:
                found_words.add(word)
            x, y = x + dx, y + dy

    for row in range(rows):
        for col in range(cols):
            for dx, dy in directions:
                word_at_position(row, col, dx, dy)

    return found_words


# Example usage
grid_file = "grid.txt"  # Replace with actual file path
words_file = "words.txt"  # Replace with actual file path

grid = load_grid(grid_file)
words = load_words(words_file)
found_words = find_words_in_grid(grid, words)

print(f"Found {len(found_words)} words:", found_words)
