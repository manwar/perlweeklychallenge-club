#!/usr/local/bin/jconsole

max_anagrams =: _(adverb define)
  uniq_lower =. ~. @ (tolower L:0)
  sort_letters =. /:~ L:0
  frequency =. ({. ; #)/.~
  max_by =. [ #~ ] = >./@]
  (max_by&:>/ @ |: @ frequency @ sort_letters @ uniq_lower) f. : [:
)

dict =: '/usr/share/dict/words'

3 : 0 (2}. ARGV)
if.
    1 >: # y
do.
    try.
        echo max_anagrams cutopen fread (dict"_)`(0&{::)@.(*@#) y
    catch.
        echo 'execution failed:', LF, 13!:12 ''
    end.
else.
    echo 'Call "./ch-2.ijs [DICT] to process dictionary'
end.
)

exit ''
