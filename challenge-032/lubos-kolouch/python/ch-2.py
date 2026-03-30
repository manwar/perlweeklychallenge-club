#!/usr/bin/env python3

"""
Challenge 032 - Task #2: ASCII Bar Chart
Contributed by Neil Bowers

Write a function that takes a hashref where the keys are labels and the
values are integer or floating point values. Generate a bar graph of the
data and display it to stdout.

The input could be something like:

$data = { apple => 3, cherry => 2, banana => 1 };
generate_bar_graph($data);
And would then generate something like this:

 apple | ############
cherry | ########
banana | ####
If you fancy then please try this as well: (a) the function could let you
specify whether the chart should be ordered by (1) the labels, or (2) the
values.
"""

import sys


def generate_bar_chart(data, sort_by="labels"):
    """
    Generate ASCII horizontal bar chart.

    Args:
        data: Dictionary with labels as keys, numeric values as values
        sort_by: Sort order - 'labels', 'values', or 'values_desc'
    """
    if not data:
        return

    # Find maximum label length for alignment
    max_length = max(len(str(key)) for key in data.keys())

    # Find maximum value for scaling
    max_value = max(data.values())

    # Determine sort order
    if sort_by == "values":
        sorted_items = sorted(data.items(), key=lambda x: x[1])
    elif sort_by == "values_desc":
        sorted_items = sorted(data.items(), key=lambda x: -x[1])
    else:  # default: sort by labels
        sorted_items = sorted(data.items(), key=lambda x: x[0])

    # Generate chart
    for key, value in sorted_items:
        bar_length = int((value / max_value) * 20)  # Scale to 20 chars max
        bar_length = max(1, bar_length)  # Minimum 1 hash

        # Right-align labels
        print(f"{key:>{max_length}} | {'#' * bar_length}")


def main():
    # Sample data - can be modified or read from input
    data = {
        "apple": 3,
        "cherry": 2,
        "banana": 1,
    }

    # Parse command line arguments
    sort_by = "labels"
    if len(sys.argv) > 1:
        arg = sys.argv[1]
        if arg.startswith("-sort="):
            sort_by = arg[6:]

    # Generate chart
    generate_bar_chart(data, sort_by)


if __name__ == "__main__":
    main()
