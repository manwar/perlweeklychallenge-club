#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List, Tuple


def merge_intervals(intervals: List[Tuple[int, int]]) -> List[Tuple[int, int]]:
    intervals.sort(key=lambda x: x[0])

    merged_intervals = []
    current_interval = intervals[0]

    for interval in intervals[1:]:
        if current_interval[1] >= interval[0]:
            current_interval = (current_interval[0],
                                max(current_interval[1], interval[1]))
        else:
            merged_intervals.append(current_interval)
            current_interval = interval

    merged_intervals.append(current_interval)

    return merged_intervals


if __name__ == "__main__":
    intervals = [
        (2, 7),
        (3, 9),
        (10, 12),
        (15, 19),
        (18, 22),
    ]

    merged_intervals = merge_intervals(intervals)
    print("Merged intervals:", merged_intervals)
