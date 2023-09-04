#!/usr/bin/env raku

# assumig challenges are in folders challenge-DEMO/USER/raku/ AND
# there exist corresponding task-one.rakutest and task-two.rakutest in test/challenge-DEMO/
#
# run like: raku --optimize=3 test/benchmark-scalabiity.raku DEMO
#
# (tests and executes task-one and task-two from challenge-DEMO for all users that provided a solution via .rakumod)
#
# we can NOT use e.g. challenge-135 as folder names and NOT e.g. ch-1.rakumod as module names 
# as "challenge-135::USER::raku::ch-1" is not a valid module name for the declaration of the .rakumod solution files. 
# The problem is the "-Number" in the names, hence this workaround works as first line in .rakumod solution files:
# unit module challenge-nr135::USER1::raku::task-one:ver<0.0.1>:auth<USER1@github.com)>;

# we always start this script in root folder of project - hence we find all solutions at . subfolders!
use lib '.';

# import module from test/ folder
use lib $*PROGRAM.dirname;
use benchmark-data-generator;

enum Tasks <task-one task-two all>;

sub MAIN ( Str $challenge-identifier, Tasks $tasks = all, Numeric $max-run-time = 5, Str $out-folder = 'data/', Bool $test-before-benchmark = True ) {
    
    my $base-folder = "challenge-"  ~ $challenge-identifier;    
    die "Directory $base-folder not found!" unless $base-folder.IO.d;

    my @tasks = $tasks eq all ?? ('task-one', 'task-two') !! ($tasks.Str);
    for @tasks -> $task-string {
        say "Running $base-folder $task-string with $max-run-time secs maximum execution time, saving results to folder $out-folder.";

        my @results = [];
        # stolen from https://docs.raku.org/routine/dir at bottom of page
        my @stack = $base-folder.IO;
        my $files = gather while @stack {
            with @stack.pop {
                when :d { @stack.append: .dir }
                .take when .extension.lc eq 'rakumod' and .match(/$task-string/)
            }
        }

        for ^$files.elems {
            my $module-file = $files[$_];
            
            my ($folder, $user, $language, $module) = $module-file.extension('').Str.split('/');
            
            my $test-ok = $test-before-benchmark ?? &test-before-benchmark($module-file) !! True;
            
            if $test-ok {
                    try {
                        # see https://docs.raku.org/language/packages#Programmatic_use_of_modules to read how the following code works
                        my $m = "{$folder}::{$user}::{$language}::{$module}";
                        say "Benchmarking: $m";
                        require ::($m);
                        my &solution-under-test = &::($m)::solution;
                        my $run = start { benchmark-scalability(&solution-under-test, 
                                                                &data-provider-for($challenge-identifier, $task-string), 
                                                                $max-run-time) 
                                        };
                        await $run;
                        if $run.status eq PromiseStatus::Kept {
                            @results.push: $user, $run.result
                        }
                    }
                    if $! {
                        say "Benchmark failed for " ~ $module-file;
                    }
            }
        }
        &create-output($out-folder, $challenge-identifier, $task-string, @results);
    }
}

#| Increase problem size until a solution does not finish in time anymore.
sub benchmark-scalability(&solution, &data, $run-time){
  my @results; 

  my &simulation = &solution ∘ &data;
  for ^Inf -> $i {
      my $n = &data($i).elems; # this also ensures data input is generated and cached so influences less the metrics
      say "$n";
      my ($start, $latency, $throughput) = now;
      
      my $timer = Promise.in( $run-time );
      my $solution = start { &simulation($i) }.then( { $latency = now - $start; .result.Str } ).then( { $throughput = now - $start });
      
      my $too-slow = await Promise.anyof($timer, $solution).then( { $timer.status eq PromiseStatus::Kept } );
      last if $too-slow;

      @results.push: ($n, $latency, $throughput);
  }
  return @results;
}

#| Transform into the required output format
sub create-output($out-folder, $challenge-identifier, $task-string, @results){
    my @csv =[];
    say "Best results per user:";
    say "(user n latency throughput)";
    for @results -> $user, @data {
        for @data -> @row {
            @csv.push: flat ($user, flat @row);
            LAST say flat ($user, flat @row);
        }
    }
    my $out-file = $out-folder.IO.add($challenge-identifier ~ "_raku_" ~ $task-string ~ ".csv");
    my $out-data = @csv.map( *.join(",")).join("\n");
    say "writing to $out-file";
    spurt $out-file, $out-data;
}

#| Make sure we do not waste valuable computation time by running wrong solutions
sub test-before-benchmark($module-file) {
    my ($challenge, $user, $language) = $module-file.extension('').Str.split('/');
    my $test-file = "test".IO.add($challenge).add($language).add($module-file.extension('rakutest').basename);
    my $cmd = "raku --optimize=3 -I " ~ $module-file.dirname ~ " " ~ $test-file;
    say "Testing: $module-file";
    try {
        shell $cmd;
    }
    if $! {
        say "Test failed for " ~ $module-file;
        return False;
    }
    return True;
}
