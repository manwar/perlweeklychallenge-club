#!/bin/sh

raku -e 'my%a=@*ARGS[0].words.Bag;my%b=@*ARGS[1].words.Bag;(%a∩%b).keys.grep({%a{$_}==%b{$_}}).elems.say' "$@"
