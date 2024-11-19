#!/usr/bin/python3

import re

def main():
    examples = [ "abbc", "aaabccc", "abcc" ]
    for input in examples:
        output = string_compression(input)
        print(f'Input:  input = "{input}"')
        print(f'Output:         "{output}"')
        print("")


def string_compression(string):
    output = ''
    while len(string):
        c = string[0:1]
        cc = re.match(rf"^({c}+)",string)
        l = len(cc.group(0))
        cl = c
        if l > 1:
            cl += str(l)
        string = re.sub(rf"^({c}+)", "", string)
        output = output + cl
    return output

if __name__ == '__main__':
    main()
