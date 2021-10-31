#!/usr/bin/env perl

# convert my code from 4-tabs to spaces

use Modern::Perl;
use Path::Tiny;
use Text::Tabs; $Text::Tabs::tabstop = 4;

for my $dir (<challenge-*/paulo-custodio>) {
    my $iter = path($dir)->iterator({recurse=>1});
    while (defined(my $path = $iter->())) {
        next unless $path->is_file;
        next if $path =~ /~$/;                      # temp files
        my $ext = ""; $path->basename =~ /(\.\w+)$/ and $ext = $1;
        next if $ext eq "" || $ext =~ /\.(exe|o|obj|ali|ads)$/; # binaries
        untabify($path);
    }
}

sub untabify {
    my($file) = @_;
    my $text = path($file)->slurp_raw;
    my @lines = expand(map {s/\s+$//r} split(/\n/, $text));
    my $new_text = join "\n", (@lines, "");
    if ($text ne $new_text) {
        path($file)->copy("$file~");
        say "Formatting $file";
        path($file)->spew_raw($new_text);
    }
}
