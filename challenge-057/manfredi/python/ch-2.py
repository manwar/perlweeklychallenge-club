#!/usr/bin/env python3

abbr = {}
input = [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ]
# input = [ "alphabet", "car", "carboxy", "book", "carpet", "cadmium", "cadeau", "alpine" ]
instr = ':' + ':'.join(input)
max = sorted([ len(s) for s in input])[-1]

for length in range(1, max + 1):

    for word in input:
        if word in abbr: 
            continue
        if len(word) == length:
            abbr[word] = word
            continue
        sub = ':' + word[0:length]
        found = instr.count(sub)

        if found == 1:
            abbr[word] = sub.lstrip(':')

output = [ abbr[o] for o in input] 
print("Input  {}".format(input))
print("Output {}".format(output))

