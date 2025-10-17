⎕IO←0

ChampionTeam←{
	grid←⍵

	⍝ get dag of just champions
	champs←⍸(⊢=⌈/)+/grid
	grid←grid[champs;champs]

	⍝ toposort
	n←≢grid
	sorted←⍬ ⍝ stores *reversed* toposort
	visited←n⍴0
	DFS←{
		visited[⍵]: 1
		visited[⍵]←1
		_←DFS¨⍸grid[⍵;]
		sorted,←⍵
		1
	}
	_←DFS¨⍳n

	⍝ take the strongest champion
	champs[⊃⌽sorted]
}

⎕←ChampionTeam↑(0 1 1)(0 0 1)(0 0 0)
⎕←ChampionTeam↑(0 1 0 0)(0 0 0 0)(1 1 0 0)(1 1 1 0)
⎕←ChampionTeam↑(0 1 0 1)(0 0 1 1)(1 0 0 0)(0 0 1 0)
⎕←ChampionTeam↑(0 1 1)(0 0 0)(0 1 0)
⎕←ChampionTeam↑(0 0 0 0 0)(1 0 0 0 0)(1 1 0 1 1)(1 1 0 0 0)(1 1 0 1 0)
