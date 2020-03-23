my %rules =
    :a('e','i'),
    :e('i'),
    :o('a','u'),
    :u('e','o'),
    :i('a','e', 'o', 'u')
;

sub MAIN(Int $n)
{
    .say for gather {
        build-str( $_, $n )
            for %rules.keys.sort;
    }
}

sub build-str( $current, $n )
{
    my $last = $current.substr( * - 1 );

    for |%rules{ $last }
    {
        given $current ~ $_
        {
            take $_ and next if .chars == $n;
            build-str( $_, $n );
        }
    }
}