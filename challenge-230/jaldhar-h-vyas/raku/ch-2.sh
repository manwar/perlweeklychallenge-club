#!//bin/sh

raku -e 'my$p=@*ARGS.shift;@*ARGS.grep({/^$p/}).elems.say' "$@"
