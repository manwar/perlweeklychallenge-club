#!/usr/bin/env python

def max_words(arr):
  return max(len(s.split()) for s in arr) if arr else 0

print(max_words(['Hello world','This is a test','Perl is great']))
print(max_words(['Single']))
print(max_words(['Short','This sentence has six words in total',
		'A B C',
		'Just four words here']))
print(max_words(['One','Two parts','Three part phrase','']))
print(max_words(['The quick brown fox jumps over the lazy dog',
		 'A',
		 'She sells seashells by the seashore',
		 'To be or not to be that is the question']))

