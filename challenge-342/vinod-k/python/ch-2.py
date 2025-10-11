def max_score(s: str) -> int:
    max_score = 0
    left_zeros = 0
    right_ones = s.count('1')

    for i in range(len(s) - 1):
        if s[i] == '0':
            left_zeros += 1
        else:
            right_ones -= 1
        score = left_zeros + right_ones
        max_score = max(max_score, score)

    return max_score

examples = ["0011", "0000", "1111", "0101", "011101"]
for example in examples:
    print(f"Input: {example}")
    print(f"Output: {max_score(example)}\n")
