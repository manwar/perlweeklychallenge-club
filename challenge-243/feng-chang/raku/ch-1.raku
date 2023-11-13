#!/bin/env raku

unit sub MAIN(*@nums);

put +(^+@nums).combinations(2).grep({ @nums[.[0]] > 2 * @nums[.[1]] });
