from typing import List


def count_senior_citizens(passengers: List[str]) -> int:
    """
    Count the number of senior citizens in a list of passenger details.

    Args:
        passengers: A list of passenger details in the form "9999999999A1122",
                    where 9 denotes the phone number, A the sex, 1 the age,
                    and 2 the seat number.

    Returns:
        The count of all senior citizens (age >= 60).
    """
    return sum(int(passenger[11:13]) >= 60 for passenger in passengers)


import unittest


class TestCountSeniorCitizens(unittest.TestCase):
    def test_example1(self):
        passengers = ["7868190130M7522", "5303914400F9211", "9273338290F4010"]
        self.assertEqual(count_senior_citizens(passengers), 2)

    def test_example2(self):
        passengers = ["1313579440F2036", "2921522980M5644"]
        self.assertEqual(count_senior_citizens(passengers), 0)


if __name__ == "__main__":
    unittest.main()
