#!/usr/bin/env python3

def generate_fractions(n: int):
    fractions = []
    
    for num in range(1, n+1):
        for den in range(1, n+1):
            fractions.append((num, den))
    
    fractions.sort(key=lambda f: (f[0]/f[1], f[0]))
    
    unique = []
    seen_values = {}
    
    for num, den in fractions:
        value = num / den
        
        if value not in seen_values or num < seen_values[value]:
            seen_values[value] = num
            unique.append((num, den))
    
    return unique

def print_fractions(n: int):
    """Print fractions exactly matching example format."""
    print(f"Input: {n}")
    print("Output: ", end="")
    
    fractions = generate_fractions(n)
    
    for i, (num, den) in enumerate(fractions):
        print(f"{num}/{den}", end="")
        if i < len(fractions) - 1:
            print(", ", end="")
    
    print()
    print()

test_cases = [3, 4, 1, 6, 5]


for n in test_cases:
    print_fractions(n)
