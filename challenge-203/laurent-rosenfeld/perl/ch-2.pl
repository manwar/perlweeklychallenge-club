use strict;
use warnings;
use feature "say";

sub traverse_dir {
    my ($code_f, $code_d, $path) = @_;
    my @dir_entries = glob("$path/*");
    for my $entry (@dir_entries) {
        $code_f->($entry) if -f $entry;
        $code_d->($entry) and
            traverse_dir($code_f, $code_d, $entry)
            if -d $entry;
    }
}

sub create_size_code_ref {
    my $total_size = 0;
    return (sub {
        my $file = shift;
        my $size = -s $file;
        $total_size += $size;
        printf "%-15s -> %d\n", $file, $size,;
    }, sub {return $total_size;});
}
my $dir = shift;
my ($code_ref, $glob_size) = create_size_code_ref();
traverse_dir ($code_ref, sub {1}, $dir);
say "Total size = ", $glob_size->();
