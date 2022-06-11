#!ruby.exe

# Author: Robert DiCicco
# Date: 26-JAN-2022
# Challenge 149 Fibonacci Digit Sum (Ruby)

def SingleSumOfDigits (num)
    digsum = num.digits.reverse.sum
end

def IsPerfectSquare(num)
    Integer.sqrt(num) ** 2  == num
end

def IsFibonacci(n)
    # n is Fibonacci if one of 5*n*n + 4 or 5*n*n - 4 or both
    # is a perfect square

    if IsPerfectSquare(5*n*n + 4) then
        return true
    end

    if IsPerfectSquare(5*n*n - 4) then
        return true
    end

    return false
end

expected = [0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44]

cnt=0
total=0
arr_output = []

# Get first 20 fibonacci numbers
while total < 20 do
    sumval = SingleSumOfDigits(cnt)  # get digits sum, then check if fibonacci
    if(IsFibonacci(sumval)) then
        arr_output.push(cnt)
        total += 1  # keep track of how many are output
    end

    cnt += 1    # bump cnt
end

puts "Expected: " + expected.to_s + " "
puts "Output:   " + arr_output.to_s + " "
