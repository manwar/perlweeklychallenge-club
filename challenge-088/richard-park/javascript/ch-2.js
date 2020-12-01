// Translation of {0∊⍴⍵:⍬ ⋄ (1⌷⍵),∇⍉⌽1↓⍵}
I = n => [...Array(n).keys()]   // Iota ⍳
R = a=>a.map((e,i)=>a[a.length-i-1])   // Reverse ⊖
T = m => {   // Transpose ⍉
	let r=m.length;let c=m[0].length; var a=[]
	return I(c).map((e,i)=>I(r).map((_,j)=>m[r-j-1][i])).map(R)
}
SpiralMatrix = m => 1==m.length?m[0]:m[0].concat(SpiralMatrix(T(m.slice(1,).map(R))))
