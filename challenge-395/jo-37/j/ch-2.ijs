#!/usr/local/bin/jconsole

word_square =: _(adverb define)

  NB. create prefix from head:
  NB. n-th character from each word in the head
  prefix =. #@] { [: |: ]

  NB. select words starting with the prefix
  start_with =. [ #~ {.@E."1~

  NB. create new candidate heads:
  NB. append each candidate word to the current head
  combine =. ,"_ 1

  NB. check if y is not empty
  has_items =. *@#@]

  NB. check if solution is complete:
  NB. there is a head candidate and
  NB. its number of words equals the word length
  is_complete =. (*@{. *. =/@}.)@$@]

  NB. provide the (first) full solution
  final =. {.@]

  NB. call self recursively,
  NB. box the result and return it on success or
  NB. pass the word array otherwise
  recur =. ] [`(<@])@.has_items $:

  NB. post-process loop results:
  NB. terminate and return unboxed result on success
  NB. otherwise return empty
  term =. {{
    is_boxed =. * L. y
    1 Z: is_boxed
    (''"_)`>@.is_boxed y
  }}

  NB. loop over all head candidates
  loop =. term F.. (recur f.)

  NB. empty 2-d array
  empty =. 0 1 $ ''

  NB. as a monad:
  NB. - provide an empty head and call the dyad
  NB. as a dyad:
  NB. - create the prefix from the head
  NB. - find candidate words starting with the with the prefix
  NB. - create a new head from each candidate by appending it to the old head
  NB. - check if the candidate head(s) form a complete solution:
  NB.   * return the first candidate head if it is complete
  NB.   * loop over all candidate heads, using each as an argument for
  NB.     a recursive call
  empty&$: : (([ (loop f.)`final@.is_complete ] combine [ start_with prefix)~ f.)
)

Examples =: > L:1 cutopen L:0 cutopen 0 : 0
MA AM MY ME
SUN USE NET SEE TEN
BOAT TEAL AREA TSAR OGRE
CARD AREA REAR DART
HEART TREND EMBER RESIN ABUSE
)

Expected =: > L:1 cutopen L:0 cutopen 0 : 0
MA AM
SUN USE NET
BOAT OGRE AREA TEAL
CARD AREA REAR DART
HEART EMBER ABUSE RESIN TREND
)

3 : 0 (2}. ARGV)
if.
    1 <: # y
do.
    echo word_square > y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: word_square&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs STR..." to process strings'
    echo 'or   "./ch-2.ijs"        to run the examples'
end.
)

exit ''