input_str = input("Enter the string: ")
char = input("Enter the character to reverse prefix until: ")

index = input_str.find(char)

if index == -1 or index == 0:
    # No change if character not found or at start
    result = input_str
else:
    prefix = input_str[:index+1]
    rest = input_str[index+1:]
    result = prefix[::-1] + rest

print(f"Resulting string: {result}")
