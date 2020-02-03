say "Open rooms: \n", (1..^500).grep({ 
    is-open( $_ ) 
}).join(",");

sub is-open( $i )
{
    my $is-open = !($i %% 2);
    $is-open = !$is-open if $i %% $_ for 3 .. 500;
    $is-open;
}

# Open rooms: 1,4,9,16,25,36,49,64,81,100,121,144,169,196,225,256,289,324,361,400,441,484
