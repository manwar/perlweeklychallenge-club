#! /usr/bin/env python
""" Perl weekly challenge 058
    https://perlweeklychallenge.org/blog/perl-weekly-challenge-058/ """

from packaging import version


def compare_versions(ver_1, ver_2):
    """ Compare versions and return the result"""

    v_1 = version.parse(ver_1)
    v_2 = version.parse(ver_2)

    if v_1 > v_2:
        return 1

    if v_1 < v_2:
        return -1

    return 0


assert compare_versions('0.1', '1.1') == -1
assert compare_versions('2.0', '1.2') == 1

# This fails, reported : https://github.com/pypa/packaging/issues/299
assert compare_versions('1.2', '1.2_5') == -1
assert compare_versions('1.2.1', '1.2_1') == 1
assert compare_versions('1.2.1', '1.2.1') == 0
