import unittest

# Example 1

#Input: $results = "HAHAHH"
#Output: "Team 2 defeated Team 6"

example_1_out = ("HAHAHH", "Team 2 defeated Team 6")

# Example 2

#Input: $results = "HHHHHH"
#Output: "Team 1 defeated Team 2"

example_2_out = ("HHHHHH", "Team 1 defeated Team 2")


# Example 3
#Input: $results = "HHHAHA"
#Output: "Team 4 defeated Team 2"


example_3_out = ("HHHAHA", "Team 4 defeated Team 2")


# Example 4
#Input: $results = "HAHAAH"
#Output: "Team 4 defeated Team 6"


example_4_out = ("HAHAAH", "Team 4 defeated Team 6")


# Example 5
#Input: $results = "HAAHAA"
#Output: "Team 5 defeated Team 1"


example_5_out = ("HAAHAA", "Team 5 defeated Team 1")




# - Team 1 gets a bye
#   - Game 1: Team 2 hosts Team 7
#   - Game 2: Team 3 hosts Team 6
#   - Game 3: Team 4 hosts Team 5
# - Week 2: Divisional playoffs
#   - Game 4: Team 1 hosts the third seeded winner from the previous week.
#   - Game 5: The highest seeded winner from the previous week hosts the second seeded winner.
# - Week 3: Conference final
#   - Game 6: The highest seeded winner from the previous week hosts the other winner

# game 1 = seed 2 vs seed 7
# game 2 = seed 3 vs seed 6
# game 3 = seed 4 vs seed 5
# game 4 = seed 1 vs rank 3 of winners games 1,2,3
# game 5 = rank 1 of winners games 1,2,3 vs rank 2 of winners games 1,2,3
# game 6 = rank 1 of winner games 4,5 vs rank 1 of winner games 4,5




def whoWins(results:str) -> str:

    def play(home, away, result):
        return {"winner": home, "loser": away} if result == "H" else {"winner": away, "loser": home}
    
    def result(x):
        return results[x-1]
    
    #Games 1-3:

    game1 = play(2,7, result(1))
    game2 = play(3,6, result(2))
    game3 = play(4,5, result(3))

    #Games 4-5:
    rd2 = sorted([1,game1["winner"], game2["winner"], game3["winner"]])

    game4 = play(rd2[0],rd2[3], result(4))
    game5 = play(rd2[1],rd2[2],result(5))

    #Game 6
    rd3 = sorted([game4["winner"], game5["winner"]])

    game6 = play(rd3[0],rd3[1],result(6))

    return f"Team {game6["winner"]} defeated Team {game6["loser"]}"



class ChallengeRunner(unittest.TestCase):

    def test_example_01(self):
        self.assertEqual(whoWins(example_1_out[0]), example_1_out[1])

    def test_example_02(self):
        self.assertEqual(whoWins(example_2_out[0]), example_2_out[1])

    def test_example_03(self):
        self.assertEqual(whoWins(example_3_out[0]), example_3_out[1])

    def test_example_04(self):
        self.assertEqual(whoWins(example_4_out[0]), example_4_out[1])

    def test_example_05(self):
        self.assertEqual(whoWins(example_5_out[0]), example_5_out[1])


if __name__ == '__main__':
    unittest.main()