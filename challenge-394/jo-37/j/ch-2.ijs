#!/usr/local/bin/jconsole

require 'regex'

rcvc =: rxcomp 0 : 0
(?xi-ms)
  (
    (?&VOW)(?:(?&CONS)(?&VOW))*(?&CONS)?
    |
    (?&CONS)(?:(?&VOW)(?&CONS))*(?&VOW)?
    |
    \n(*COMMIT)(*FAIL)
  ) #
  .*+
  (?: \n .*? \1 .*+)++ $
  (?(DEFINE)
    (?<VOW>[aeiou])
    (?<CONS>[^aeiou\n])
  ) #
)

alt_vow_cons =: _(adverb define)
  NB. find the first common alternating subsequence
  first_alt =. {{
    in =. 0 {:: y
    match =. rcvc rxmatch in
    NB. terminate loop if not matching
    _2 Z: 0 > (<0 0){match
    NB. get next string to process from match x and
    NB. current string y
    next =. >:@{.@[ }. ]
    NB. return next string and captured
    NB. common alternating subsequence
    (1{match) (next ; rxfrom) in
  }}
  NB. join words with NL,
  NB. find all common alternating subsequences and
  NB. return empty on error
  all_alt =. ([: ({: F: first_alt) [: < LF joinstring ]) :: a:
  NB. find all entries having the maximum length
  max_len =. ([: I. >./ = ])@(# S:0) { ]

  NB. find all common alternating subsequences,
  NB. restrict to unique values and
  NB. select maximal lengths
  (max_len @ ~. @ all_alt) f. : [:
)

Examples =: cutopen L:0 cutopen 0 : 0
relocate delocate allocate
apple banana cherry
navigate cavity gravity
pedalgia pedalboard pedantic
schoolmaster schoolhouse schooling
)

Expected =: <;._2 L:0 cutopen 0 : 0
locate 
 
avi 
peda 
ho ol 
)

3 : 0 (2}. ARGV)
if.
    1 < # y
do.
    echo alt_vow_cons y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: alt_vow_cons&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs W..." to process strings'
    echo 'or   "./ch-2.ijs"      to run the examples'
end.
)

exit ''