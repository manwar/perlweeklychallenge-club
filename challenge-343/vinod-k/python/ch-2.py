def find_champion(grid):
    n = len(grid)

    wins = [0] * n
    beaten = [[] for _ in range(n)]

    for i in range(n):
        for j in range(n):
            if grid[i][j] == 1:
                wins[i] += 1
                beaten[i].append(j)

    for i in range(n):
        if beaten[i]:
            beat_list = ', '.join(f"Team {team}" for team in beaten[i])
            print(f"[{', '.join(map(str, grid[i]))}] => Team {i} beats {beat_list}")
        else:
            print(f"[{', '.join(map(str, grid[i]))}] => Team {i} loses to all")

    max_wins = max(wins)
    max_win_teams = [i for i, w in enumerate(wins) if w == max_wins]

    if len(max_win_teams) == 1:
        champion = max_win_teams[0]
    else:
        champion = None
        for team in max_win_teams:
            if all(grid[team][other] == 1 or team == other for other in max_win_teams):
                champion = team
                break

    print(f"\nOutput: Team {champion}\n")

tests = [
    [
        [0, 1, 1],
        [0, 0, 1],
        [0, 0, 0],
    ],
    [
        [0, 1, 0, 0],
        [0, 0, 0, 0],
        [1, 1, 0, 0],
        [1, 1, 1, 0],
    ],
    [
        [0, 1, 0, 1],
        [0, 0, 1, 1],
        [1, 0, 0, 0],
        [0, 0, 1, 0],
    ],
    [
        [0, 1, 1],
        [0, 0, 0],
        [0, 1, 0],
    ],
    [
        [0, 0, 0, 0, 0],
        [1, 0, 0, 0, 0],
        [1, 1, 0, 1, 1],
        [1, 1, 0, 0, 0],
        [1, 1, 0, 1, 0],
    ],
]

for idx, test in enumerate(tests, start=1):
    print(f"Example {idx}:")
    find_champion(test)
