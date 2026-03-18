#!/usr/bin/env perl

use Modern::Perl;
use Path::Tiny;

for my $challenge (path(".")->children(qr/^challenge-\d+$/)) {
    my($challenge_id) = ($challenge =~ /(\d+)/);
    for my $user ($challenge->children(qr/^paulo-custodio$/)) {
        # create/update README.txt
        update_comment("$user/README.txt", "", "", $challenge_id, 0);

        # drill down to solutions
        for my $lang ($user->children) {
            next unless -d $lang;
            for my $sol ($lang->children(qr/^ch-[12]./)) {
                my($task_id) = ($sol =~ /ch-([12])/);
                if ($sol =~ /\.awk$/) {
                    update_comment($sol, "#!/usr/bin/env gawk", "# ", $challenge_id, $task_id);
                }
                elsif ($sol =~ /\.bas$/) {
                    update_comment($sol, "", "' ", $challenge_id, $task_id);
                }
                elsif ($sol =~ /\.(bf|bfpp)$/) {
                    # needs to be hand-edited
                }
                elsif ($sol =~ /\.(c|cpp)$/) {
                    update_comment($sol, "", "// ", $challenge_id, $task_id);
                }
                elsif ($sol =~ /\.exe$/) {
                    # ignore
                }
                elsif ($sol =~ /\.fs$/) {
                    update_comment($sol, "#! /usr/bin/env gforth", "\\ ", $challenge_id, $task_id);
                }
                elsif ($sol =~ /\.lua$/) {
                    # needs to be hand-edited
                }
                elsif ($sol =~ /\.pl$/) {
                    update_comment($sol, "#!/usr/bin/env perl", "# ", $challenge_id, $task_id);
                }
                elsif ($sol =~ /\.py$/) {
                    update_comment($sol, "#!/usr/bin/env python", "# ", $challenge_id, $task_id);
                }
                else {
                    die "no instructions for file $sol";
                }
            }
        }
    }
}

sub update_comment {
    my($file, $hash_bang, $comment_prefix, $challenge_id, $task_id) = @_;
    my $task = $task_id ? " - Task $task_id - solution by Paulo Custodio" : "";

    # create README.txt
    if ($file =~ /README.txt$/ && ! -f $file) {
        say $file;

        open(my $fh, ">", $file) or die "create $file: $!";
        say $fh "Perl Weekly Challenge $challenge_id$task";
        say $fh "https://theweeklychallenge.org/blog/perl-weekly-challenge-$challenge_id/";
        say $fh "";
        close($fh);
        return;
    }

    # update other files
    return unless -f $file;
    my @lines = path($file)->lines;
    my @old_lines = @lines;

    my $i = 0;
    if ($hash_bang) {
        if ($lines[0] !~ /^$hash_bang/) {
            my($exe) = ($lines[0] !~ /(\w+)\s*$/);
            if ($lines[0] =~ /^#!.*$exe/) {
                $lines[0] = "$hash_bang\n";
            }
            else {
                die "$file: expected $hash_bang, found $lines[0]";
            }
        }
        if ($lines[1] !~ /^\s*$/) {
            die "$file: expected empty line, found $lines[1]";
        }
        $i = 2;
    }
    if (($lines[$i]//"") =~ /Challenge/ && ($lines[$i+1]//"") =~ /http/) {
        $lines[$i] = "${comment_prefix}Perl Weekly Challenge $challenge_id$task\n";
        $lines[$i+1] = "${comment_prefix}https://theweeklychallenge.org/blog/perl-weekly-challenge-$challenge_id/\n";
    }
    else {
        splice(@lines, $i, 0,
                    "${comment_prefix}Perl Weekly Challenge $challenge_id$task\n",
                    "${comment_prefix}https://theweeklychallenge.org/blog/perl-weekly-challenge-$challenge_id/\n",
                    "\n");
    }

    if ("@lines" ne "@old_lines") {
        say $file;
        path($file)->spew(@lines);
    }
}
