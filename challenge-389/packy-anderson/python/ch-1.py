#!/usr/bin/env python

def reorder(melody):
  # unpack data
  composer = melody[0].upper()
  notes = melody[1]
  order = melody[2]
  # reorder data
  new = [None] * len(notes)
  for note, i in zip(notes, order): new[i-1] = note
  return f"{composer} => " + ' '.join(new)

def int_join(joiner, arr):
  return joiner.join(map(str, arr))

def solution(melody):
  # unpack data
  composer = melody[0]
  notes = ' '.join(melody[1])
  order = int_join(', ', melody[2])
  print(f'Input: $melody = [\'{composer}\', [qw({notes})], [{order}]]')
  print(f'Output: {reorder(melody)}')

print('Example 1:')
solution(['Bach', "C D E F# G A B".split(), [7, 1, 6, 2, 5, 3, 4]])

print('\nExample 2:')
solution(['Beethoven', "C D F# G Ab".split(), [1, 3, 5, 2, 4]])

print('\nExample 3:')
solution(['Brahms', "C Db Eb F G Ab Bb C D".split(), [9, 3, 7, 1, 8, 5, 2, 6, 4]])

print('\nExample 4:')
solution(['Bruckner', "G F# Bb C D Eb F".split(), [4, 7, 2, 6, 1, 5, 3]])

print('\nExample 5:')
solution(['Berg', ["C#"], [1]])
