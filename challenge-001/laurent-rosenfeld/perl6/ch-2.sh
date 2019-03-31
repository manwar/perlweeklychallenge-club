# throws error
# ===SORRY!=== Error while compiling -e
# Two terms in a row
# at -e:1
perl6 -e "for 1..20 -> $c { say $c %% 15 ?? 'fizz buzz' !! $c %% 3 ?? 'fizz' !! $c %% 5 ?? 'buzz' !! $c;}"
