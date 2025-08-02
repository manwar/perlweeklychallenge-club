#!/bin/env raku

unit sub MAIN(*@ints);

put so (^@ints).grep({ [<] @ints[(^@ints).grep(*!=$_)] });
