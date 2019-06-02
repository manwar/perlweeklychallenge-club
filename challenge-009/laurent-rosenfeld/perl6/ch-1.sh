perl6 -e 'say $_ ** 2 and last if ($_**2).comb.unique >= 5 for 100..*'
