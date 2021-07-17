# ===============================================================================
#  DESCRIPTION: Perl Weekly Challenge #121
#               Task 1 - Invert bit
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 20210710 04:44:33 PM
# ===============================================================================


def invert_bit(what: int, n: int):

    binary_what = str(bin(what)[2:])

    binary_arr = list(binary_what)
    binary_arr[-n] = '0' if binary_arr[-n] == '1' else '1'
    return int("".join(binary_arr), 2)


assert invert_bit(12, 3) == 8
assert invert_bit(18, 4) == 26
