--# https://theweeklychallenge.org/blog/perl-weekly-challenge-356/
--[[

Task 2: Who Wins

Submitted by: [53]Simon Green
     __________________________________________________________________

   It’s NFL playoff time. Since the 2020 season, seven teams from each of
   the league’s two conferences (AFC and NFC) qualify for the playoffs
   based on regular season winning percentage, with a tie-breaking
   procedure if required. The top team in each conference receives a
   first-round bye, automatically advancing to the second round.

   The following games are played. Some times the games are played in a
   different order. To make things easier, assume the order is always as
   below.

   Week 1: Wild card playoffs
- Team 1 gets a bye
  - Game 1: Team 2 hosts Team 7
  - Game 2: Team 3 hosts Team 6
  - Game 3: Team 4 hosts Team 5
- Week 2: Divisional playoffs
  - Game 4: Team 1 hosts the third seeded winner from the previous week.
  - Game 5: The highest seeded winner from the previous week hosts the second se
eded winner.
- Week 3: Conference final
  - Game 6: The highest seeded winner from the previous week hosts the other win
ner

   You are given a six character string containing only H (home) and A
   away which has the winner of each game. Which two teams competed in the
   the conference final and who won?

Example 1

   [54]NFC Conference 2024/5. Teams were Detroit, Philadelphia, Tampa Bay,
   Los Angeles Rams, Minnesota, Washington and Green Bay. Philadelphia -
   seeded second - won.
Input: $results = "HAHAHH"
Output: "Team 2 defeated Team 6"

In Week 1, Team 2 (home) won against Team 7, Team 6 (away) defeated Team 3 and T
eam 4 (home) were victorious over Team 5. This means the second week match ups a
re Team 1 at home to Team 6, and Team 2 hosted Team 4.

In week 2, Team 6 (away) won against Team 1, while Team 2 (home) beat Team 4. Th
e final week was Team 2 hosting Team 6

In the final week, Team 2 (home) won against Team 6.

Example 2

   AFC Conference 2024/5. Teams were Kansas City, Buffalo, Baltimore,
   Houston, Los Angeles Charges, Pittsburgh and Denver. Kansas City -
   seeded first - won.
Input: $results = "HHHHHH"
Output: "Team 1 defeated Team 2"

Example 3

   [55]AFC Conference 2021/2. Teams were Tennessee, Kansas City, Buffalo,
   Cincinnati, Las Vegas, New England and Pittsburgh. Cincinnati - seeded
   fourth - won.
Input: $results = "HHHAHA"
Output: "Team 4 defeated Team 2"

Example 4

   NFC Conference 2021/2. Teams were Green Bay, Tampa Bay, Dallas, Los
   Angeles Rams, Arizona, San Francisco and Philadelphia. The Rams -
   seeded fourth - won.
Input: $results = "HAHAAH"
Output: "Team 4 defeated Team 6"

Example 5

   [56]NFC Conference 2020/1. Teams were Green Bay, New Orleans, Seattle,
   Washington, Tampa Bay, Los Angeles Rams and Chicago. Tampa Bay - seeded
   fifth - won.
Input: $results = "HAAHAA"
Output: "Team 5 defeated Team 1"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 18th January
   2026.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
--]]
--# solution by pokgopun@gmail.com
--@param string
local function ww(res) --@return string
	local w1 = {{2,7},{3,6},{4,5}}
	local idx = 1
	for i, v in ipairs(w1) do
		if res:sub(idx,idx) == 'H' then
			w1[i] = v[1]
		else
			w1[i] = v[2]
		end
		idx = idx + 1
	end
	table.sort(w1)
	local w2 = {{1,w1[3]},{w1[1],w1[2]}}
	for i, v in ipairs(w2) do
		if res:sub(idx,idx) == 'H' then
			w2[i] = v[1]
		else
			w2[i] = v[2]
		end
		idx = idx + 1
	end
	table.sort(w2)
	if res:sub(6,6) == 'A' then
		w2[1], w2[2] = w2[2], w2[1]
	end
	return string.format("Team %d defeated Team %d", w2[1], w2[2])
end

local lu = require("luaunit")

function TestWw()
	local data = {
		"HAHAHH", "Team 2 defeated Team 6",
		"HHHHHH", "Team 1 defeated Team 2",
		"HHHAHA", "Team 4 defeated Team 2",
		"HAHAAH", "Team 4 defeated Team 6",
		"HAAHAA", "Team 5 defeated Team 1",
	}
	for i=2, #data, 2 do
		local inpt, otpt = data[i-1], data[i]
		lu.assertEquals(ww(inpt),otpt)
	end
end

lu.run()
