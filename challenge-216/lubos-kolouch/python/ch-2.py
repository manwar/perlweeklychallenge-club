from collections import Counter
import sys


def min_stickers_needed(stickers, target):
    target_counts = Counter(target)
    stickers_counts = [Counter(sticker) for sticker in stickers]

    # Filter out stickers that don't have any characters in common with the target word
    filtered_stickers_counts = [
        sticker
        for sticker in stickers_counts
        if any(sticker[char] > 0 for char in target_counts)
    ]

    return min_stickers_helper(filtered_stickers_counts, target_counts, 0)


def min_stickers_helper(stickers_counts, target_counts, used_stickers):
    if not target_counts:
        return used_stickers

    min_stickers = sys.maxsize
    for sticker_counts in stickers_counts:
        # Try to fulfill the remaining character requirements of the target word
        new_target_counts = target_counts.copy()
        used_current_sticker = False
        for char, count in sticker_counts.items():
            if new_target_counts[char] > 0:
                new_target_counts[char] -= count
                if new_target_counts[char] <= 0:
                    del new_target_counts[char]
                used_current_sticker = True

        if used_current_sticker:
            min_stickers = min(
                min_stickers,
                min_stickers_helper(
                    stickers_counts, new_target_counts, used_stickers + 1
                ),
            )

    return min_stickers if min_stickers != sys.maxsize else 0


stickers = ["perl", "raku", "python"]
word = "peon"
print(min_stickers_needed(stickers, word))  # Output: 2

stickers = ["love", "hate", "angry"]
word = "goat"
print(min_stickers_needed(stickers, word))  # Output: 3

stickers = ["come", "nation", "delta"]
word = "accommodation"
print(min_stickers_needed(stickers, word))  # Output: 4

stickers = ["come", "country", "delta"]
word = "accommodation"
print(min_stickers_needed(stickers, word))  # Output: -1
