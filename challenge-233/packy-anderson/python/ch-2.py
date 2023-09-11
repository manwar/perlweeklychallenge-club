#!/usr/bin/env python

def conjunction(words):
    if len(words) < 2:
        return(words)
    elif len(words) == 2:
        return(f'{words[0]} and {words[1]}')
    else:
        last = words.pop(-1)
        l = ', '.join(words)
        return(f'{l}, and {last}')

def solution(ints):
    as_list = ', '.join(map(lambda i: str(i), ints))
    print(f'Input: @ints = ({as_list})')

    # count how often each integer occurs
    counts = {}
    for i in ints:
        if i not in counts:
            counts[i] = 0
        counts[i] += 1

    # now create a hash of arrays listing which integers
    # occur at what frequencies
    frequency = {}
    for i in counts.keys():
        if counts[i] not in frequency:
            frequency[ counts[i] ] = []
        frequency[ counts[i] ].append(i)

    output = []
    text = ''
    for freq in sorted(frequency):
        # get each integer for this frequency in descending order
        for i in sorted(frequency[freq], reverse=True):
            # we need to put the integer on the list $freq times
            for x in range(freq):
                output.append(i)

        # now let's do the English description of the output.
        # have the integers in ascending order in the text,
        # and wrap them in quotes
        l = list(map(lambda i: f"'{str(i)}'", sorted(frequency[freq])))
        if len(l) == 1:
            text += l[0] + f" has a frequency of {freq}\n"
        else:
            text += conjunction(l)
            if len(l) == 2:
                text += ' both'
            text += (
                f" have a frequency of {freq}, " +
                "so they are sorted in decreasing order\n"
            )
    as_list = ', '.join(map(lambda i: str(i), output))
    print(f'Output: ({as_list})')
    print(f'\n{text}')


print('Example 1:')
solution([1,1,2,2,2,3]);

print('\nExample 1:')
solution([2,3,1,3,2])

print('\nExample 3:')
solution([-1,1,-6,4,5,-6,1,4,1])