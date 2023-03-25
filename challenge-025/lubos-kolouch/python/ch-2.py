def chaocipher_encrypt(message: str) -> str:
    """
    Encrypts a message using the Chaocipher algorithm.

    Chaocipher is a symmetric encryption algorithm that uses two mixed alphabets to
    perform a double substitution on each letter of the plaintext. The two alphabets
    are predetermined and fixed.

    Args:
        message: The message to be encrypted.

    Returns:
        The encrypted message.
    """
    # Define the Chaocipher alphabets
    left_alphabet = "HXUCZVAMDSLKPEFJRIGTWOBNYQ"
    right_alphabet = "PTLNBQDEOYSFAVZKGJRIHWXUMC"

    ciphertext = ""
    left_index = 0
    right_index = 0

    # Loop through each character in the message
    for char in message.upper():
        if not char.isalpha():
            # Ignore non-alphabetic characters
            ciphertext += char
            continue

        # Find the index of the character in the left alphabet
        left_char_index = left_alphabet.index(char)

        # Swap the left and right indices
        left_index, right_index = right_index, left_index

        # Find the corresponding character in the right alphabet
        right_char_index = (left_char_index + right_index) % 26
        right_char = right_alphabet[right_char_index]

        # Append the encrypted character to the ciphertext
        ciphertext += right_char

    return ciphertext


def chaocipher_decrypt(ciphertext: str) -> str:
    """
    Decrypts a message that has been encrypted using the Chaocipher algorithm.

    Args:
        ciphertext: The message to be decrypted.

    Returns:
        The decrypted message.
    """
    # Define the Chaocipher alphabets
    left_alphabet = "HXUCZVAMDSLKPEFJRIGTWOBNYQ"
    right_alphabet = "PTLNBQDEOYSFAVZKGJRIHWXUMC"

    plaintext = ""
    left_index = 0
    right_index = 0

    # Loop through each character in the ciphertext
    for char in ciphertext.upper():
        if not char.isalpha():
            # Ignore non-alphabetic characters
            plaintext += char
            continue

        # Find the index of the character in the right alphabet
        right_char_index = right_alphabet.index(char)

        # Swap the left and right indices
        left_index, right_index = right_index, left_index

        # Find the corresponding character in the left alphabet
        left_char_index = (right_char_index - right_index) % 26
        left_char = left_alphabet[left_char_index]

        # Append the decrypted character to the plaintext
        plaintext += left_char

    return plaintext


# Example usage
message = "Hello World!"
ciphertext = chaocipher_encrypt(message)
print(f"Ciphertext: {ciphertext}")
plaintext = chaocipher_decrypt(ciphertext)
print(f"Plaintext: {plaintext}")
