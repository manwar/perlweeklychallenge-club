use v6;

gather {take $_ %% 5 ?? ($_ %% 3 ?? "fizz buzz" !! "buzz") !! ($_ %% 3 ?? "fizz" !! $_) for 1..∞}[^20]».say;

say '=' x 79;

# then as (a slightly shorter) one liner, though it was nice to showcase %% as it more closely reflected the question. But one liners should be short, yes?
# perl6 -e 'gather {take $_ % 5 ?? ($_ % 3 ?? $_ !! "fizz") !! ($_ % 3 ?? "buzz" !! "fizz buzz") for 1..∞}[^20]».say'
gather {take $_ % 5 ?? ($_ % 3 ?? $_ !! "fizz") !! ($_ % 3 ?? "buzz" !! "fizz buzz") for 1..∞}[^20]».say;


