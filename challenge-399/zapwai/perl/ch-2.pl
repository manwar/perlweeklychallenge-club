use v5.38;

sub proc($fs) {
    my $f = $fs;
    $f =~ s/\n/\\n/g;
    $f =~ s/\t/\\t/g;
    say "Input: " . $f;

    my @lines = split /\n/, $fs;
    my @path;
    my $max = 0;

    for my $line (@lines) {
	my ($tabs) = $line =~ /^(\t*)/;
	my $depth = length($tabs);

	my $name = substr($line, $depth);
	$#path = $depth - 1;
	push @path, $name;

	if ($name =~ /\.[^.\s\/]+$/) {
	    my $length = length(join('/', @path));
	    $max = $length if $length > $max;
	}
    }

    say "Output: $max";
}

my $fs = "dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2";
proc($fs);
$fs = "file1.txt\nfile2.ext\na.png";
proc($fs);
$fs = "my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png";
proc($fs);
$fs = "root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt";
proc($fs);
$fs = "a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt";
proc($fs);
