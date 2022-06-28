sub concat { join "_", @_}
sub triple { map {$_ * 3}, @_ }
sub compose (&h1, &h2) {
    &h1 ∘ &h2; # h1 will be called with the return value of h2
}
my &composed = compose(&concat, &triple);
say composed <2 4 6 8>;
