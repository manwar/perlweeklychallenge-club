use v6.d;

#
#       source_dumper.raku
#
#       TASK #2
#       Source Dumper
#             Write a script that dumps its own source code. For example, say, the
#             script name is ch-2.pl then the following command should returns
#             nothing.
#
#                 $ perl ch-2.pl | diff - ch-2.pl

#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN () {

    print $*PROGRAM.open.slurp.gist;

}


