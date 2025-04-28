array_list = ["unicode", "xml", "raku", "perl"]
vowels = ["a", "e", "i", "o", "u"]
count = 0

for element in array_list:
    if element.startswith(tuple(vowels)) | element.endswith(tuple(vowels)):
        count = count + 1

print(count)