#!/usr/bin/python3

examples = []
examples.append([4])
examples.append([4, 1])
examples.append([2, 3, 1, 1, 4])
examples.append([2, 3, 0, 4])
examples.append([2, 0, 0, 4])


def jump_game(board, position, depth):
    output = []
    last = len(board) - 1
    if position == last:
        return depth
    if position > last:
        return -1
    value = board[position]
    for i in range(1, 1 + value):
        j = position + i
        o = jump_game(board, j, depth + 1)
        output.append(int(o))
    output = [x for x in output if x > -1]
    if len(output) > 0:
        return min(output)
    return -1


for example in examples:
    output = jump_game(example, 0, 0)
    input = ", ".join([str(i) for i in example])
    print(f"    Input:  ints = [{input}]")
    print(f"    Output: {output}")
    print("")
