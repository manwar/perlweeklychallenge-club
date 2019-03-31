for 1..20 { say join "", gather { take "Fizz" if $_ %% 3; take "Buzz" if $_ %% 5; } || $_ }
