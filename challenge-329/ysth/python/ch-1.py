import sys
import re

inputs = sys.argv[1:]

for string in inputs:
    #new_string = string.translate({ c:' ' for c in range(ord('a'),ord('z')+1) })
    #unique_integers = sorted(set(new_string.split()))
    unique_integers = [int(i) for i in sorted(set(re.findall(r'0*(\d+)', string)))]
    print(f'{string:<30} -> {str(unique_integers)}')
