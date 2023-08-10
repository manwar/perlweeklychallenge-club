truth = [
    'abcdef', 'bc', 'abdeg', 'abcdg', 'bcfg', 'acdfg', 'acdefg', 'abc',
    'abcdefg', 'abcfg'
]


def draw_seven_segment(number):
    lines = [""] * 5

    for digit in str(number):
        segments = truth[int(digit)]
        lines[0] += ("-" * 7 if 'a' in segments else " " * 7) + " "
        lines[1] += ("|" if 'f' in segments else
                     " ") + (" " * 6) + ("|" if 'b' in segments else " ") + " "
        lines[2] += ("-" * 7 if 'g' in segments else " " * 7) + " "
        lines[3] += ("|" if 'e' in segments else
                     " ") + (" " * 6) + ("|" if 'c' in segments else " ") + " "
        lines[4] += ("-" * 7 if 'd' in segments else " " * 7) + " "

    return '\n'.join(lines)


number = 200
print(draw_seven_segment(number))
