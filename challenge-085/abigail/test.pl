#!/opt/perl/bin/perl

#
# Test the solutions. Either call it with the directory name you
# want to test in, or call it as "../test.pl" from within the directory.
#

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

chdir ".." if -f "../test.pl";

use experimental 'signatures';

use Test::More;
use DBI;


my %languages = (
    Perl        =>   {
        exe     =>   "/opt/perl/bin/perl",
        ext     =>   "pl",
    },
    JavaScript  =>   {
        exe     =>   "/usr/local/bin/node",
        ext     =>   "js",
        dir     =>   "node",
    },
    bc          =>   {
        exe     =>   "/usr/bin/bc",
        ext     =>   "bc",
        filter  =>   's/.*/main($&)/',
    },
    awk         =>   {
        exe     =>   "/usr/bin/awk",
        ext     =>   "awk",
        args    =>   ["-f"],
    },
    C           =>   {
        exe     =>   "/usr/bin/cc",
        ext     =>   "c",
        dir     =>   "c",
    },
    SQL         =>   {
        ext     =>   "sql",
    },
);

my $perl_exe = $languages {Perl} {exe};

foreach my $challenge (1, 2) {
    my ($dbh, $query, $tables_info);   # Only for SQL tests.

    my @inputs = <input-$challenge-*> or next;
    subtest "Challenge $challenge" => sub {
        foreach my $language (sort keys %languages) {
            my $info     =   $languages {$language};
            my $exe      =   $$info {exe};
            my $ext      =   $$info {ext};
            my $dir      =   $$info {dir}     // lc $language;
            my @args     = @{$$info {args}    // []};
            my $filter   =   $$info {filter}  // '';
            my $ext_out  =   $$info {ext_out} // "out";
            my $source   =  "$dir/ch-$challenge.$ext";
            my $compiled;
            next unless -r $source;

            #
            # C requires special handling. The source needs to be compiled.
            #
            if ($language eq "C") {
                $compiled = $source =~ s/\.$ext$/.$ext_out/r;
                system $exe, "-o", $compiled, $source;
            }

            #
            # SQL requires requires creating an in-memory database,
            # and loading some tables. For that, we need a .tables
            # file. We also read the actual query at this time.
            #
            if ($language eq "SQL") {
                my $tables = $source =~ s/\.\Q$ext\E$/.table/r;
                next unless -r $tables;
               ($dbh, $query, $tables_info) = init_sql ($source, $tables);
            }

            subtest $language => sub {
                foreach my $input (@inputs) {
                    my $output_exp = ($input =~ s/input/output/r) . ".exp";
                    my $exp        = `cat $output_exp`;

                    my $name = $input;
                    if ($exp =~ s/^\s*#\s*(.*)\n//) {
                        $name = $1;
                    }

                    my $got;
                    if ($compiled) {
                        $got = `$perl_exe -ple '$filter' $input | ./$compiled`;
                    }
                    elsif ($language eq "SQL") {
                        $got = test_sql ($dbh, $query, $tables_info, $input);
                    }
                    else {
                        $got = `$perl_exe -ple '$filter' $input |\
                                $exe @args ./$source`;
                    }

                    s/\h+$//gm for $exp, $got;
                    is $got, $exp, $name;
                }
            };

            unlink $compiled if $compiled;
        }
    }
}

done_testing;

#
# Parse the tables SQL, extract the table names, and the column names,
# *EXCLUDING* any primary key of the form "integer PRIMARY KEY"
# We're assuming some sane formatting (one column per line).
#
# Returns an array of arrays. Each (inner) array consists of a table
# name, followed by the name of the columns of that table.
#
# We will also create the database handle, use it to create the tables,
# and return the database handle as a second value.
#
sub init_sql ($query_file, $tables_file) {
    my $query  = `cat $query_file`;
    my $tables = `cat $tables_file`;

    my $in_table = 0;
    my @info;
    foreach (split /\n/ => $tables) {
        if (!$in_table) {
            if (/^\s* CREATE \s+ TABLE \s+ (\w+)/xi) {
                $in_table = 1;
                push @info => [$1];
            }
            next;
        }
        else {
            if (/^\s* \)/x) {
                $in_table = 0;
                next;
            }
            # Any other line is a column definition
            next if /^ \s* \w+ \s+ integer \s+ PRIMARY \s+ KEY \s*,/xi;
            if (/^ \s* (\w+)/x) {
                push @{$info [-1]} => $1;
            }
        }
    }

    my $dbh = DBI:: -> connect ("dbi:SQLite:dbname=:memory:", "", "",
                                {RaiseError   =>  1,
                                 PrintError   =>  1,
                                 AutoCommit   =>  1});
    $dbh -> do ($tables);

    return ($dbh, $query, \@info);
}


sub test_sql ($dbh, $query, $tables_info, $input) {
    #
    # For now, assume we each set of N lines, where N is the number of tables
    # is a test. We also assume that if a line has P items (space separated),
    # and the corresponing table has Q columns (not counting any integer primary
    # keys, as SQLite fills them automatically), we have to fill int (P/Q) rows.
    #

    #
    # Read the input
    #
    open my $i_fh, "<", $input or die "Failed to open $input: $!";
    my @input = <$i_fh>;

    my $output = "";

  TEST:
    while (@input >= @$tables_info) {
        foreach my $table_info (@$tables_info) {
            my ($table, @fields) = @$table_info;
            my $input            = shift @input;
            my @values           = split ' ' => $input;
            last TEST if @values < @fields;
            #
            # Clear the table
            #
            $dbh -> do ("DELETE FROM $table");

            #
            # Construct an input query
            #
            my $place  = "(" . join (", " => ("?") x @fields) . ")";
            my $insert = do {local $" = ", "; <<~ "--"};
                INSERT
                  INTO  $table
                       (@fields)
                VALUES  @{[($place) x (@values / @fields)]}
            --

            $dbh -> do ($insert, undef, @values);

            #
            # Run the query. If we have multiple results, join columns
            # by spaces, and rows by newlines.
            #
            my $result = $dbh -> selectall_arrayref ($query);

            $output .= join "\n" => map {join " " => @$_} @$result;
            $output .= "\n";
        }
    }

    $output;
}




__END__
