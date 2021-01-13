#! python3
from roman import toRoman, fromRoman
import sys


class RomanConvertor:

    def roman_magic(self, v1, op, v2):

        rom_v1 = str(fromRoman(v1))
        rom_v2 = str(fromRoman(v2))

        operation = rom_v1+op+rom_v2

        return toRoman(eval(operation))

    def main(self, v1, op, v2):

        return self.roman_magic(v1.upper(), op, v2.upper())


if __name__ == '__main__':
    v1, op, v2 = sys.argv[1:]
    rom_conv = RomanConvertor()
    print(rom_conv.main(v1, op, v2))

# tests

rom_conv = RomanConvertor()
assert rom_conv.main('I', '+', 'II') == 'III'
assert rom_conv.main('II', '-', 'I') == 'I'
