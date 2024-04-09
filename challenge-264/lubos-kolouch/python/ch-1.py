def greatest_english_letter(s: str) -> str:
    # Create sets for lowercase and uppercase letters
    lower_set = set(filter(str.islower, s))
    upper_set = set(filter(str.isupper, s))

    # Find letters that appear in both sets
    common_letters = {l.lower() for l in lower_set} & {u.lower() for u in upper_set}

    # Return the greatest letter or an empty string
    greatest_letter = max(common_letters, default='')
    return greatest_letter.upper()


# Test the function
assert greatest_english_letter('PeRlwEeKLy') == 'L'
assert greatest_english_letter('ChaLlenge') == 'L'
assert greatest_english_letter('The') == ''
