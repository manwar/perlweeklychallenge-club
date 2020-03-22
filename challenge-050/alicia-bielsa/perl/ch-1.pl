use strict;
use warnings;
use Data::Dumper;
use Test::More tests => 4;



my %hTestSet = ( '1' =>  {  given => [[2,7], [3,9],[10,12], [15,19], [18,22] ], 
                            expected => [[2, 9], [10, 12], [15, 22] ]  
                        },
                 '2' =>  {  given => [ [18,22] , [2,7],[10,12], [15,19], [3,9] ], 
                              expected => [[2, 9], [10, 12], [15, 22] ]  
                        },   
                 '3' =>  {  given => [ [2,7],[10,12], [15,19], [3,9],[0,22] ], 
                              expected => [[0,22] ]  
                        },   
                  '4' =>  {  given => [ [19,25],[2,7],[10,12], [15,19],[1,3] ], 
                              expected => [[1,7] ,[10,12], [15,25]]  
                        }                        
               );


foreach my $testSet (sort keys %hTestSet ){
    my @aMergedIntervalsFinal = checkIntervals( @{$hTestSet{$testSet}{given}});
    @aMergedIntervalsFinal = sort { $$a[0] <=> $$b[0] } @aMergedIntervalsFinal;
    @{$hTestSet{$testSet}{merged}} = @aMergedIntervalsFinal;
}

foreach my $testSet (sort keys %hTestSet ){ 
    my @aMergedIntervalsFinal =     @{$hTestSet{$testSet}{merged}};    
    foreach my $count ( 0..$#aMergedIntervalsFinal){
        print "[".$aMergedIntervalsFinal[$count][0].",".$aMergedIntervalsFinal[$count][1]."]";
        unless  ($count == $#aMergedIntervalsFinal){        
           print ",";
        }
    }
    is_deeply( $hTestSet{$testSet}{expected},\@aMergedIntervalsFinal   );
}

sub checkIntervals {
    my @aIntervals = @_;
    my @aMergedIntervals = ();

    foreach my $interval ( @aIntervals){
        unless(scalar @aMergedIntervals){
            push (@aMergedIntervals, $interval);
            next;
        }
        my $isMerged = 0;
        foreach my $mergedInterval (@aMergedIntervals){
            my $flagMerge = doIntervalsOverlap($interval, $mergedInterval );   

            if ($flagMerge){      
                mergeIntervals($interval, $mergedInterval);
                $isMerged = 1;                
            }
        }        
        unless  ($isMerged)  {
             push (@aMergedIntervals, $interval);
        }     
    }
    if (scalar(@aMergedIntervals) != scalar(@aIntervals)){
         checkIntervals(@aMergedIntervals);
    } else {
        return @aMergedIntervals;
    }
}

sub doIntervalsOverlap {
    my $interval  = shift;
    my $mergedInterval = shift;
    


    if ( $$interval[0] >= $$mergedInterval[0] &&  $$interval[0] <= $$mergedInterval[1] ){
        return 1;
    }
    if ( $$interval[1] >= $$mergedInterval[0] &&  $$interval[1] <= $$mergedInterval[1] ){
      return 1;
    }

    if ( $$interval[0] <= $$mergedInterval[0] &&  $$interval[1] >= $$mergedInterval[1] ){
        return 1;
    }
    if ( $$mergedInterval[0] <= $$interval[0] &&  $$mergedInterval[1] >= $$interval[1] ){
        return 1;
    }
    return 0;
}

sub mergeIntervals {
    my $interval  = shift;
    my $mergedInterval = shift;
    
    if ($$interval[0] < $$mergedInterval[0]){
        $$mergedInterval[0] = $$interval[0];
    }
    if ($$interval[1] > $$mergedInterval[1]){
        $$mergedInterval[1] = $$interval[1];
    }        
                
}

