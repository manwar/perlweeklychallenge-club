#!/usr/bin/env python

def word_count(sentences):
  return len(sentences.split())

def max_words(sentences):
  return max([word_count(s) for s in sentences])

def solution(sentences):
  joined = ", ".join([f'"{s}"' for s in sentences])
  print(f'Input: @sentences = ({joined})')
  print(f'Output: {max_words(sentences)}')

print('Example 1:')
solution(["Hello world", "This is a test", "Perl is great"])

print('\nExample 2:')
solution(["Single"])

print('\nExample 3:')
solution(["Short", "This song's just six words long",
          "A B C", "Just four words here"])

print('\nExample 4:')
solution(["One", "Two parts", "Three part phrase", ""])

print('\nExample 5:')
solution(["The quick brown fox jumps over the lazy dog", "A",
          "She sells seashells by the seashore",
          "To be or not to be that is the question"])
