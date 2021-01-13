perl6 -e '

([Z] (
    [qw{ P + 2 l ! a t o }],
    [qw{ 1 e 8 0 R $ 4 u }],
    [qw{ 5 - r ] + a > / }],
    [qw{ P x w l b 3 k \ }],
    [qw{ 2 e 3 5 R 8 y u }],
    [qw{ < ! r ^ ( ) k 0 }],
)).map({ .sort.join.match(/ (.)$0 /); $0 }).join.say;

'