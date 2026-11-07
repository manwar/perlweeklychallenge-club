#!/usr/local/bin/jconsole

NB. enumerate all compositions of x in y parts
comp=: 4 : 0
 if. 1 >: x do. ((x>:&*y),x)$y
 else.
  c=. (x-2)!(x-2)+|.k=. i.1+y
  (c#k) ,. ((x-1){."0 c#-k) + (-1+;i.&.>-c) { (x-1) comp y
 end.
)

NB. Cardano Triplets having a sum of y + 3
cardano_s =: _(adverb define)
  NB. the Cardano term with a placeholder for the inner operation +/-
  '`a b c' =. (0&{)`(1&{)`(2&{)
  cubrt =. * * 3&%:@|
  card =. [:`cubrt`a`]:`b`*`(%:@c)`:6

  NB. sum of both terms
  csum =. (+ card + - card)"1

  NB. generate all triplets as incremented compositions and
  NB. select Cardano Triplets
  (] #~ 1 = csum) @: >: @ (3&comp) f.
)

NB. - loop over sizes and collect results while less
NB.   than x triplets have been found
NB. - provide a monad with a suitable start argument
cardano =: _(adverb define)
  '`size triplets' =. (0&{::@])`(1&{::@])
  init =. 0 ; 0 3 $ 0
  while =. ^:^:_.

  $:&init : ((>:@size ; triplets , cardano_s @ size) while (> #@triplets) f.)
)

3 : 0 (2 }. ARGV)
if.
    1 = # y
do.
    try.
        echo 1{:: cardano 0 ". 0{:: y
    catch.
        echo 'execution failed:', LF, 13!:12 ''
    end.
else.
    echo 'Call "./ch-2.ijs N" to print N Cardano Triplets'
end.
)

exit ''
