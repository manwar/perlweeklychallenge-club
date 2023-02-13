use v5.30.0;
my $source = '/a/b/c/';
my $target = '/x/y/';

opendir my $dh, $source or die "$!";
my @files = readdir $dh;
closedir $dh;
my @dirs;
foreach (@files) {
    next if (($_ eq ".") or ($_ eq ".."));
    push @dirs, $_ if (-d $source.$_);
}
for (@dirs) {
    #mkdir $target.$_;
    say $target.$_;
    proc($_);
}

sub proc {
    my $wd = shift;
    opendir my $dh, $source.$wd or die "$!";
    my @files = readdir $dh;
    closedir $dh;
    foreach (@files) {
	my $dir = "$wd/$_";
	next if (($_ eq ".") or ($_ eq ".."));
	if (-d $source.$dir) {
	    push @dirs, $dir;
#	    mkdir $target.$dir;	    
	    say $target.$dir;
	}
    }
}
