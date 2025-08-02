#!/usr/bin/env python

def countEquDiv(k, ints):
    explain = []
    cnt = 0
    for i in range(len(ints) - 1):
        for j in range(i+1, len(ints)):
            # does ints[i] == ints[j]?
            if not ints[i] == ints[j]: break
            # is i x j is divisible by k?
            if not ( (i * j) % k ) == 0: break
            # count the pair and explain why
            cnt += 1
            explain.append(
                f"({i}, {j}) => ints[{i}] == ints[{j}] " +
                f"and {i} x {j} is divisible by {k}"
            )
    return(cnt, "\n".join(explain))

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(k, ints):
    print(f'Input: @arr = ({comma_join(ints)}) '+
          f'and $k = {k}')
    (cnt, explain) = countEquDiv(k, ints)
    print(f'Output: {cnt}\n\n{explain}')

print('Example 1:')
solution(2, [3,1,2,2,2,1,3])

print('\nExample 2:')
solution(1, [1,2,3])