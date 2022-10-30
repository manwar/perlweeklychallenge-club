# pip3 install primefac
from primefac import primefac

def square_free_integers():
  arr = []
  i = 1
  while True:
    primes = list(primefac(i))
    if(len(primes) - len(set(primes)) == 0): arr.append(i)
    i += 1
    if i >= 500: break
  return arr

if __name__ == "__main__":
  for elem in square_free_integers():
    print(elem, end=' ')
