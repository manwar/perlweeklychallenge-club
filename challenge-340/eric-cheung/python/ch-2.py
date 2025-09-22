
## strInput = "The cat has 3 kittens 7 toys 10 beds"  ## Example 1
## strInput = "Alice bought 5 apples 2 oranges 9 bananas"  ## Example 2
## strInput = "I ran 1 mile 2 days 3 weeks 4 months"  ## Example 3
## strInput = "Bob has 10 cars 10 bikes"  ## Example 4
strInput = "Zero is 0 one is 1 two is 2"  ## Example 5

arrNum = [int(strLoop) for strLoop in strInput.split(" ") if strLoop.isnumeric()]

bIsStrictIncrease = all([arrNum[nIndx] > arrNum[nIndx - 1] for nIndx in range(1, len(arrNum))])

print (bIsStrictIncrease)
