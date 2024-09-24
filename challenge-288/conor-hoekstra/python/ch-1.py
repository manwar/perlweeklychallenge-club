# Link: https://theweeklychallenge.org/blog/perl-weekly-challenge-288

def is_palindrome(n):
    return str(n) == str(n)[::-1]

def find(start: int, delta: int) -> int:
    while not is_palindrome(start):
        start += delta
        print(start)
        if start < 0:
            return None
    return start

def closest_palindrome(n: str) -> str:
    i = int(n)
    a = find(i - 1, -1)
    b = find(i + 1, 1)
    print(a, b)
    if a is not None and i - a <= b - i:
        return str(a)
    return str(b)

# Tests
print(closest_palindrome("123"))       # "121"
print(closest_palindrome("2"))         # "1"
print(closest_palindrome("1400"))      # "1441"
print(closest_palindrome("1001"))      # "999"
print(closest_palindrome("999"))       # "10001"
print(closest_palindrome("12312345"))  # "12311321"
print(closest_palindrome("0"))         # "1"
