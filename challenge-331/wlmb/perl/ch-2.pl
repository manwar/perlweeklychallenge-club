#!/usr/bin/env perl
# Perl weekly challenge 331
# Task 2:  Buddy Strings
#
# See https://wlmb.github.io/2025/07/21/PWC331/#task-2-buddy-strings
use v5.36;
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 S1 T1 S2 T2...
    to find if target string Tn may be obtained from the source string Sn
    by a single permutation of two characters.
    FIN
for my($source, $target)(@ARGV){
    say"$source $target -> ",
	(my $joined="$source$;$target")        # join source and target using special character
	=~                                     # match to
	/^                                     # start of source
        (.*)                                   # arbitrary string (group 1)
        (.)                                    # a single character to permute (group 2)
        (.*)                                   # arbitrary string (group 3)
        (.)                                    # second character to permute (group 4)
        (.*)                                   # arbitrary string (group 5)
        $;                                     # end of source
        \1\4\3\2\5                             # target is source with \2 and \4 permuted
        $                                      # end of target
        /x
	?"True":"False";
}
