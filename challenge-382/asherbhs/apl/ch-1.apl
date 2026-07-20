⎕IO←1

⍝ lexical scope is for nerds

∇ r←DFS;next
	r←⍬
	next←path⊢/⍛⊃graph
	:If n=≢path
		r←path⊣⍣(1∊next)⊢⍬
		:Return
	:End
	:For next :In next~path
		path,←next
		r←DFS
		path↓⍨←¯1
		:If ×≢r ⋄ :Return ⋄ :End
	:End
∇

∇ r←HamiltonianCycle n;graph
	graph←⍸¨↓(∘.+⍨∊×⍨)⍳n
	path←1
	r←DFS
∇

⎕←HamiltonianCycle 32
⎕←HamiltonianCycle 15
⎕←HamiltonianCycle 34
