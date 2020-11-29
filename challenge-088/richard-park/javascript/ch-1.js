// Inspired by {×/⍵⌷⍤1 99⍨↑(⊢~⍥,⍤99 0⊢)⍳⍴⍵}
RemoveFrom=(a,i)=>a.slice(0,i).concat(a.slice(i+1,))
I = n => [...Array(n).keys()]
P = a => a.reduce((x,y)=>x*y)
ArrayOfProduct=a=>I(a.length).map(i=>P(RemoveFrom(a,i)))
