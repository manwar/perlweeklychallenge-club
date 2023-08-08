#!/usr/bin/env python
# -*- coding: utf-8 -*-

from collections import Counter


def frequency_equalizer(s):
    # Count the frequency of each character in the string
    frequency = Counter(s)

    # Create a frequency histogram to track the count of each frequency
    frequency_histogram = Counter(frequency.values())

    # Check if there's only one frequency, and that removing one occurrence will not equalize frequencies
    if len(frequency_histogram) == 1 and list(frequency_histogram.values())[0] == 1:
        return 0

    # Check if there is one frequency that appears only once and the rest are the same
    unique_freq = [freq for freq,
                   count in frequency_histogram.items() if count == 1]
    if unique_freq:
        del frequency_histogram[unique_freq[0]]
        if len(frequency_histogram) == 1 and (unique_freq[0] == 1 or unique_freq[0] - 1 == list(frequency_histogram.keys())[0]):
            return 1

    return 0


# Test Cases
assert frequency_equalizer(
    'abbc') == 1, 'One character with frequency one more than others'
assert frequency_equalizer(
    'xyzyyxz') == 1, 'One character with frequency one more than others, mixed'
assert frequency_equalizer('xzxz') == 0, 'All characters with equal frequency'

print("All tests passed!")
