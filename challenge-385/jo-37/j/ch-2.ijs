#!/usr/local/bin/jconsole

require 'regex'

NB. compile pattern
ph =: rxcomp 0 : 0
(?x)
(?<BP>
  \(
  (?&NP)
  (?:
    (?&BP)
    (?&NP)
  )*
  \)
) (?#)
(?(DEFINE)(?<NP>[^()]*+))
)

NB. behead and curtail all matched substrings
outermost_parentheses =: ph & (}:@}. rxapply) : [:

NB. cheating on example 1: here it has a trailing blank
NB. such that the expected result is not empty
Examples =: cutopen 0 : 0
()()() 
(((())))
(()())(())
()((()))()
(()(()))(()())
)

NB. example 1 provides one trailing space
NB. an empty line would be ignored by "cutopen"
Expected =: cutopen 0 : 0
 
((()))
()()()
(())
()(())()()
)

3 : 0 (2}. ARGV)
if.
    1 = # y
do.
    echo outermost_parentheses 0{:: y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: outermost_parentheses&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-2.ijs STR" to process string'
    echo 'or   "./ch-2.ijs"     to run the examples'
end.
)

exit ''