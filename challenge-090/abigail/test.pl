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

use Getopt::Long;

GetOptions 'slow'              =>  \my $run_slow_tests,
           'lang|language=s'   =>  \my @languages,
;

my $HOME = $ENV {HOME};

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
        comp    =>   "/usr/bin/cc",
        ext     =>   "c",
    },
    SQL         =>   {
        ext     =>   "sql",
    },
   'Befunge-93' =>   {
        ext     =>   "bf93",
        exe     =>   "$HOME/Bin/run-language",
    },
    BASIC       =>   {
        ext     =>   "bas",
        exe     =>   "$HOME/Bin/run-language",
    },
    Bash        =>   {
        ext     =>   "sh",
        exe     =>   "/bin/sh",
    },
    Python      =>   {
        ext     =>   "py",
        exe     =>   "/opt/local/bin/python",
    },
    Ruby        =>   {
        ext     =>   "rb",
        exe     =>   "/usr/bin/ruby",
    },
    Csh         =>   {
        ext     =>   "csh",
        exe     =>   "/bin/csh",
    },
    Fortran     =>   {
        ext     =>   "f90",
        comp    =>   "/opt/local/bin/gfortran-mp-4.4",
    },
   'Brainfuck'  =>   {
        ext     =>   "bf",
        exe     =>   "$HOME/Bin/brainfuck",
    },
   'Ook!'       =>   {
        ext     =>   "ook",
        dir     =>   "ook",
        exe     =>   "$HOME/Bin/ook",
    },
    MUMPS       =>   {
        ext     =>   "mps",
        exe     =>   "TIO",   # Language::Mumps is really broken
    },
    Forth       =>   {
        ext     =>   "fs",
        exe     =>   "TIO",   # Could no build gforth
    },
    Chef        =>   {
        ext     =>   "chef",
        exe     =>   "/opt/perl/bin/chef",
    },
    Pascal      =>   {
        ext     =>   "p",
        exe     =>   "TIO",
    },
    Cobol       =>   {
        ext     =>   "cb",
        exe     =>   "TIO",
    },
);

my $perl_exe = $languages {Perl} {exe};

@languages = sort {lc $a cmp lc $b} keys %languages if !@languages;
my @challenges = @ARGV ? @ARGV : (1, 2);

foreach my $challenge (@challenges) {
    my ($dbh, $query, $tables_info);   # Only for SQL tests.

    my @outputs = <t/output-$challenge-*> or next;
    subtest "Challenge $challenge" => sub {
        foreach my $language (@languages) {
            my $info     =   $languages {$language};
            my $exe      =   $$info {exe};
            my $ext      =   $$info {ext};
            my $comp     =   $$info {comp};
            my $dir      =   $$info {dir}     // lc $language;
            my @args     = @{$$info {args}    // []};
            my $filter   =   $$info {filter}  // '';
            my $ext_out  =   $$info {ext_out} // "out";
            my $source   =  "$dir/ch-$challenge.$ext";
            my $compiled;
            next unless -r $source;

            subtest $language => sub {
              SKIP: {
                if ($exe && $exe eq "TIO") {
                    skip "No executable present, please use tio.net", 1;
                }

                #
                # Some languages first need to be compiled.
                #
                if ($comp) {
                    $compiled = $source =~ s/\.$ext$/.$ext_out/r;
                    system $comp, "-o", $compiled, $source;
                }

                #
                # SQL requires requires creating an in-memory database,
                # and loading some tables. For that, we need a .tables
                # file. We also read the actual query at this time.
                #
                if ($language eq "SQL") {
                    my $tables = $source =~ s/\.\Q$ext\E$/.table/r;
                   ($dbh, $query, $tables_info) = init_sql ($source, $tables);
                }

                foreach my $output_exp (@outputs) {
                  SKIP: {
                    my $input      = $output_exp =~ s/output/input/r
                                                 =~ s/\.exp$//r;
                    my $exp        = `cat $output_exp`;

                    my $name = $input;

                    if (!-f $input) {
                        $name  = "No input";
                        $input = "/dev/null";
                    }

                    my %pragma;
                    my @options;

                    while ($exp =~ s/^\s*#%\s*(.*)\n//) {
                        my $pragma = $1;
                        $pragma =~ s/\s+$//;
                        if ($pragma =~ s/^\@(\S+)\s*//) {
                            next unless lc ($1) eq lc ($language);
                        }
                        if ($pragma =~ /^[-\w]+$/) {
                            $pragma {lc $pragma} = 1;
                            next;
                        }
                        if ($pragma =~ /^\s*(\w+):\s*(.*)/) {
                            my ($key, $value) = ($1, $2);
                            if (lc $key eq "opt") {
                                push @options => $value;
                            }
                        }
                    }

                    if ($exp =~ s/^\s*#\s*(.*)\n//) {
                        $name = $1;
                    }

                    skip "Skipping slow test", 1
                        if $pragma {slow} && !$run_slow_tests;

                    my $got;
                    if ($compiled) {
                        $got = `$perl_exe -ple '$filter' $input |\
                              ./$compiled @options`;
                    }
                    elsif ($language eq "SQL") {
                        $got = test_sql ($dbh, $query, $tables_info, $input);
                    }
                    else {
                        $got = `$perl_exe -ple '$filter' $input |\
                                $exe @args ./$source @options`;
                    }

                    s/\h+$//gm for $exp, $got;
                    if ($pragma {trim}) {
                        s/^\h+//gm for $exp, $got;
                    }
                    if ($pragma {"swap-pairs"}) {
                        my @got = split /\n/ => $got;
                        for (my $i = 0; $i + 1 < @got; $i += 2) {
                            @got [$i, $i + 1] = @got [$i + 1, $i];
                        }
                        $got = join "\n" => @got, "";
                    }
                    is $got, $exp, $name;
                }}
                unlink $compiled if $compiled;
            }}
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
    my $tables = -f $tables_file ? `cat $tables_file` : "";

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
    #
    # Does the query have place holders?
    #
    if ($query =~ /\?/) {
        push @info => ["Placeholder"];
    }

    my $dbh = DBI:: -> connect ("dbi:SQLite:dbname=:memory:", "", "",
                                {RaiseError   =>  1,
                                 PrintError   =>  1,
                                 AutoCommit   =>  1});
    $dbh -> do ($tables) if $tables;

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
    # Read the input, if any
    #
    my @input;
    if (-f $input) {
        open my $i_fh, "<", $input or die "Failed to open $input: $!";
        @input = <$i_fh>;
    }

    my $output = "";

  TEST:
    while (@input >= @$tables_info) {
        my $real_query = $query;
        foreach my $table_info (@$tables_info) {
            my ($table, @fields) = @$table_info;
            my $input            = shift @input;
            my @values           = split ' ' => $input;
            last TEST if @values < @fields && $table ne "Placeholder";

            #
            # Handle place holder queries
            #
            if ($table eq "Placeholder") {
                $real_query =~ s/\?/shift @values/eg;
                next;
            }

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
        }


        #
        # Run the query. If we have multiple results, join columns
        # by spaces, and rows by newlines.
        #
        foreach my $query (split /^\s*;\s*$/m => $real_query) {
            my $result = $dbh -> selectall_arrayref ($query);
            $output   .= join "\n" => map {join " " => @$_} @$result;
            $output   .= "\n";
        }

        last unless @input;
    }

    $output;
}




__END__
