#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# PWC 263 Task 2 Alternative using SQLite 
#=============================================================================

use v5.38;
use DBI;
use DBD::SQLite;

sub createDB()
{
    my $dbh = DBI->connect("dbi:SQLite:dbname=:memory:", "", "",
            { PrintError => 1, PrintWarn => 1, RaiseError=>1});
    # $dbh->trace($dbh->parse_trace_flags('SQL|1|test'));
    return $dbh;
} 

sub createTbl($dbh, $name)
{
    my $ddl = <<"_CREATE_TBL_";
CREATE TABLE $name (
    item INT(11) NOT NULL,
    count INT(11) NOT NULL
);
_CREATE_TBL_

    $dbh->do($ddl);
}

sub insert($dbh, $tbl, @lists)
{
    my $sql = <<"_SQL_";
INSERT INTO $tbl(item, count) VALUES (?,?);
_SQL_

    my $stmt = $dbh->prepare($sql);
    for my $list ( @lists)
    {
        for my $pair ( $list->@* )
        {
            $stmt->execute( $pair->[0], $pair->[1] );
        }
    }
    $stmt->finish();
}

sub dumpTbl($dbh, $tbl)
{
    my $sql = "SELECT * FROM $tbl;";

    my $stmt = $dbh->prepare($sql);
    $stmt->execute();
    while (my @row = $stmt->fetchrow_array)
    {
        say "$row[0], $row[1]";
    }
}

sub mergeItems($dbh, $tbl)
{
    my $sql = <<"_SQL_";
SELECT item, SUM(count)
  FROM inventory
 GROUP BY item;
_SQL_

    my $stmt = $dbh->prepare($sql);
    $stmt->execute();
    my $result = $stmt->fetchall_arrayref;
    $stmt->finish();
    return $result;
}

use constant TBL => "inventory";

my $items1 = [ [1,1], [2,1], [3, 2] ];
my $items2 = [ [2,2], [1,3]         ];

my $dbh = createDB();
createTbl($dbh, TBL);
insert($dbh, TBL, $items1, $items2);
# dumpTbl($dbh, TBL);

my $total = mergeItems($dbh, TBL);

for my $pair ( $total->@* )
{
    say "SUM: $pair->[0], $pair->[1]";
}
