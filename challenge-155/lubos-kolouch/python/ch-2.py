""" Challenge 155 Task 2 """

import re


class PisanoPeriod:
    """Class for the challenge"""

    def __init__(self) -> None:
        self.fibs: list[int] = []
        self.fib_hash: dict[int, int] = {}

        self.fibs.append(0)
        self.fibs.append(1)
        self.fib_hash[0] = 1
        self.fib_hash[1] = 1

    def gen_more_fibs(self) -> None:
        """Generate Fibonacci numbers of the fly"""
        self.fibs.append(self.fibs[-1] + self.fibs[-2])

    def get_pisano_period(self, what) -> int:
        """Find out the period for the given what"""

        all_nums = str(self.fibs[0]) + str(self.fibs[1])

        period_len = 2
        while 1:
            period_len += 1
            self.gen_more_fibs()
            all_nums += str(self.fibs[-1] % what)

            if re.search(r"^(.*)\1$", all_nums):
                break
        return period_len // 2


def main() -> None:
    """The main method"""

    pisano_period = PisanoPeriod()
    assert pisano_period.get_pisano_period(3) == 8


if __name__ == "__main__":
    main()
