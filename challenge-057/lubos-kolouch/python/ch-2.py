#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def shortest_unique_prefixes(words: List[str]) -> List[str]:
    result = []

    for word in words:
        prefix = ""
        for char in word:
            prefix += char
            if not any(res.startswith(prefix) for res in result):
                result.append(prefix)
                break

    return result

if __name__ == "__main__":
    input_list = ["alphabet", "book", "carpet", "cadmium", "cadeau", "alpine"]
    result = shortest_unique_prefixes(input_list)

    print(result)
