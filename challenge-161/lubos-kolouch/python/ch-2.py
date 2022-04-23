""" Challenge 161 LK Python """


class Pangram:
    """Challenge 161 Task 2"""

    def __init__(self) -> None:
        self.seen_letters: dict = {}
        self.output: list = []

    @staticmethod
    def is_abcd(what: str) -> bool:
        """Check if the file is in the right order"""
        return what == "".join(sorted(what))

    def process_word(self, what: str) -> None:
        """Check if the word matches"""

        this_run_letters = dict(self.seen_letters)

        for char in what:
            this_run_letters[char] = 1

        if len(self.seen_letters.keys()) == len(this_run_letters.keys()) - 1:
            # we added a letter
            self.output.append(what)
            self.seen_letters = dict(this_run_letters)

        return

    def get_abcdrian_pangram(self) -> str:
        """only abecederian words solving exactly one letter"""
        with open("dictionary.txt") as in_file:

            while line := in_file.readline().strip():
                if not self.is_abcd(line):
                    continue

                self.process_word(line)

                # seen all letters?
                if len(self.seen_letters.keys()) == 26:
                    return " ".join(self.output)

        return ""


pangram = Pangram()
assert (
    pangram.get_abcdrian_pangram()
    == "a ad adds ado ago ah ahoy all allot allow almost amp an art ax blot buy buzz cc cell chi deft envy jot knot qt"
)
