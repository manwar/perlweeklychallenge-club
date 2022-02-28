""" Challenge 153 Task 1"""


class LeftFactCalculator:
    """Challenge 153 Task 1"""

    def __init__(self):
        # keep seen factorials in a cache to speed things up
        self.fact_cache = {0: 1}
        self.left_fact_cache = {0: 0}

    def calculate_factorial(self, what: int):
        """Calculate factorial on one number"""

        try:
            return self.fact_cache[what]
        except KeyError:
            pass

        # let's utilize the fact that we are processing the numbers in sequence
        self.fact_cache[what] = what * self.fact_cache[what - 1]

        return self.fact_cache[what]

    def calculate_left_fact(self, what: int):
        """Calculate the left factorial of one number"""

        try:
            return self.left_fact_cache[what]
        except KeyError:
            pass

        # let's utilize the fact that we are processing the numbers in sequence
        self.left_fact_cache[what] = (
            self.calculate_factorial(what - 1) + self.left_fact_cache[what - 1]
        )

        return self.left_fact_cache[what]

    def get_left_factorial(self, what: int):
        """Get the solution for the task"""

        output = []

        for i in range(1, what + 1):
            output.append(self.calculate_left_fact(i))

        return output


def main():
    calculator = LeftFactCalculator()
    assert calculator.get_left_factorial(10) == [
        1,
        2,
        4,
        10,
        34,
        154,
        874,
        5914,
        46234,
        409114,
    ]


if __name__ == "__main__":
    main()
