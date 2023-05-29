use strict;
use warnings;

sub display_lines {
    my ( $file_name, $a, $b ) = @_;
    open my $file, '<', $file_name or die "Could not open '$file_name': $!";
    my @lines = <$file>;
    print @lines[ $a - 1 .. $b - 1 ];
    close $file;
}

# Suppose 'input.txt' is a file in the same directory with content as described in the problem
display_lines( 'input.txt', 4, 12 );
