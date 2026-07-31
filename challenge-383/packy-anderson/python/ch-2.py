#!/usr/bin/env python

safe = (0, 51, 102, 153, 204, 255)

def closest(num, arr):
  return num - min([ num - x for x in arr ], key=abs)

def nearest_rgb(color):
  # grab the RGB values
  colors = color[1:3], color[3:5], color[5:7]
  # convert to decimal & find closest web-safe value
  colors = [ closest(int(n, 16), safe) for n in colors ]
  # convert back to hex and return as color code
  return "#" + "".join([f'{n:02X}' for n in colors])

def solution(color):
  print(f'Input: $color = "{color}"')
  print(f'Output: "{nearest_rgb(color)}"')

print('Example 1:')
solution("#F4B2D1")

print('\nExample 2:')
solution("#15E6E5")

print('\nExample 3:')
solution("#191A65")

print('\nExample 4:')
solution("#2D5A1B")

print('\nExample 5:')
solution("#00FF66")
