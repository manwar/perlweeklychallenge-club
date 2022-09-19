sub f($n) { $n / 2 + 1}
sub g($n) { $n * 2 }
sub compose (&h1, &h2) {
    &h1 ∘ &h2; # h1 will be called with the return value of h2
    # could also be written: &h1 o &h2;
}
my &composed = compose(&f, &g);
say composed 2;
