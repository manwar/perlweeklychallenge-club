def is_not_alpha_order(word):
    letters = [*word]
    letters.sort()
    sorted_word = ''.join(letters)
    return word != sorted_word

def count(words):
    total = 0

    for word in words:
        if is_not_alpha_order(word):
            total += 1
    return total
