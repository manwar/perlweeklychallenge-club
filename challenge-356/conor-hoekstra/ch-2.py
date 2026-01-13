def WhoWins(w):
    x = sorted([[2, 3, 4][i] if w[i] == "H" else [7, 6, 5][i] for i in range(3)])
    y = sorted([1 if w[3] == "H" else x[-1], x[0] if w[4] == "H" else x[1]])
    a, b = (0, 1) if w[-1] == "H" else (1, 0)
    return f"Team {y[a]} defeated Team {y[b]}"


print(WhoWins("HAHAHH"))  # "Team 2 defeated Team 6"
print(WhoWins("HHHHHH"))  # "Team 1 defeated Team 2"
print(WhoWins("HHHAHA"))  # "Team 4 defeated Team 2"
print(WhoWins("HAHAAH"))  # "Team 4 defeated Team 6"
print(WhoWins("HAAHAA"))  # "Team 5 defeated Team 1"
