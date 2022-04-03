perl -Mntheory=:all -wE 'say join ", ", grep { is_prime sumdigits $_ } primes(100)->@*'
