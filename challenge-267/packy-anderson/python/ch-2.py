#!/usr/bin/env python

def lineCounts(strvar, widths):
    (lines, last_line, last_width, explain) = (0, '', 0, '')
    # we can't do a range of characters, but we can do a range
    # of the ASCII values of the characters
    letters = [ chr(c) for c in range(ord('a'), ord('z')+1) ]
    width = dict( zip(letters, widths) )
    for c in strvar:
        if last_width + width[c] > 100:
            lines += 1
            explain += f"\nLine {lines}: {last_line} "
            explain += f"({last_width} pixels)"
            (last_line, last_width) = (c, width[c])
        else:
            last_line  += c
            last_width += width[c]
    lines += 1
    explain += f"\nLine {lines}: {last_line} "
    explain += f"({last_width} pixels)"
    return (lines, last_width, explain)

def comma_join(arr):
  return ', '.join(map(lambda i: str(i), arr))

def solution(strvar, widths):
  print(f'Input: $str = "{strvar}"')
  print(f'       @widths = ({comma_join(widths)})')
  (lines, last_width, explain) = lineCounts(strvar, widths)
  print(f'Output: ({lines}, {last_width}){explain}')

print('Example 1:')
solution(
  "abcdefghijklmnopqrstuvwxyz",
  [10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10]
)

print('\nExample 2:')
solution(
  "bbbcccdddaaa",
  [4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10]
)

print('\nExample 3:')
solution(
  "thequickbrownfoxjumpedoverthelazydog",
  [7,8,7,8,7,5,8,8,4,4,8,4,12,8,8,8,8,5,6,4,8,8,12,8,8,7]
)