#!/usr/bin/env python3

"""
Challenge 032 - Task #1: Count Instances
Contributed by Neil Bowers

Create a script that either reads standard input or one or more files
specified on the command-line. Count the number of times and then print a
summary, sorted by the count of each entry.

So with the following input in file example.txt:

apple
banana
apple
cherry
cherry
apple
the script would display something like:

apple     3
cherry    2
banana    1
For extra credit, add a -csv option to your script, which would generate:

apple,3
banana,1
cherry,2
"""

import sys
import fileinput


def main():
    # Parse command line arguments
    csv_output = False
    args = sys.argv[1:]

    if args and args[0] == "-csv":
        csv_output = True
        args.pop(0)

    # Count instances
    count = {}

    # Read from files or STDIN
    with fileinput.input(files=args if args else ("-",)) as f:
        for line in f:
            word = line.strip()
            if word:
                count[word] = count.get(word, 0) + 1

    # Sort by count (descending), then alphabetically
    sorted_items = sorted(count.items(), key=lambda x: (-x[1], x[0]))

    # Output
    sep = "," if csv_output else "\t"
    for word, count in sorted_items:
        print(f"{word}{sep}{count}")


if __name__ == "__main__":
    main()
