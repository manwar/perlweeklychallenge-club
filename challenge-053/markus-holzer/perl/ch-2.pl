use Modern::Perl;
use feature qw( signatures postderef switch );
no warnings qw( experimental );

my %rules = (
    a => [ 'e', 'i'           ],
    e => [ 'i'                ],
    i => [ 'a', 'e', 'o', 'u' ],
    o => [ 'a', 'u'           ],
    u => [ 'e', 'o'           ],
);

main( shift @ARGV || 2 );

sub main( $n )
{
    my @r;

    build_str( $_, $n, \@r )
        for ( sort keys %rules );

    print join "\n", @r;
}

sub build_str( $current, $n, $result )
{
    my $last = substr( $current,  -1 );

    for ( $rules{ $last }->@* )
    {
        given ( $current . $_ )
        {
            push $result->@*, $_ and next
                if length($_) == $n;

            build_str( $_, $n, $result );
        }
    }
}