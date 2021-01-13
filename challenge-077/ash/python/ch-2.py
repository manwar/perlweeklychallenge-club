# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-077/

# Comments: https://andrewshitov.com/2020/09/08/lonely-x-the-weekly-challenge-77-task-2/

# Output for the given example:
#
# $ python3 ch-2.py
# Lonely X at position (0, 0).
# Lonely X at position (2, 1).
# Lonely X at position (0, 2).

matrix = [
    ['X', 'O', 'O'],
    ['O', 'O', 'X'],
    ['X', 'O', 'O'],
]

def is_O_cell(x, y):
    if 0 <= x < len(matrix[0]) and 0 <= y < len(matrix):
        return matrix[y][x] == 'O'
    else:
        return True

x_cells = [
    [col_i, row_i]
        for row_i, row in enumerate(matrix) 
            for col_i, cell in enumerate(row)
    if cell == 'X'
]

for x_cell in x_cells:
    x, y = x_cell
    if is_O_cell(x    , y + 1) and \
       is_O_cell(x    , y - 1) and \
       is_O_cell(x + 1, y    ) and \
       is_O_cell(x - 1, y    ) and \
       is_O_cell(x + 1, y + 1) and \
       is_O_cell(x + 1, y - 1) and \
       is_O_cell(x - 1, y + 1) and \
       is_O_cell(x - 1, y - 1):
        print(f"Lonely X at position ({x}, {y}).")
