#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/signatures say/;
no warnings qw/experimental/;
use DBI;

# This is really just a thin layer of perl over SQLite to solve the
# problems using SQL window functions.

sub task1 ($A, $S) :prototype(\@$) {
    my $dbh = DBI->connect("dbi:SQLite:dbname=:memory:","","");
    $dbh->do("CREATE TABLE data(id INTEGER PRIMARY KEY, val INTEGER)");
    my $stmt = $dbh->prepare("INSERT INTO data(val) VALUES (?)");
    $stmt->execute_array({}, $A);
    $S -= 1;
    my $len = @$A - $S;
    my $nums = $dbh->selectall_arrayref(<<EOS);
SELECT min(val) OVER (ORDER BY id ROWS BETWEEN CURRENT ROW AND $S FOLLOWING)
FROM data
ORDER BY id
LIMIT $len
EOS
    say "Task 1:\t", join(", ", map { $_->[0] } @$nums);
}

my @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8);
my $S = 3;
task1 @A, $S;
