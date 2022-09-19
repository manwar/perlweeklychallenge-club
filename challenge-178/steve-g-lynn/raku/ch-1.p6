#!/usr/bin/env perl6

use Base::Any;

say 4.&to-base( 2i); #10300
say (-15).&to-base( 2i); #1030001

say (35+23i).&to-base( 2i); #121003.2





