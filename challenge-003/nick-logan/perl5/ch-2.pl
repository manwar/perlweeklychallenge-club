# WARNING: this polyglot breaks best practices of both Perl 5 and Perl 6 in order to run on both

my @ARGV = do { sub eval { &EVAL(@_) }; eval( ("0" and q|@*ARGS| or q|@ARGV|) ) };

my @state = (1,);
for (1 .. @ARGV[0]) {
    print(join(" ", @state), "\n");
    my @row = map &{ sub ($_) { @state[$_] + (@state[$_ + 1] // 0) } }.(), (0 .. ($_ - 2));
    @state = ();
    push(@state, 1);
    push(@state, $_) for @row;
    push(@state, 1);
}
