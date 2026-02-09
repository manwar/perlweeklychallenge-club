"#TODO" 


# You are given a string and a width.

# Write a script to return the string that centers the text within that width using asterisks * as padding.

# Example 1
# Input: $str = "Hi", $width = 5
# Output: "*Hi**"

# Text length = 2, Width = 5
# Need 3 padding characters total
# Left padding: 1 star, Right padding: 2 stars

# Example 2
# Input: $str = "Code", $width = 10
# Output: "***Code***"

# Text length = 4, Width = 10
# Need 6 padding characters total
# Left padding: 3 stars, Right padding: 3 stars

# Example 3
# Input: $str = "Hello", $width = 9
# Output: "**Hello**"

# Text length = 5, Width = 9
# Need 4 padding characters total
# Left padding: 2 stars, Right padding: 2 stars

# Example 4
# Input: $str = "Perl", $width = 4
# Output: "Perl"

# No padding needed

# Example 5
# Input: $str = "A", $width = 7
# Output: "***A***"

# Text length = 1, Width = 7
# Need 6 padding characters total
# Left padding: 3 stars, Right padding: 3 stars

# Example 6
# Input: $str = "", $width = 5
# Output: "*****"

# Text length = 0, Width = 5
# Entire output is padding
import unittest


def justify(text: str, width:int) -> str:
    if width < 0:
        raise ValueError("Width must be greater than zero")

    if len(text) ==0:
        out = "*" * width
    elif len(text) >= width:
        out = text
    elif (width - len(text)) % 2 == 0:
        padding = (width - len(text)) // 2
        padding = "*" * padding
        out = padding + text + padding
    elif (width - len(text)) % 2 == 1:
        lpad = (width - len(text) -1) // 2
        rpad = lpad + 1
        
        lpad = "*" * lpad
        rpad = "*" * rpad
        out = lpad + text + rpad
    else:
        out = ""
    
    return out


def dev():
    print("Starting...")
    tests = [("Hi",5),("Code",10),("Hello", 9),("Perl",4),("A",7),("", 5)]
    for t,w in tests:
        print(justify(t,w))


class ChallengeRunner(unittest.TestCase):

    def test_case_1(self):
        self.assertEqual(convergeToKaprekar(3524), 3)

    def test_case_2(self):
        self.assertEqual(convergeToKaprekar(6174), 0)

    def test_case_3(self):
        self.assertEqual(convergeToKaprekar(9998), 5)

    def test_case_4(self):
        self.assertEqual(convergeToKaprekar(1001), 4)

    def test_case_5(self):
        self.assertEqual(convergeToKaprekar(9000), 4)

    def test_case_6(self):
        self.assertEqual(convergeToKaprekar(1111), -1)


if __name__ == '__main__':
    dev()
    #unittest.main()
