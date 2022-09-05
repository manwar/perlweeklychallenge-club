use v6.d;
use Test;

my $par = q:to[END];
    All he could think about was how it would all end. There was
    still a bit of uncertainty in the equation, but the basics
    were there for anyone to see. No matter how much he tried to
    see the positive, it wasn't anywhere to be seen. The end was
    coming and it wasn't going to be pretty.
    END
(my $sorted = q:to[END]) ~~ s:g/\s+/ /;
    about All all could end he how it think was would. a anyone
    basics bit but equation, for in of see still the the There
    there to uncertainty was were. anywhere be he how it matter
    much No positive, see seen the to to tried wasn't. and be
    coming end going it pretty The to was wasn't.
    END

my sub paragraph-sorted(Str:D $_) {
    .split(/\.\s*/).map({.words.sort(*.lc)}).join(". ")
}

plan 1;
is $sorted, paragraph-sorted $par;
done-testing