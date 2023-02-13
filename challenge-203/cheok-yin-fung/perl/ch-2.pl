# The Weekly Challenge 203
# Task 2 Copy Directory
# Usage: perl ch-2.pl $source $target
use v5.30.0;
use warnings;

my $source = $ARGV[0];
my $target = $ARGV[1];

die "$source is not a directory" unless -d $source;
die "$target is not a directory" unless -d $target;

# dir_walk taken from "Higher Order Perl" by Mark Jason Dominus

sub dir_walk {
    my ($top, $code, $dirname) = @_;
    my $DIR;

    $code->($top, $dirname);

    if (-d $top) {
        my $file;
        unless (opendir $DIR, $top) {
            warn "Couldn't open directory $top: $!; skipping.\n";
            return;
        }
        while ($file = readdir $DIR) {
            next if $file eq "." || $file eq "..";
            dir_walk("$top/$file", $code, $file);
        }
    }
}

sub copy_dir {
    if ($_[1]) {
        if (-d $_[0]) {
            my $dirname = $_[1];
            my $reldir = substr($_[0], length($source));
            my $relpdir = reverse substr(
                (reverse $reldir), index(
                    (reverse $reldir), "/"
                )
            );
            `cd $target$relpdir && mkdir $dirname`;
        }
    }
}

dir_walk($source, \&copy_dir);
