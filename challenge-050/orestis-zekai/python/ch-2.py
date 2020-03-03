l = [2, 6, 1, 3]
nobles = []

for num1 in l:
	greaters = 0
	for num2 in l:
		if num2 > num1:
			greaters += 1
			if greaters > num1:
				break
	else:
		if greaters == num1:
			nobles.append(num1)

print(nobles)