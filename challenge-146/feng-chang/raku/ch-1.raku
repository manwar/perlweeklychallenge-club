#!/bin/env raku

put (2..∞).grep(*.is-prime)[100_00];
