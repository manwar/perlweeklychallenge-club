#!/usr/bin/env python

def justify(string, width):
  length = len(string)
  # handle special cases
  if length >= width:
    return(string, "No padding needed")
  elif length == 0:
    return(
      '*' * width, 
      f'Text length = 0, Width = {width}\nEntire output is padding'
    )
  pad   = width - length
  lside = int(pad / 2)
  rside = pad - lside
  output = ('*' * lside) + string + ('*' * rside)
  explain = (
    f"Text length = {length}, Width = {width}\n" +
    f"Need {pad} padding characters total\n" +
    f"Left padding: {lside} stars, Right padding: {rside} stars"
  )
  return (output, explain)

def solution(string, width):
  print(f'Input: $str = "{string}", $width = {width}')
  output, explain = justify(string, width)
  print(f'Output: "{output}"\n\n{explain}')

print('Example 1:')
solution("Hi", 5)

print('\nExample 2:')
solution("Code", 10)

print('\nExample 3:')
solution("Hello", 9)

print('\nExample 4:')
solution("Perl", 4)

print('\nExample 5:')
solution("A", 7)

print('\nExample 6:')
solution("", 5)