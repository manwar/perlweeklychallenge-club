use File::Copy;

my $source = '/a/b/c';
my $target = '/x/y';

sub copy_dir {
  my ($source_dir, $target_dir) = @_;

  opendir(my $dh, $source_dir) || die "Can't open $source_dir: $!";
  my @files = grep { !/^\./ && -d "$source_dir/$_" } readdir($dh);
  closedir $dh;

  foreach my $file (@files) {
    my $source_file = "$source_dir/$file";
    my $target_file = "$target_dir/$file";
    mkdir $target_file unless -d $target_file;
    copy_dir($source_file, $target_file);
  }
}

copy_dir($source, $target);

