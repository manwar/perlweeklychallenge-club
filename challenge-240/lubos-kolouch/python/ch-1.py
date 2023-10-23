import unittest


def is_acronym(chk: str, words: list[str]) -> bool:
    acronym = "".join(word[0].lower() for word in words)
    return acronym == chk.lower()


class TestIsAcronym(unittest.TestCase):
    def test_cases(self):
        self.assertEqual(is_acronym("ppp", ["Perl", "Python", "Pascal"]), True)
        self.assertEqual(is_acronym("rp", ["Perl", "Raku"]), False)
        self.assertEqual(is_acronym("oac", ["Oracle", "Awk", "C"]), True)


if __name__ == "__main__":
    unittest.main()
