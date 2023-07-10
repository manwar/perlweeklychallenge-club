use strict;
use warnings;
use File::Slurp;

my @dirs = ( 'dir_a', 'dir_b', 'dir_c' );
my %all_files;

foreach my $dir (@dirs) {
    my @files = read_dir($dir);
    foreach my $file (@files) {
        push @{ $all_files{$file} }, $dir;
    }
}

foreach my $file ( keys %all_files ) {
    if ( scalar @{ $all_files{$file} } != scalar @dirs ) {
        print "$file is missing in ",
          join( ", ", grep { not $_ ~~ @{ $all_files{$file} } } @dirs ), "\n";
    }
}
