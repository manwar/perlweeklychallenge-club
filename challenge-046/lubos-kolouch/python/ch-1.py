#!/usr/bin/env python
# -*- coding: utf-8 -*-

from collections import Counter


def decrypt_message(lines: [str]) -> str:
    """
    Decrypts the message by selecting the most frequent character at each position.

    Args:
        lines (list of str): The repeated message lines.

    Returns:
        str: The decrypted message.
    """
    message_length = len(lines[0])
    decrypted_message = ""

    for i in range(message_length):
        column_chars = [line[i] for line in lines]
        most_common_char = Counter(column_chars).most_common(1)[0][0]
        decrypted_message += most_common_char

    return decrypted_message


if __name__ == "__main__":
    repeated_message = [
        "P + 2 l ! a t o",
        "1 e 8 0 R $ 4 u",
        "5 - r ] + a > /",
        "P x w l b 3 k \\",
        "2 e 3 5 R 8 y u",
        "< ! r ^ ( ) k 0",
    ]

    decrypted_message = decrypt_message(repeated_message)
    print(decrypted_message)
