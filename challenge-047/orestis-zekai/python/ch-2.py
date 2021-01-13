gapfulNumbers = 0
currentNum = 100
numbers = []

while (gapfulNumbers < 20):
	divisor = int(str(currentNum)[0] + str(currentNum)[-1])
	if (currentNum % divisor == 0):
		gapfulNumbers += 1
		numbers.append(currentNum)

	currentNum += 1
	
print(numbers)