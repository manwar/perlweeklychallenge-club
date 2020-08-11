use strict;
use warnings;
use Getopt::Std;

my %args = (
);
getopts( 'e:s:', \%args );
my $file = shift @ARGV;
die "Please specify a file.\n" unless $file;
die "File $file does not exist.\n" unless -e $file;
die "Please specify a positive integer for -s.\n" if $args{s} && $args{s} !~ m/^\d+$/;
die "Please specify a positive integer for -e.\n" if $args{e} && $args{e} !~ m/^\d+$/;

open( my $fh, '<', $file ) or die "Could not open file $file - $!\n";
while ( <$fh> ) {
    next if defined( $args{s} ) && $. < $args{s};
    next if defined( $args{e} ) && $. > $args{e};
    print;
}    
close( $fh );

