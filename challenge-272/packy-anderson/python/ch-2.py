#!/usr/bin/env python

def score(strVal):
    chars = [ c for c in strVal ]
    vals  = [ ord(c) for c in chars ]
    explain = [ "ASCII values of characters:" ]
    for c, v in zip(chars, vals):
        explain.append(f"{c} = {v}")

    line1 = []
    line2 = []

    last = vals.pop(0)
    while vals:
        next = vals.pop(0)
        line1.append(f"| {last} - {next} |")
        line2.append(abs(last - next))
        last = next

    explain.append("Score => " + " + ".join(line1))
    explain.append("      => " + " + ".join(map(lambda i: str(i), line2)))
    score = sum(line2)
    explain.append(f"      => {score}")

    return score, "\n".join(explain)

def solution(strVal):
    print(f'Input: $str = "{strVal}"')
    scoreVal, explain = score(strVal)
    print(f'Output: {scoreVal}\n\n{explain}')

print('Example 1:')
solution("hello")

print('\nExample 2:')
solution("perl")

print('\nExample 3:')
solution("raku")
