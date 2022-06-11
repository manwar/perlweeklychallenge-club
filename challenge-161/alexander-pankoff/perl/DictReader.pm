
package DictReader;
use strict;
use warnings;
use autodie;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use FindBin    ();
use File::Spec ();

use Exporter qw(import);

our @EXPORT_OK = qw(read_dict);

use constant DICTIONARY =>
  File::Spec->catfile( $FindBin::RealBin, qw/.. .. .. data dictionary.txt/ );

sub read_dict() {
    my @dict = slurp(DICTIONARY);
}

sub slurp($file) {
    open( my $fh, '<', $file );
    chomp( my @in = <$fh> );
    close $fh;
    return @in;
}

1;
