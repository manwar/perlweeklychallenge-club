sub f {
    join ' ',
    map $$_[0],
    sort { $$a[1] cmp $$b[1] }
    map [ $_, uc ],
    split /\s+/, shift
}

print f($$_[0]) eq $$_[1] ? "ok\n" : "ERROR\n" for

    [  "The quick brown fox"
     =>"brown fox quick The"],

    [  "Hello    World!   How   are you?"
     =>"are Hello How World! you?"],

    [  "Hello"
     =>"Hello"],

    [  "Hello, World! How are you?"
     =>"are Hello, How World! you?"],

    [  "I have 2 apples and 3 bananas!"
     =>"2 3 and apples bananas! have I"]
