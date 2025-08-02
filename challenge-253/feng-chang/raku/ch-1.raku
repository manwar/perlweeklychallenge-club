#!/bin/env raku

unit sub MAIN($sep, *@strings);

put @strings».split($sep, :skip-empty).flat.grep(?*).join(' ');
