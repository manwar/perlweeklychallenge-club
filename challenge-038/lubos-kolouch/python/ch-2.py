#!/usr/bin/env python
# -*- coding: utf-8 -*-

import random

tiles = {
    "A": [1, 8],
    "G": [1, 3],
    "I": [1, 5],
    "S": [1, 7],
    "U": [1, 5],
    "X": [1, 2],
    "Z": [1, 5],
    "E": [2, 9],
    "J": [2, 3],
    "L": [2, 3],
    "R": [2, 3],
    "V": [2, 3],
    "Y": [2, 5],
    "F": [3, 3],
    "D": [3, 3],
    "P": [3, 5],
    "W": [3, 5],
    "B": [4, 5],
    "N": [4, 4],
    "T": [5, 5],
    "O": [5, 3],
    "H": [5, 3],
    "M": [5, 4],
    "C": [5, 4],
    "K": [10, 2],
    "Q": [10, 2],
}


def draw_tiles(num_tiles):
    tiles_drawn = []
    for i in range(num_tiles):
        tile = get_random_tile()
        tiles_drawn.append(tile)
    return tiles_drawn


def get_random_tile():
    total_tiles = sum([tiles[letter][1] for letter in tiles])
    rand_num = random.randint(1, total_tiles)
    for letter in tiles:
        if rand_num <= tiles[letter][1]:
            tiles[letter][1] -= 1
            return letter
        else:
            rand_num -= tiles[letter][1]


def get_word(hand):
    word = input("Enter a word using the tiles in your hand: ").upper()
    while not is_valid_word(word, hand):
        word = input("Invalid word. Try again: ").upper()
    return word


def is_valid_word(word, hand):
    hand_count = {}
    for tile in hand:
        if tile in hand_count:
            hand_count[tile] += 1
        else:
            hand_count[tile] = 1

    for char in word:
        if char in hand_count and hand_count[char] > 0:
            hand_count[char] -= 1
        else:
            return False

    return len(word) > 0


def calculate_score(word):
    score = 0
    for char in word:
        if char in tiles:
            score += tiles[char][0]
        else:
            raise ValueError(f"Invalid character in word: {char}")

    return score


hand = draw_tiles(7)
print(f"Your hand: {' '.join(hand)}")
word = get_word(hand)
score = calculate_score(word)
print(f"Your word: {word}")
print(f"Score: {score}")
