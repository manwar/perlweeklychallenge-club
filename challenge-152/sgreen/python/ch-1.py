#!/usr/bin/env python3

import sys
import json


def main(json_string):
    # Read the input
    triangle = json.loads(json_string)
    print(sum(map(lambda x: min(x), triangle)))


if __name__ == '__main__':
    main(sys.argv[1])
