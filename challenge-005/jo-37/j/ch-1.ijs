#!/usr/local/bin/jconsole

anagrams =: _(adverb define)
  uniq_lower =. ~. @ (tolower L:0)
  sort_letters =. /:~&.>

  [: : (<@[ (=&sort_letters # ]) uniq_lower@])~ f.
)

dict =: '/usr/share/dict/words'

3 : 0 (2}. ARGV)
if.
    1 2 e.~ #y
do.
    try.
        echo (cutopen @ fread @ ((dict"_)`(1&{::)@.(2&=@#)) y) anagrams 0 {:: y
    catch.
        echo 'execution failed:', LF, 13!:12 ''
    end.
else.
    echo 'Call "./ch-1.ijs WORD [DICT]" to find anagrams of WORD in DICT'
end.
)

exit ''
