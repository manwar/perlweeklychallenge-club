def decode(encoded: list[int], initial: int) -> [int]:
    original = [
        initial,
    ]
    for encoded_element in encoded:
        original_element = original[-1] ^ encoded_element
        original.append(original_element)
    return original
