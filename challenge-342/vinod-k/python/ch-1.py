def format_string(s: str) -> str:
    letters = sorted([ch for ch in s if ch.isalpha()])
    digits  = sorted([ch for ch in s if ch.isdigit()])

    if abs(len(letters) - len(digits)) > 1:
        return ""

    if len(digits) > len(letters):
        start_with_digit = True
    elif len(digits) < len(letters):
        start_with_digit = False
    else:
        start_with_digit = digits[0] < letters[0]

    result = []

    while letters or digits:
        if start_with_digit:
            if digits:
                result.append(digits.pop(0))
            if letters:
                result.append(letters.pop(0))
        else:
            if letters:
                result.append(letters.pop(0))
            if digits:
                result.append(digits.pop(0))

    return "".join(result)


for s in ["a0b1c2", "abc12", "0a2b1c3", "1a23", "ab123"]:
    print(f"Input:  {s}")
    print(f"Output: {format_string(s)}\n")
