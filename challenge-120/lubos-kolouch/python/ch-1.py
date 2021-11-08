# ===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl
#
#  DESCRIPTION: Perl Weekly Challenge #120
#               Task 1 - Swap Odd/Even bits
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 20210710 04:44:33 PM
# ===============================================================================


def swap_bits(what: int):

    binary_what = str(bin(what)[2:])

    if len(binary_what) % 2 == 1:
        binary_what = "0" + binary_what

    arr = [binary_what[i:i+2] for i in range(0, len(binary_what), 2)]
    rev_arr = list(map(lambda x: x[::-1], arr))
    return int("".join(rev_arr), 2)


assert swap_bits(101) == 154
assert swap_bits(18) == 33
