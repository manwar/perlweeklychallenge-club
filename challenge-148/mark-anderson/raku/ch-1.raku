#!/usr/bin/env raku

use Lingua::EN::Numbers;

.say for (^101).map(&cardinal).grep({.index('e') ~~ Nil});
