#!/usr/local/bin/jconsole

cut =. ((-^:)@[ ({. ; }.) ])"0 _
sizes =. >:@i.@<:@#
cuts =. sizes@] (0 cut , 1 cut) ]
shape =. ] </.~ [: #&(0,1) ;@:($&.>)@[
recurpart =. $:&(&{::)
check =. (1 recurpart)^:(a: -: (0 recurpart))
nextIfNotDone =. (}.@[)^:(-.@(a:&-:)@])
first =. {.@]
whileToDo =. (^:(*@#@] *. -.@(a:&-:@])))^:_.
ifEq =. @.(-:)
done =. a:"_

NB. "boxed empty" (a:) will be used to signal success in this implementation.
NB. signal "done" if x and y are equal
NB. otherwise loop over all valid cuts y1;y2 of y, bring x into the same shape x1;x2 as the cut
NB. check if x1 / y1 and x2 / y2 are scrambled
NB. loop while the current cut is not scrambled and more cuts are available
NB. return boxed empty on success, empty otherwise
NB. counting the result's items produces zero/one as boolean result
scrambled =: ([ (] nextIfNotDone f. [ (shape~ f. check f. ]) first f.) whileToDo cuts f.)`(done f.) ifEq

Examples =: '|'&cutopen&.> cutopen 0 : 0
abc|acb
abcd|cdba
hello|hiiii
ateer|eater
abcd|bdac
)

Expected =: 1; 1; 0; 1; 0

3 : 0 (2}. ARGV)
if.
    2 = # y
do.
    echo # scrambled/&:> y
elseif.
    0 = # y
do.
    try.
        assert Expected -: #@:(scrambled/)&:>&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs A B" to process strings'
    echo 'or   "./ch-1.ijs"     to run the examples'
end.
)

exit ''