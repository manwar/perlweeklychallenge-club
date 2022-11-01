sub greater-char ($target, @input) {
    return @input.grep({ $_ gt $target }).min;
}
for ('b', <e m u g>), ('a', <d c e f>), ('o', <j a r>),
    ('a', <d c a f>), ('v', <t g a l>)  ->  ($k, @test) {
    say "$k, (@test[]) \t -> ", greater-char($k, @test);
}
