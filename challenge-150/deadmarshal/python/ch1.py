import sys

if len(sys.argv) != 3:
  sys.stderr.write("Provide 2 string args!")
  exit(1)

def fibonacci_words(input1,input2):
  arr = [input1,input2]
  while True:
    arr.append(arr[-2] + arr[-1])
    if len(arr[-1]) >= 52: break
  return arr[-1][50]  

print(fibonacci_words(sys.argv[1], sys.argv[2]))
