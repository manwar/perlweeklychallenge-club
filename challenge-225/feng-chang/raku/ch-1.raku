#!/bin/env raku

unit sub MAIN(*@sentences);

put @sentences».words».elems.max;
