import re

num = 23
factor = 2

onesZeros = re.compile(r'[2-9]+')

while True:
	intermed = num*factor
	if onesZeros.search(str(intermed)) is None:
		print(intermed)
		break
	factor += 1
