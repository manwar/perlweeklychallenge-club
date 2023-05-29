use strict;
use warnings;

sub canonical_path {
    my ($path) = @_;
    my @path_parts = split( '/', $path );
    my @canonical_parts;
    for my $part (@path_parts) {
        if ( $part eq '..' ) {
            if (@canonical_parts) {
                pop @canonical_parts;
            }
        }
        elsif ( $part && $part ne '.' ) {
            push @canonical_parts, $part;
        }
    }
    return '/' . join( '/', @canonical_parts );
}

# Testing
print canonical_path("/a/./b/../../c/"), "\n";    # Outputs: "/c"
