from typing import List, Tuple, Union


def split_list(lst: List[int], size: int) -> Union[List[Tuple[int]], int]:
    if len(lst) % size != 0:
        return -1
    lst.sort()
    result = []
    while lst:
        group = [lst.pop(0)]
        for _ in range(size - 1):
            if group[-1] + 1 in lst:
                group.append(lst.pop(lst.index(group[-1] + 1)))
            else:
                return -1
        result.append(tuple(group))
    return result


import unittest


class TestSplitList(unittest.TestCase):

    def test_split_list(self):
        self.assertEqual(split_list([1, 2, 3, 5, 1, 2, 7, 6, 3], 3),
                         [(1, 2, 3), (1, 2, 3), (5, 6, 7)])
        self.assertEqual(split_list([1, 2, 3], 2), -1)
        self.assertEqual(split_list([1, 2, 4, 3, 5, 3], 3), [(1, 2, 3),
                                                             (3, 4, 5)])
        self.assertEqual(split_list([1, 5, 2, 6, 4, 7], 3), -1)


if __name__ == '__main__':
    unittest.main()
