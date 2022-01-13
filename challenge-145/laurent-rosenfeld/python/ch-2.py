def is_palindrome (str):
    return str == str[::-1]

def find_all_palindromes (input):
    seen = {}
    result = f'{input} : '
    for start in range (0, len(input)):
        for endstr in range(1, (len(input) + 1)):
            candidate = input[start : endstr]
            if is_palindrome(candidate) and not candidate in seen:
                result = result + " " + candidate
                seen[candidate] = 1
    print(result)

for test in ("redivider", "deific", "rotors", "challenge"):
    find_all_palindromes(test);
