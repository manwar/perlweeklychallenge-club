#!/bin/env raku

put [+] prompt('Array @a: ').words».Int »*«
        prompt('Array @b: ').words».Int;
