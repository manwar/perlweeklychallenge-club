#!/usr/bin/env raku

use Prime::Factor;

.say for (1..500).grep({ not prime-factors($_).repeated });
