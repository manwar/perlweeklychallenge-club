say "Open rooms: ", (1..^500).grep({ 
    is-open( $_ ) 
}).join(",");

sub is-open( $i )
{
    my $status = !($i %% 2);
    $status = !$status if $i %% $_ for 3, 4;
    $status;
}
