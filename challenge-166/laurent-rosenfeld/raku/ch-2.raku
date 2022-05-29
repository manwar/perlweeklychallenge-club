my @dirs = map {$_ ~~ /\w+$/}, dir("./rootdir");
my %dircontent;
for @dirs -> $dir {
    %dircontent{$dir} = map {~($_ ~~ /\w+$/)}, dir("./rootdir/$dir");
}
say "Content of the dirs: ", %dircontent;
my $intersection = [∩] values %dircontent;
say "Files common to all directories: ", $intersection.keys;
for @dirs -> $dir {
    say "$dir -> ", grep {$_ ∉ $intersection}, values %dircontent{$dir};
}
