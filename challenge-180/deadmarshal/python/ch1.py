import sys

def first_unique_character(s):
  freq = {}
  for i in s:
    if i not in freq:
      freq[i] = 1
    else:
      freq[i] += 1

  for i in range(len(s)):
    if(freq[s[i]] == 1):
      return f"{i} as '{s[i]}' is the first unique character"
  return -1

if(len(sys.argv) != 2):
  sys.stderr.write("No arg(s) provided!\n")
  sys.exit(1)

print(first_unique_character(sys.argv[1]))
