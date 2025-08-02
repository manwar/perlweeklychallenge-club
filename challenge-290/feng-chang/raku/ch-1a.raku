#!/bin/env raku

unit sub MAIN(*@ints);

put so (^+@ints).grep({ @ints[|^$_, |$_^*].grep(2*@ints[$_]) });
