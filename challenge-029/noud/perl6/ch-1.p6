# Write a script to demonstrate brace expansion. For example, script would take
# command line argument Perl {Daily,Weekly,Monthly,Yearly} Challenge and should
# expand it and print like below:
#
#   Perl Daily Challenge
#   Perl Weekly Challenge
#   Perl Monthly Challenge
#   Perl Yearly Challenge

sub brace_expansion(Str $s) {
    if ($s ~~ /(.*)\{(.*)\}(.*)/) {
        ["$_[0]$_[1]$2" for brace_expansion(Str($0)) X $1.split(',')];
    } else {
        [$s];
    }
}

for brace_expansion('Perl {Daily,Weekly,Monthly,Yearly} Challenge 20{18,19,20}.') { .say; }
