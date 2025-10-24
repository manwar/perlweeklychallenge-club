⍝ assumes no ⍬s in source, chance of an infinite loop!
ArrayFormation←{
	source←,¨⍺                         ⍝ facilitate passing scalars
	target←⍵
	0=≢target: 1                       ⍝ if we built the whole target, we are done
	starters←⍸(⊢≡≢↑target⍨)¨source     ⍝ which source lists are prefixes of target
	0=≢starters: 0                     ⍝ if there are no prefixes, we can't build the target
	DoSuffix←{                         ⍝ recurse, expending a prefix
		target←target↓⍨≢⍵⊃source       ⍝ drop found prefix from target
		source←source/⍨0@⍵⊢1⍴⍨≢source  ⍝ delete index ⍵ from sources, this is yucky why isn't there a primitive for this
		source ArrayFormation target
	}
	∨/DoSuffix¨starters                ⍝ any choice works
}

⎕←(2 3) 1 4     ArrayFormation 1 2 3 4
⎕←(1 3) (2 4)   ArrayFormation 1 2 3 4
⎕←(9 1) (5 8) 2 ArrayFormation 5 8 2 9 1
⎕←1 3           ArrayFormation 1 2 3
⎕←⊂7 4 6        ArrayFormation 7 4 6
