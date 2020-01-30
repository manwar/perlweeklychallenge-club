# Define string, make it a list, count and remove spaces
string = 'The quick brown fox jumps over the lazy dog'
f = [char.lower() for char in string]
spaces = 0
for char in f:
	if (char == ' '):
		f.remove(char)
		spaces += 1

# Code new string
coded = []
j = 0
while True:
	i = j

	if (len(coded) == len(f) + spaces):
		break

	while (i < len(f)):
		coded.append(f[i])
		i += 8

	coded.append(' ')
	j += 1

# Convert to string
new_string = ''
for letter in coded:
	new_string += letter

print(new_string)