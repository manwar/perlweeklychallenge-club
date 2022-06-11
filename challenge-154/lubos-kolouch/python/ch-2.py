""" Challenge 154 Task 2 LK """
from sympy import isprime


class PadovanPrimes:
    def __init__(self):

        self.nums_cache = [1, 1, 1]
        self.seen_nums = {}

    def gen_next_num(self):
        """Calculate the next Padovan num"""
        self.nums_cache.append(self.nums_cache[-2] + self.nums_cache[-3])

    def get_n_unique(self, what: int):
        """Get the n unique numbers"""

        counter = 0
        output = []

        while counter < what:
            self.gen_next_num()

            if not isprime(self.nums_cache[-1]):
                continue

            if self.seen_nums.get(self.nums_cache[-1], -1) != -1:
                continue

            output.append(self.nums_cache[-1])
            counter += 1
            self.seen_nums[self.nums_cache[-1]] = 1

        return output


def main():
    """Do the main thing"""
    padovan = PadovanPrimes()
    assert padovan.get_n_unique(10) == [
        2,
        3,
        5,
        7,
        37,
        151,
        3329,
        23833,
        13091204281,
        3093215881333057,
    ]


if __name__ == "__main__":
    main()
