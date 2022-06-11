#!ruby.exe
require 'prime'

# AUTHOR: Robert DiCicco
# DATE: 14-MAR-2022
# Challenge Pernicious Numbers 156 ( Ruby )

def SingleSumOfDigits (num)
  digsum = num.digits.sum
  return digsum.to_i
end

outarr = []   # array to collect found numbers

x = 1     # starting point
cnt = 0   # counter for found numbers
while cnt < 10 do  # looking for 10 numbers
  binval =  "%06b" % x  # binary set to 6 digits wide
  retval = SingleSumOfDigits(binval.to_i);  # sum of digits would be the count of ones
  if Prime.prime?(retval)   # if prime, push to the collector array
    outarr.push(x)
    cnt += 1    # bump the counter
  end
  x += 1    # and check next number
end

p outarr  # print the array
