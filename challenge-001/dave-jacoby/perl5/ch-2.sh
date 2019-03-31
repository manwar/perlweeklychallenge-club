perl -e 'for (1..20) { print $_ % 3 ? "" : "fizz" ; print $_ % 5 ? "" : "buzz" ; print $_ % 3 && $_ % 5 ? $_ : "" ; print "\n" }'
