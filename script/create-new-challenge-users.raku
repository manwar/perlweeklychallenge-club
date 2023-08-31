#!/usr/bin/env raku

sub MAIN (UInt $challenge-nr where * > 0, $user-to-create = 'all-from-last-challenge', $dry-run=True) {
    
    # creates new folder and modules for all users, that solved in the last week a challenge using Raku

    say '#' x 15 if $dry-run;
    say '### DRY RUN ###' if $dry-run;
    say '#' x 15 if $dry-run;

    my $previous-challenge-nr = $challenge-nr  - 1;
    my $previous-padding =  0 < $previous-challenge-nr < 10 ?? '00' !! (9 < $previous-challenge-nr < 100 ?? '0' !! '');
    my $previous-base-folder = 'challenge-' ~ $previous-padding ~ $previous-challenge-nr;
    
    die "Folder $previous-base-folder not found" unless ($previous-base-folder.IO.d or $user-to-create ne 'all-from-last-challenge');
    
    my $padding = 0 < $challenge-nr < 10 ?? '00' !! (9 < $challenge-nr < 100 ?? '0' !! '');
    my $challenge-id = 'nr' ~ $padding ~ $challenge-nr;
    my $base-folder = 'challenge-' ~ $challenge-id;
    
    my $users;
    if $user-to-create eq 'all-from-last-challenge' {
        # stolen from https://docs.raku.org/routine/dir at bottom of page
        my @stack = $previous-base-folder.IO;
        my $u = gather while @stack {
            with @stack.pop {
                when :d { @stack.append: .dir }
                .dirname.split('/')[1].take when .extension.lc eq ('raku' or 'rakumod')
            }
        }
        $users = $u.Set;
    }else{
        $users = [$user-to-create].Set
    }

    # create test dir
    my $test-folder = "test".IO.add($base-folder);
    my $cmd = "cp -r templates/challenge-test-TEMPLATE $test-folder";
    say "running $cmd" unless $test-folder.e;
    shell $cmd unless $dry-run or $test-folder.e;

    my $readme = slurp "templates/challenge-TEMPLATE/USER/README.md";
    my $challenge-one = slurp "templates/challenge-TEMPLATE/USER/raku/task-one.rakumod";
    my $challenge-two = slurp "templates/challenge-TEMPLATE/USER/raku/task-two.rakumod";

    $challenge-one = $challenge-one.subst('{{TEMPLATE}}', $challenge-id, :g);
    $challenge-two = $challenge-two.subst('{{TEMPLATE}}', $challenge-id, :g);
    $readme = $readme.subst('{{CHALLENGE}}', $challenge-nr, :g);

    # create user templates for this challenge
    for $users.Set.keys -> $user {
        my $out-dir = $base-folder.IO.add($user).add('raku');
        
        say "creating: " ~ $out-dir unless $out-dir.e;
        $out-dir.mkdir unless $dry-run or $out-dir.e;
        
        my $r1 = $base-folder.IO.add($user).add('README.md');
        say "creating: " ~ $r1 unless $r1.e;
        spurt $r1, $readme.subst('{{USER}}', $user, :g) unless $dry-run or $r1.e;

        my $c1 = $out-dir.add('task-one.rakumod');
        say "creating: " ~ $c1 unless $c1.e;
        spurt $c1, $challenge-one.subst('{{USER}}', $user, :g) unless $dry-run or $c1.e;
        
        my $c2 = $out-dir.add('task-two.rakumod');
        say "creating: " ~ $c2 unless $c2.e;
        spurt $c2, $challenge-two.subst('{{USER}}', $user, :g) unless $dry-run or $c2.e;
    }
}