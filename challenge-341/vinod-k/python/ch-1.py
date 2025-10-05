sentence = input("Enter the sentence: ")
keys_input = input("Enter the broken keys separated by space: ")

broken_keys = set(keys_input.lower().split())

count = 0
for word in sentence.split():
    if all(char not in broken_keys for char in word.lower()):
        count += 1

print(f"Number of words that can be typed: {count}")
