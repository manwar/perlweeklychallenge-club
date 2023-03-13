#!/usr/bin/env python
# -*- coding: utf-8 -*-


def jaro_winkler_distance(s1, s2, p=0.1):
    # Calculate the Jaro distance
    m = 0
    s1_len = len(s1)
    s2_len = len(s2)
    match_distance = max(s1_len, s2_len) // 2 - 1
    s1_matches = [False] * s1_len
    s2_matches = [False] * s2_len
    for i in range(s1_len):
        start = max(0, i - match_distance)
        end = min(i + match_distance + 1, s2_len)
        for j in range(start, end):
            if s2_matches[j]:
                continue
            if s1[i] != s2[j]:
                continue
            s1_matches[i] = True
            s2_matches[j] = True
            m += 1
            break
    if m == 0:
        return 0.0
    transpositions = 0
    j = 0
    for i in range(s1_len):
        if not s1_matches[i]:
            continue
        while not s2_matches[j]:
            j += 1
        if s1[i] != s2[j]:
            transpositions += 1
        j += 1
    jaro_distance = (m / s1_len + m / s2_len + (m - transpositions / 2) / m) / 3

    # Calculate the Jaro-Winkler distance
    l = 0
    for i in range(min(s1_len, s2_len)):
        if s1[i] != s2[i]:
            break
        l += 1
    jaro_winkler_distance = jaro_distance + l * p * (1 - jaro_distance)
    return jaro_winkler_distance


# Test the function
s1 = "MARTHA"
s2 = "MARHTA"
distance = jaro_winkler_distance(s1, s2)
print(f"Jaro-Winkler distance between '{s1}' and '{s2}' is {distance}")
