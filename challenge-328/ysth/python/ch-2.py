import sys
import re

inputs = sys.argv[1:]

bad_pair = re.compile(r'(?i:(.)\1)(?<!\1)')

for string_in in inputs:
    string_out = string_in
    while True:
        string_out, substitutions_made = bad_pair.subn('', string_out)
        if substitutions_made==0:
            break
    print(f'{string_in:<30} -> {string_out:<30}')
