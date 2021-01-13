#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

# test with:
our $usage="cd jeongoon/raku; raku ch-2.raku; cd -";
# because reading "input" from current directory

=begin unfolded

with "input".IO {
    .r or die "no `input' file";
    my %r;
    %r{.value}.push(.key) .= sort # not efficent but note that
                                  # left hand side is still left value
        for bag(.words».
              subst( / \'s
                     |
                     <[\W]-[-]> # non ascii num  but `-' allowed
                     |
                     "--" /,    # `-' is allowed but `--' is not
                     '',:g )
             );
    %r.sort(*.key). # `*.key' is not needed but has clearer meaning
    join("\n").
    put;
}

=end unfolded

# https://dev.to/jeongoon/weekly-challenge-081-task-2-1lbj
with "input".IO {
    .r or die "no `input' file";
    my %r;
    %r{.value}.push(.key).=sort
    for bag(.words».subst(/\'s|<[\W]-[-]>|"--"/,'',:g));
    %r.sort.join("\n").put;
}

=begin off-the-challenge

# credit: mark-anderson
# thank you :-)

"input".IO.slurp andthen {
    my %r;
    %r{.value}.push(.key).=sort
        for bag(.subst(/\'s|<[,."()]>|"--"/,'',:g).words);
    %r.sort.join("\n").put;
}

=end off-the-challenge
