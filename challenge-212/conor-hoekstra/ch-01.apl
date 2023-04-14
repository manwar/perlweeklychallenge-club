LetterJump ← {
    n ← ⎕UCS⍵
    m ← 65+32×97≤n
    ⎕UCS m+26|⍺+n-m 
}

⍝ Tests
2 22 19 9 LetterJump 'Perl' ⍝ Raku
24 4 7 17 LetterJump 'Raku' ⍝ Perl
