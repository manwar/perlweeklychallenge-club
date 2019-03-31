perl6 -e 'for 1..20 { ($_ %% 3, $_ %% 5, $_ gcd 15 == 1 Z&& <fizz>,
<buzz>, $_).grep(&so).join(Q/ /).say }'
