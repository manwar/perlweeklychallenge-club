load 'math/calculus'
D := pderiv_jcalculus_

nums =: > ".&.> 0 2 {"1 ;: > cutopen fread 'wc_input'

NB. initial weights
w =: 2 ?@$ 0

NB. E[X]
M =: +/%#

NB. Sigma[X] = sqrt E[X^2] - E[X]^2
S =: [: %: (M@:*: - *:@:M)

NB. standard scaling (X - E[X]) / Sigma[X]
std =: (] -"1 M) %"1 S

'X Y' =: <"1 |: std nums

loss =: [: M [: *: Y - (X p.~ ])

lr =: 0.1 NB. learning rate
learn =: ] - lr * (loss D 1)

NB. to run until convergence
NB. learn^:_ w