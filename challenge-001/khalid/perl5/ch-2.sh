perl -e 'use 5.010;no warnings 'experimental';for (1..20){ given ($_){ when(! ($_ % 15) ){ say 'fizzbuzz'}when(! ($_ % 3 )){ say 'fizz';}when(! ($_ % 5) ){say 'buzz'}default {say $_;}}}'
