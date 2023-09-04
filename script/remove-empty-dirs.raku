#!/usr/bin/env raku

sub MAIN (Str $base-folder, UInt $max-challenge, Bool $dry-run=True) {
    
    # removes all folders, that do not have solutions
    # by looking for folders with no subfolders

    # e.g. raku script/remove-empty-dirs.raku . 230 False

    for $base-folder.IO.dir -> $challenge-folder {
        if     $challenge-folder ~~ :d 
           and $challenge-folder ~~ /(\d+$)/ 
           and $0.Int < $max-challenge {
               for $challenge-folder.IO.dir -> $user-folder {
                  if $user-folder ~~ :d and $user-folder.dir.Int < 2 {
                      unless $user-folder.dir.grep(* ~~ :d) {
                          say "DRY RUN" if $dry-run;
                          say "removing empty " ~ $user-folder;
                          $user-folder.add("README").unlink if $user-folder.add("README") ~~ :e and not $dry-run;
                          $user-folder.add("README.md").unlink if $user-folder.add("README.md") ~~ :e and not $dry-run;
                          $user-folder.rmdir if not $dry-run;
                      }
                  }
            }
        }
    }

}