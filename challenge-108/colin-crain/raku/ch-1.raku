unit sub MAIN () ;

my $foo = 42;

say $foo;
say $foo.WHERE.base(16);

my $bar = $foo;
say "they're the same of course" if $bar.WHERE == $foo.WHERE;

