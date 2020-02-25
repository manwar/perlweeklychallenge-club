rooms = 500
employees = 500

# The first employee opens all the doors
doors = [1 for i in range(0,rooms)]

for i in range(1, employees):
	j = i
	step = i + 1
	while (j < 500):
		if (doors[j] == 0):
			doors[j] = 1
		else:
			doors[j] = 0

		j += step

print(doors)
print(sum(doors))