#!/usr/bin/env python3

import re
import sys


def replace_words(words: list[str], sentence: str) -> str:
    regexp = r"(?<![a-z])(" + "|".join(map(re.escape, words)) + r")([a-z]*(?:'[a-z]+)?)"
    return re.sub(regexp, r'\1', sentence)


def main():
    words = sys.argv[1:]
    sentence = words.pop()
    result = replace_words(words, sentence)
    print(result)


if __name__ == '__main__':
    main()
