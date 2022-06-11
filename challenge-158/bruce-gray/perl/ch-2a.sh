perl -Mntheory=:all -wE 'say join ", ", grep { is_prime $_ } map { ($_ + 1)**3  -  $_**3 } 0..20'
