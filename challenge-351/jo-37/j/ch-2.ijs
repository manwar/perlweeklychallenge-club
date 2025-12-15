#!/usr/local/bin/jconsole

load 'math/lapack2'

mrank =: 3 : 0
    1e_10 mrank y
:
    assert. 2 = #@$ y
    'xS xU xVt xWork xInfo' =. 6 7 9 11 14
    'r c' =.   $ y
    caJobz =.  ,'A'                 NB. computing option
    iM =.      ,r                   NB. rows
    iN =.      ,c                   NB. cols
    iLda =.    iM                   NB. leading dim of A
    dmA =.     |: y                 NB. A, (LDA, N)
    daS =.     (iM <. iN) $ 0.      NB. S, (min(M, N))
    iLdu =.    iM                   NB. leading dim of U
    dmU =.     (iLdu, iM) $ 0.      NB. U, (LDU, M)
    iLdvt =.   iN                   NB. leading dim of VT
    dmVt =.    (iLdvt, iN) $ 0.     NB. VT (LDVT, N)
    iLwork =.  ,_1                  NB. dim of WORK
    daWork =.  (1 >. iLwork) $ 0.   NB. workspace (LWORK)
    iaIwork =. (8 * (iM <. iN)) $ 0 NB. internal workspace (8*min(M, N))
    iaInfo =.  ,_1                  NB. info

    ret =. dgesdd_jlapack2_ caJobz; iM; iN; dmA; iLda; daS; dmU; iLdu; dmVt; iLdvt; daWork; iLwork; iaIwork; iaInfo
    'daWork iaInfo' =. (xWork, xInfo) { ret
    NB. echo daWork; iaInfo
    assert. 0 = >iaInfo
    iLwork =. ,0 { daWork
    daWork =. (1 >. iLwork) $ 0.
    iaInfo =. ,_1 NB. info
    ret =. dgesdd_jlapack2_ caJobz; iM; iN; dmA; iLda; daS; dmU; iLdu; dmVt; iLdvt; daWork; iLwork; iaIwork; iaInfo
    'daS dmU dmVt iaInfo' =. (xS, xU, xVt, xInfo) { ret
    NB. echo dmU; daS; dmVt; iaInfo
    assert. 0 = >iaInfo
    NB. sigma =. (i. (0 { $ dmU)) =/ (i. (0 { $ dmVt))
    NB. sigma =. sigma * (0 { $ sigma) $ daS
    NB. dot =. +/ . *
    NB. echo (|: dmU) dot sigma dot (|: dmVt)
    +/ x < | daS
)

ArithProg =: {{1 = 1e_14 mrank (}. -"1 {.) |: (,: ((] i.~ /:~) i.@#)) y}}

NB. numerize and listify inside boxes
Examples =: ".&.> cutopen 0 : 0
1 3 5 7 9
9 1 7 5 3
1 2 4 8 16
5 _1 3 1 _3
1.5 3 0 4.5 6
)

3 : 0 ".&> 2}. ARGV
if.
    3 <: # y
do.
    1 = mrank (}. -"1 {.)  |: (,: i.@#)@:/:~ y
    echo ArithProg y
elseif.
    0 = # y
do.
    try.
        assert. (1; 1; 0; 1; 1) -: ArithProg &.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs N..." to process numbers'
    echo 'or   "./ch-1.ijs"      to run the examples'
end.
)

exit ''
