#!python.exe

# AUTHOR: Robert DiCicco
# DATE: 23-MAR-2022
# Challenge 157 Pythagorean Means ( Python )

def arithmetic(n) :
  sum = 0
  sz = len(n)

  for x in n:
    sum += x

  amean = (sum//sz)

  return amean

def geometric(n) :
  prod = 0
  sz = len(n)

  for x in n:
    if(prod == 0):
      prod = x
    else:
      prod *= x

  gmean = (prod ** (1/(sz)))

  return gmean

def harmonic(n) :
  sz = len(n)
  sum = 0

  for x in n:
    sum += 1/x

  hmean = sz/sum

  return hmean

arr = [1,3,5,6,9]
#arr  = [2,4,6,8,10]
#arr  = [1,2,3,4,5]

amean = arithmetic(arr)
gmean = geometric(arr)
hmean = harmonic(arr)

print("Input: @n = %s" % arr)
print("AM = %.1f  GM = %.1f  HM = %.1f\n" % (amean,gmean,hmean))
