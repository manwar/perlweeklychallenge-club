echo https://github.com/LaurentRosenfeld/thinkperl6/blob/master/Supplementary/words.txt
perl -E 'my $letters = join "", sort qw/a e i t r s o u a /; while (<>) { chomp; my $norm = join "", sort split //, $_; say $_ if index($letters, $norm) >=0;}' words.txt
