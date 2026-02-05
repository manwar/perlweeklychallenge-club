use Modern::Perl;
use Path::Tiny;
use Text::Diff;

my $_exe = $^O =~ /msys|cygwin|MSWin32/ ? ".exe" : "";

sub test_line {
    my($nr, $in, $expected) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;

    opendir(my $dh, ".") or die $!;
    while (my $dir = readdir($dh)) {
        next unless -d $dir;
        next if $dir eq "." || $dir eq "..";
        if ($dir eq 'perl') {
            next unless -f "$dir/ch-$nr.pl";
            capture("perl $dir/ch-$nr.pl $in", $expected);
        }
        elsif ($dir eq 'c') {
            next unless -f "$dir/ch-$nr.c";
            make_exe("gcc -o $dir/ch-$nr$_exe $dir/ch-$nr.c",
                    "$dir/ch-$nr.c", "$dir/ch-$nr$_exe");
            next unless -f "$dir/ch-$nr$_exe";
            capture(normalize_path("$dir/ch-$nr$_exe")." $in", $expected);
        }
        else {
            warn "skipped directory $dir\n";
        }
    }
}

sub test_block {
    my($nr, $in, $expected) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;

    path("test.in")->spew($in);
    path("test.exp")->spew($expected);

    opendir(my $dh, ".") or die $!;
    while (my $dir = readdir($dh)) {
        next unless -d $dir;
        next if $dir eq "." || $dir eq "..";
        if ($dir eq 'perl') {
            next unless -f "$dir/ch-$nr.pl";
            run("perl $dir/ch-$nr.pl < test.in > test.out");
        }
        elsif ($dir eq 'c') {
            next unless -f "$dir/ch-$nr.c";
            make_exe("gcc -o $dir/ch-$nr$_exe $dir/ch-$nr.c",
                    "$dir/ch-$nr.c", "$dir/ch-$nr$_exe");
            next unless -f "$dir/ch-$nr$_exe";
            run(normalize_path("$dir/ch-$nr$_exe < test.in > test.out"));
        }
        else {
            warn "skipped directory $dir\n";
            next;
        }

        compare_files("test.out", "test.exp");
    }

    unlink("test.in", "test.out", "test.exp");
}

sub run {
    my($cmd) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;

    ok system($cmd)==0, "$cmd";
}

sub capture {
    my($cmd, $expected) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;

    run("$cmd > test.out");
    open(my $fh, "<", "test.out") or die "test.out: $!";
    local $/;
    my $got = <$fh>;
    $got =~ s/\r\n?/\n/g;
    $got =~ s/\s+$//s;
    close $fh;
    unlink "test.out";
    is $got, $expected, "got $expected";
}

sub make_exe {
    my($cmd, $src, $exe) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;

    return if (-f $exe && -M $exe < -M $src);
    run($cmd);
}

sub normalize_path {
    my($path) = @_;
    if ($^O =~ /MSWin32/) {
        $path =~ s{/+}{\\}g;
    }
    return $path;
}

sub compare_files {
    my($got, $exp) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;

    my $got_text = path($got)->slurp =~ s/\r\n?/\n/gr =~ s/[ \t]+/ /gr =~ s/\s*$/\n/r;
    my $exp_text = path($exp)->slurp =~ s/\r\n?/\n/gr =~ s/[ \t]+/ /gr =~ s/\s*$/\n/r;

    is diff(\$got_text, \$exp_text), "", "expected result";
}

sub quote {
    my($str) = @_;
    if ($_exe) {
        return '"'.$str.'"';
    }
    else {
        return "'".$str."'";
    }
}

sub quote_list {
    my(@items) = @_;
    for (@items) {
        $_ = quote($_);
    }
    return join " ", @items;
}

1;
