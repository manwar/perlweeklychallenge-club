#!/usr/bin/env raku
use Text::Wrap;
$*COLLATION.set: :tertiary(Less);

sub sentence-order ($s) {
   $s
   andthen .split: '.'
   andthen .map: *.words
   andthen .map: *.collate
   andthen .join: ". "
   andthen .&wrap-text: :60width;
}

multi MAIN (Bool :test($)!) {
    use Test;
    is sentence-order(
        q{All he could think about was how it would all end. There was
         still a bit of uncertainty in the equation, but the basics
         were there for anyone to see. No matter how much he tried to
         see the positive, it wasn't anywhere to be seen. The end was
         coming and it wasn't going to be pretty.
       }),
    wrap-text(
      q{about All all could end he how it think was would. a anyone
        basics bit but equation, for in of see still the the There
        there to uncertainty was were. anywhere be he how it matter
        much No positive, see seen the to to tried wasn't. and be
        coming end going it pretty The to was wasn't.
       },
       :60width
    );
    done-testing;
}

multi MAIN () {
    say sentence-order slurp
}
