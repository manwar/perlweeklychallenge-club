#!env python
"""
# ===============================================================================
#
#         FILE: ch_2.py
#
#        USAGE: ./ch_2.py
#
#  DESCRIPTION: Perl Weekly Challenge #094
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-094/
#               Binary Tree to Linked List
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 01/06/2021 02:39:16 PM
#===============================================================================
"""


class Point:
    """ Class to hold each tree node """

    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None


class SumPath:
    """ Class to walk the tree """

    def __init__(self):
        self.total_path = []

    def walk_path(self, root):
        """ Walk the tree and build the total path """

        self.total_path.append(root.value)

        if root.left:
            self.walk_path(root.left)

        if root.right:
            self.walk_path(root.right)

        return self.total_path


def test_case1():
    """ Test 1 """
    root = Point(1)
    elem1 = Point(2)

    pos = elem1
    root.left = elem1

    pos = root.left
    elem1 = Point(3)
    elem2 = Point(4)

    pos.left = elem1
    pos.right = elem2

    sumpath = SumPath()
    arr = sumpath.walk_path(root=root)
    assert arr == [1, 2, 3, 4]


def test_case2():
    """ Test 2 """

    root = Point(1)
    elem1 = Point(2)
    elem2 = Point(3)
    root.left = elem1
    root.right = elem2

    pos = root.left
    elem1 = Point(4)
    elem2 = Point(5)
    pos.left = elem1
    pos.right = elem2

    pos = pos.right
    elem1 = Point(6)
    elem2 = Point(7)

    pos.left = elem1
    pos.right = elem2

    sumpath = SumPath()
    arr = sumpath.walk_path(root=root)

    assert arr == [1, 2, 4, 5, 6, 7, 3]
    return arr


def main():
    """ Print the task from the web """

    arr = test_case2()
    res_str = ' -> '.join(list(map(str, arr)))
    print(res_str)


if __name__ == "__main__":
    main()
