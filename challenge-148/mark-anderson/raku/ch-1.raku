#!/usr/bin/env raku

use Lingua::EN::Numbers;

.say for (^101).grep({ not cardinal($_).contains('e') });
