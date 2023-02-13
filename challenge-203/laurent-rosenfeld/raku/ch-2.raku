sub traverse_dir (&code_f, &code_d, $path) {
    # my @dir_entries = dir("$path");
    for dir "$path" -> $entry {
        next if $entry.l;       # exclude symlinks
        &code_f($entry) and next if $entry.f;
        &code_d($entry) and
            traverse_dir(&code_f, &code_d, $entry)
            if $entry.d;
    }
}
sub create_dir_code_ref ($target_path) {
    return sub ($dir) {
        my $dir_name = $dir.IO.basename;
        my $new_dir = "$target_path/$dir_name";
        if $new_dir.IO.e {
            note "Path $new_dir already exists. Omitted";
            return True;
        }
        mkdir $new_dir or die "Unable to create $new_dir $!";
        say "Created $new_dir from $dir.";
    }
}
my ($source, $target) = './a/b/c', './x/y';
die "No such directory." unless $source.IO.d;
mkdir ($target, 0o777) unless $target.IO.d;
my &code_ref_d = create_dir_code_ref $target;
my &code_ref_f = {True};
traverse_dir &code_ref_f, &code_ref_d, $source;
