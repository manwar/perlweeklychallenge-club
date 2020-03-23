my %rules =
        :a({ $_ ~~ 'i'|'o'     }),
        :e({ $_ ~~ 'a'|'i'|'u' }),
        :i({ $_ ~~ 'a'|'e'     }),
        :o({ $_ ~~ 'i'|'u'     }),
        :u({ $_ ~~ 'o'|'i'     })
;

my @vowels = <a e i o u>;

sub MAIN(Int $n)
{
    .say for gather { build-str( $n, $_ ) for @vowels }
}

multi sub build-str( $n, $current )
{
    my $last = $current.substr( * - 1, 1 );

    for @vowels
    {
        next
            unless %rules{ $_ }( $last );

        given $current ~ $_
        {
            take $_ and next
                    if .chars == $n;

            build-str( $n, $_ );
        }
    }
}