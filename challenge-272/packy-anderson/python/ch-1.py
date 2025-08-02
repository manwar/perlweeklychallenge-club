#!/usr/bin/env python

import re

def defang(ip):
    match = re.search(
        r'(\d+) [.] (\d+) [.] (\d+) [.] (\d+)',
        ip,
        re.X
    )
    return '[.]'.join(match.group(1,2,3,4))

def solution(ip):
    print(f'Input: $ip = "{ip}"')
    print(f'Output: "{defang(ip)}"')

print('Example 1:')
solution("1.1.1.1")

print('\nExample 2:')
solution("255.101.1.0")
