# Longest common substring

string1 = "ABABC"
string2 = "BABCA"

max_substring = ""
max_length = -1


for i in range(0, len(string1)+1):
	for j in range(0, len(string1)+1):
		if (string1[i:j] in string2) and len(string1[i:j]) > max_length:
			max_length = len(string1[i:j])
			max_substring = string1[i:j]


print('The longest substring is: ' + max_substring)
print('The length of the longest substring is: ' + str(max_length))