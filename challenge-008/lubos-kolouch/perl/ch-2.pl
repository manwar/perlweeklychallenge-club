sub center {
    my @lines = @_;

    # Find the maximum length of the lines
    my $max_length = 0;
    foreach my $line (@lines) {
        my $length = length($line);
        if ( $length > $max_length ) {
            $max_length = $length;
        }
    }

    # Center each line by adding spaces at the beginning
    my @centered_lines;
    foreach my $line (@lines) {
        my $padding       = ( $max_length - length($line) ) / 2;
        my $centered_line = ' ' x int($padding) . $line;
        push @centered_lines, $centered_line;
    }

    return @centered_lines;
}

print( center( "This", "is", "a test of the", "center function" ) );
