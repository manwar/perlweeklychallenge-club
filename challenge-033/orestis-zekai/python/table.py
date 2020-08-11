# Formatted Multiplication Table

numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
line1 = ' x |   1   2   3   4   5   6   7   8   9  10  11'
line2 = '---+--------------------------------------------'

print(line1)
print(line2)


for i in range(1,12):
	# Print left column number
	if (i < 10):
		print(' ' + str(i), end=" ")
	else:
		print(i, end=" ")
	print('|', end=" ")

	for j in range(0, i):
		print("   ", end=" ")
	for j in range(i, 12):
		if (i*j < 9):
			print(str(i*j) + '   ', end="")
		else:
			print(str(i*j) + '  ', end="")
	print('\n')