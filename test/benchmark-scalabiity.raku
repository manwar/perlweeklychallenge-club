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

my $verbose = False;
my $output-header = "user,runtime,n,latency,throughput";

enum Tasks <task-one task-two all>;
subset Name of Str;

sub MAIN ( Str $challenge-identifier,
           Tasks :task($task-string) = all, 
           Name :$user, 
           Str :$max-run-times = '1,3,7', 
           Str :$out-folder = 'data/', 
           Bool :$test-before-benchmark = True,
           Bool :$v = False ) {
    
    $verbose = $v;
    my $base-folder = "challenge-$challenge-identifier".IO;
    $base-folder = $base-folder.add($user) if $user;
    
    {note "Directory $base-folder not found!"; exit } unless $base-folder.d;

    my @tasks = $task-string eq all ?? ('task-one', 'task-two') !! ($task-string.Str);
    for @tasks -> $task-string {
        
        my @results = [];
        # stolen from https://docs.raku.org/routine/dir at bottom of page
        my @stack = $base-folder;
        my $files = gather while @stack {
            with @stack.pop {
                when :d { @stack.append: .dir unless .match(/\.precomp/) }
                .take when .extension.lc eq 'rakumod' and .basename.match(/$task-string/);
            }
        }
        {note "No solutions found in folder: $base-folder for $task-string and $user"; exit} unless $files.elems;
        
        say "Processing " ~ $files.elems ~ " rakumod files from $base-folder $task-string, saving results to folder $out-folder." if $verbose;

        for ^$files.elems {
            my $module-file = $files[$_];
            my $test-ok = $test-before-benchmark ?? &test-before-benchmark($module-file) !! True;
                
            if $test-ok {
                my UInt @max-run-times = $max-run-times.split(',').map(*.UInt).Set.keys;
                for @max-run-times.sort -> $max-run-time {
                    my ($folder, $user, $language, $module) = $module-file.extension('').Str.split('/');                
                        try {
                            # see https://docs.raku.org/language/packages#Programmatic_use_of_modules to read how the following code works
                            my $m = "{$folder}::{$user}::{$language}::{$module}";
                            say "Benchmarking $m for $max-run-time secs";
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
                            note "Benchmark failed for " ~ $module-file ~ " " ~ $!;
                        }
                }
            }
        }
        if @results.elems {
            &create-output($out-folder, $challenge-identifier, $task-string, @results) 
        }else{
            note "No output generated for $challenge-identifier, $task-string, $user";
        }
    }
}

#| Increase problem size until a solution does not finish in time anymore.
sub benchmark-scalability(&solution, &data, $run-time){
  my @results; 

  my &simulation = &solution ∘ &data;
  for ^Inf -> $i {
      my $n = &data($i).elems; # this also ensures data input is generated and cached so influences less the metrics
      print "$n " if $verbose;
      my ($start, $latency, $throughput) = now;
      
      my $timer = Promise.in( $run-time );
      my $solution = start { &simulation($i) }.then( { $latency = now - $start; .result.Str } ).then( { $throughput = now - $start });
      
      my $too-slow = await Promise.anyof($timer, $solution).then( { $timer.status eq PromiseStatus::Kept } );
      last if $too-slow;

      @results.push: ($run-time, $n, $latency, $throughput);
  }
  return @results;
}

#| Transform into the required output format
sub create-output($out-folder, $challenge-identifier, $task-string, @results){
    my @csv =[];
    say "Best results per user:" if $verbose;
    say '(' ~ $output-header ~ ')' if $verbose;
    for @results -> $user, @data {
        for @data -> @row {
            @csv.push: flat ($user, flat @row);
            LAST say flat ($user, flat @row) if $verbose;
        }
    }
    my $out-dir = $out-folder.IO.add($challenge-identifier ~ "_" ~ $task-string ~ ".csv");
    my $out-data = $output-header ~ "\n" ~ @csv.map( *.join(",")).join("\n") ~ "\n";
    say "writing to $out-dir" if $verbose;
    spurt $out-dir, $out-data;
}

#| Make sure we do not waste valuable computation time by running wrong solutions
sub test-before-benchmark($module-file) {
    my ($challenge, $user, $language) = $module-file.extension('').Str.split('/');
    my $test-file = "test".IO.add($challenge).add($language).add($module-file.extension('rakutest').basename);
    my $cmd = "raku --optimize=3 -I " ~ $module-file.dirname ~ " " ~ $test-file;
    say "Testing $module-file";
    shell($cmd).so
}
