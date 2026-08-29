DyckWords←{
	⍺=0: 1 ⍵⍴'D'
	u←'U',(⍺-1)∇⍵
	⍺=⍵: u
	u⍪'D',⍺∇⍵-1
}⍨

⎕←DyckWords 1
⎕←DyckWords 2
⎕←DyckWords 3
⎕←DyckWords 0
⎕←DyckWords 4
