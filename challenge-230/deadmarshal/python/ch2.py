#!/usr/bin/env python3

def count_words(arr,pat):
  return len(list(filter(lambda x: x.startswith(pat),arr)))

print(count_words(['pay', 'attention', 'practice', 'attend'],'at'))
print(count_words(['janet', 'julia', 'java', 'javascript'],'ja'))

