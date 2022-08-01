#!/usr/bin/env raku

say (^100).grep({ $_ + .flip !~~ /<[02468]>/ });
