#! /usr/bin/perl
use warnings;
use strict;

=head1 Represent Integer

For D = 1, there's always the trivial solution: N = 1 + 1 + ... + 1.

For D > 1 and any N >= D * 10, we can subtract D as many times as we
get between D * 10 and D * 10 + 9. Let's call this number M. M
contains D and M + D + D + ... + D = N, so it's the solution.

For D = 0 and any N > 100, we can subtract 10 as many times as we get
between 100 and 110. Let's call this number M. M contains 0 and M + 10
+ 10 + 10 + ... + 10 = N, so it's the solution.

Therefore, the only possible non-representable integers are N < D * 10
for D > 0, and N < 100 for D = 0.

=cut

sub represent_integer {
    my ($integer, $digit) = @_;
    return 1 if 1 == $digit
             || 1 < $digit && $integer >= $digit * 10
             || 0 == $digit && $integer > 99;
    return _represent_integer($integer, $digit)
}

sub _represent_integer {
    my ($integer, $digit) = @_;
    return 1 if 0 == $integer;

    for (my $having = $integer; $having > 0; --$having) {
        next unless $having =~ /$digit/;

        return 1 if represent_integer($integer - $having, $digit);
    }
    return 0
}

use Test::More tests => 2002;
is represent_integer(25, 7), 0;
is represent_integer(24, 7), 1;

my %non_representable;
@non_representable{
    qw{ 0:1 2:1 3:1 4:1 5:1 6:1 7:1 8:1 9:1 0:2 3:2 4:2 5:2 6:2 7:2
        8:2 9:2 0:3 2:3 4:3 5:3 6:3 7:3 8:3 9:3 0:4 3:4 5:4 6:4 7:4
        8:4 9:4 0:5 2:5 3:5 4:5 6:5 7:5 8:5 9:5 0:6 4:6 5:6 7:6 8:6
        9:6 0:7 2:7 3:7 4:7 5:7 6:7 8:7 9:7 0:8 3:8 5:8 6:8 7:8 9:8
        0:9 2:9 4:9 5:9 6:9 7:9 8:9 3:10 4:10 6:10 7:10 8:10 9:10 0:11
        2:11 3:11 4:11 5:11 6:11 7:11 8:11 9:11 0:12 5:12 7:12 8:12
        9:12 0:13 2:13 4:13 5:13 6:13 7:13 8:13 9:13 0:14 3:14 5:14
        6:14 8:14 9:14 0:15 2:15 4:15 6:15 7:15 8:15 9:15 0:16 5:16
        7:16 9:16 0:17 2:17 3:17 4:17 5:17 6:17 8:17 9:17 0:18 5:18
        7:18 0:19 2:19 4:19 5:19 6:19 7:19 8:19 3:20 6:20 7:20 8:20
        9:20 0:21 4:21 5:21 6:21 8:21 9:21 0:22 5:22 7:22 8:22 9:22
        0:23 4:23 5:23 6:23 7:23 8:23 9:23 0:24 5:24 9:24 0:25 4:25
        6:25 7:25 8:25 9:25 0:26 5:26 7:26 9:26 0:27 4:27 5:27 6:27
        8:27 0:28 5:28 0:29 4:29 5:29 6:29 7:29 8:29 7:30 8:30 9:30
        0:31 4:31 5:31 6:31 8:31 9:31 0:32 5:32 7:32 9:32 0:33 4:33
        5:33 6:33 7:33 8:33 9:33 0:34 5:34 9:34 0:35 4:35 6:35 8:35
        9:35 0:36 5:36 7:36 0:37 4:37 5:37 6:37 8:37 0:38 5:38 0:39
        4:39 5:39 6:39 7:39 8:39 7:40 9:40 0:41 5:41 6:41 8:41 9:41
        0:42 5:42 9:42 0:43 5:43 6:43 7:43 8:43 9:43 0:44 5:44 9:44
        0:45 6:45 8:45 0:46 5:46 7:46 0:47 5:47 6:47 8:47 0:48 5:48
        0:49 5:49 6:49 8:49 7:50 9:50 0:51 6:51 8:51 9:51 0:52 9:52
        0:53 6:53 7:53 8:53 9:53 0:54 0:55 6:55 8:55 0:56 0:57 6:57
        8:57 0:58 0:59 6:59 8:59 7:60 9:60 0:61 8:61 9:61 0:62 9:62
        0:63 8:63 0:64 0:65 8:65 0:66 0:67 8:67 0:68 0:69 8:69 9:70
        0:71 8:71 9:71 0:72 0:73 8:73 0:74 0:75 8:75 0:76 0:77 8:77
        0:78 0:79 8:79 9:80 0:81 0:82 0:83 0:84 0:85 0:86 0:87 0:88
        0:89 0:91 0:92 0:93 0:94 0:95 0:96 0:97 0:98 0:99 }
} = ();

for my $n (1 .. 200) {
    for my $d (0 .. 9) {
        is represent_integer($n, $d),
            exists $non_representable{"$d:$n"} ? 0 : 1,
            "$d:$n";
    }
}
