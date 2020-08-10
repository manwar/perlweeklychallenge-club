#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;
use DBI;

# This is really just a thin layer of perl over SQLite to solve the
# problems using SQL window functions.

sub task2 {
  my @A = @_;
  my $dbh = DBI->connect("dbi:SQLite:dbname=:memory:","","");
  $dbh->do("CREATE TABLE data(id INTEGER PRIMARY KEY, val INTEGER)");
  my $stmt = $dbh->prepare("INSERT INTO data(val) VALUES (?)");
  $stmt->execute_array({}, \@A);

  my $nums = $dbh->selectall_arrayref(<<EOS);
SELECT CASE
         WHEN min(val) OVER w < val THEN min(val) OVER w
         ELSE 0
       END
FROM data
WINDOW w AS (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
ORDER BY id
EOS

  say "Task 2:\t", join(", ", map { $_->[0] } @$nums);
}

task2 7, 8, 3, 12, 10;
task2 4, 6, 5;
