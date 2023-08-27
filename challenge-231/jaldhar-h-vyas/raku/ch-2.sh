#!//bin/sh

raku -e '@*ARGS.map({/.**11(..)/;$0}).grep({$_>=60}).elems.say' "$@"