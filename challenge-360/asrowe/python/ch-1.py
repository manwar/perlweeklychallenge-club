
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



class ChallengeRunner(unittest.TestCase):

    def test_case_1(self):
        self.assertEqual(justify("Hi",5), "*Hi**")

    def test_case_2(self):
        self.assertEqual(justify("Code",10), "***Code***")

    def test_case_3(self):
        self.assertEqual(justify("Hello", 9), "**Hello**")

    def test_case_4(self):
        self.assertEqual(justify("Perl",4), "Perl")

    def test_case_5(self):
        self.assertEqual(justify("A", 7),"***A***")

    def test_case_6(self):
        self.assertEqual(justify("", 5),"*****")


if __name__ == '__main__':
    #dev()
    unittest.main()
