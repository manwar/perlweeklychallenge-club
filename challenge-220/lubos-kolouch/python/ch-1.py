#!/usr/bin/env python
# -*- coding: utf-8 -*-

def common_chars(words):
    common = set(words[0].lower())
    for word in words[1:]:
        common &= set(word.lower())
    return sorted(list(common))


# Test Cases
print(common_chars(["Perl", "Rust", "Raku"]))  # ['r']
print(common_chars(["love", "live", "leave"]))  # ['e', 'l', 'v']
