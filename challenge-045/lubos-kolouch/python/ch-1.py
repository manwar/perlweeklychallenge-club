import sys


def square_secret_code(message: str) -> str:
    """
    Encode the given message using the square secret code mechanism.

    Args:
        message (str): The input message to be encoded.

    Returns:
        str: The encoded message.
    """
    message = message.lower().replace(" ", "")
    cols = 8

    rows = (len(message) + cols - 1) // cols
    coded_message = ""

    for i in range(cols):
        for j in range(rows):
            index = j * cols + i
            if index < len(message):
                coded_message += message[index]
        coded_message += " " if i < cols - 1 else ""

    return coded_message


def test_square_secret_code(message: str, expected_coded_message: str) -> None:
    """
    Test the square_secret_code function with the provided message and expected_coded_message.

    Args:
        message (str): The input message for the test.
        expected_coded_message (str): The expected encoded message for the test.

    Returns:
        None
    """
    coded_message = square_secret_code(message)
    if coded_message == expected_coded_message:
        print(f"Test passed: {message} -> {coded_message}")
    else:
        print(
            f"Test failed: {message} -> {coded_message} (expected: {expected_coded_message})"
        )


if __name__ == "__main__":
    # Tests
    test_square_secret_code("The quick brown fox jumps over the lazy dog",
                            "tbjrd hruto eomhg qwpe unsl ifoa covz kxey")

    # Main code
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <message>")
        sys.exit()

    message = sys.argv[1]
    print(square_secret_code(message))
