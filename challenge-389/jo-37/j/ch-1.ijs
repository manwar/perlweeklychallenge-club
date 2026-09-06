#!/usr/local/bin/jconsole

NB. process the given melody that is represented as a list of three
NB. boxed elements:
NB. - composer
NB. - notes: a list of boxed notes
NB. - permutation
reorder_notes =: _(adverb define)
  NB. verbs to fetch composer, notes and permutation from melody
  '`composer notes perm' =. (0&{::)`(1&{::)`(2&{::)

  NB. - sort notes using perm
  NB. - join reordered notes with blanks, opening boxes
  NB. - prepend composer converted to upper case
  (toupper@composer , ' => ' , ' ' joinstring  notes /: perm) f. : [:
)

Composers =. ;: 'Bach Beethoven Brahms Bruckner Berg'
Notes =. cutopen L:0 cutopen 0 : 0
C D E F# G A B
C D F# G Ab
C Db Eb F G Ab Bb C D
G F# Bb C D Eb F
C#
)
Permutations =. ". L:0 cutopen 0 : 0
7 1 6 2 5 3 4
1 3 5 2 4
9 3 7 1 8 5 2 6 4
4 7 2 6 1 5 3
1
)
Examples =: <"1 Composers ,. Notes ,. Permutations
Expected =: cutopen 0 : 0
BACH => D F# A B G E C
BEETHOVEN => C G D Ab F#
BRAHMS => F Bb Db D Ab C Eb G C
BRUCKNER => D Bb F G Eb C F#
BERG => C#
)

3 : 0 (2}. ARGV)
if.
    3 = # y
do.
    echo reorder_notes (0&{ , <@cutopen@(1&{::) , <@".@(2&{::)) y
elseif.
    0 = # y
do.
    try.
        assert. Expected -: reorder_notes&.> Examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs C N P" to process composer, notes and permutation'
    echo 'or   "./ch-1.ijs"       to run the examples'
end.
)

exit ''