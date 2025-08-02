import sys
import regex

inputs = sys.argv[1:]

replace_all_qs = regex.compile(r'''(?x)
    (?<a> (?<!a) \? (?! a | \? (?:\?{2})* (?![a?]) | (?:\?{2})* a ))
    | (?<b> (?<! b | \? (?<! (?<!a) \? (?! \? (?:\?{2})* (?![a?]) | (?:\?{2})+ a ) ) ) \? (?!b))
    | (?<c>\?)
    ''')

for string in inputs:
    new_string = replace_all_qs.sub(lambda m:m.lastgroup, string)
    print(f'| {string} | {new_string} |')
