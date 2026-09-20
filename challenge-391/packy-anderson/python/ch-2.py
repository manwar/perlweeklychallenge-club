#!/usr/bin/env python

def arrange_boxes(boxes):
  boxes.sort(key=lambda k: (k[0], k[1]))
  box_stack = [ boxes.pop(0) ]
  while boxes:
    next = boxes.pop(0)
    box  = box_stack[-1]
    if box[0] < next[0] and box[1] < next[1]:
      box_stack.append(next)
  return len(box_stack), box_stack

def box_size(box):
  return f'[{box[0]}, {box[1]}]'

def solution(boxes):
  boxlist = ", ".join([box_size(box) for box in boxes])
  print(f'Input: @boxes = ({boxlist})')
  output, box_stack = arrange_boxes(boxes)
  boxlist = ", ".join([box_size(box) for box in box_stack])
  print(f'Output: {output}\n\n{boxlist}')

print('Example 1:')
solution([[1, 3], [3, 5], [6, 8], [2, 4]])

print('\nExample 2:')
solution([[4, 5], [4, 6], [6, 7], [2, 3], [4, 3]])

print('\nExample 3:')
solution([[5, 5], [5, 5], [5, 5]])

print('\nExample 4:')
solution([[2, 100], [3, 200], [4, 300], [5, 50], [5, 400]])

print('\nExample 5:')
solution([[10, 20], [15, 10], [20, 30], [12, 18], [16, 25]])
