use v5.36;
##
# Given a profile as a list of altitudes, return the leftmost widest valley. 
# A valley is defined as a subarray of the profile consisting of two 
# parts: the first part is non-increasing and the second part is non-decreasing. 
# Either part can be empty.
##
use boolean;
use FSA::Rules;

sub widest_valley_rules{
    my @altitudes = @_;
    my @downslope;
    my @upslope;
    my $fsa = FSA::Rules->new(
        move => {
			do => sub{  my $state = shift;
				        $state->machine->{altitude}  = [] if(!$state->machine->{altitude});
				        $state->machine->{plateau}   = [] if(!$state->machine->{plateau});
				        $state->machine->{downslope} = [] if(!$state->machine->{downslope});
				        $state->machine->{upslope}   = [] if(!$state->machine->{upslope});
				        my $previous_altitudes = $state->machine->{altitude};
				        my $current_altitude = shift @altitudes;
				        push @{$previous_altitudes}, $current_altitude
			},
			rules => [ done      => sub{  my $state = shift; 
				                          my $previous_altitudes = $state->machine->{altitude}; 
				                          !defined($previous_altitudes->[@{$previous_altitudes} - 1]) 
				       },
				       move      => sub{  my $state = shift; 
				                          my $previous_altitudes = $state->machine->{altitude}; 
				                          @{$previous_altitudes} ==  1; 
				       },
				       plateau   => sub{  my $state = shift; 
				                          my $previous_altitudes = $state->machine->{altitude}; 
				                          if(@{$previous_altitudes} == 2){
				                              if($previous_altitudes->[@{$previous_altitudes} - 1] == $previous_altitudes->[@{$previous_altitudes} - 2]){
				                                  push @{$state->machine->{plateau}}, $previous_altitudes->[@{$previous_altitudes} - 2], $previous_altitudes->[@{$previous_altitudes} - 1];
				                              }
				                          }
				       },
				       plateau   => sub{  my $state = shift; 
				                          my $previous_altitudes = $state->machine->{altitude}; 
				                          if(@{$previous_altitudes} > 2){
				                              if($previous_altitudes->[@{$previous_altitudes} - 1] == $previous_altitudes->[@{$previous_altitudes} - 2]){
				                                  push @{$state->machine->{plateau}}, $previous_altitudes->[@{$previous_altitudes} - 1];
				                              }
				                          }
				       },
				       downslope => sub{  my $state = shift; 
				                          my $previous_altitudes = $state->machine->{altitude}; 
				                          if(@{$previous_altitudes} == 2){
				                              if($previous_altitudes->[@{$previous_altitudes} - 1] < $previous_altitudes->[@{$previous_altitudes} - 2]){
				                                  push @{$state->machine->{downslope}}, $previous_altitudes->[@{$previous_altitudes} - 2], $previous_altitudes->[@{$previous_altitudes} - 1];
				                              }
				                          }
				       },
				       downslope => sub{  my $state = shift; 
				                          my $previous_altitudes = $state->machine->{altitude}; 
				                          if(@{$previous_altitudes} > 2){
				                              if($previous_altitudes->[@{$previous_altitudes} - 1] < $previous_altitudes->[@{$previous_altitudes} - 2]){
				                                  push @{$state->machine->{downslope}}, $previous_altitudes->[@{$previous_altitudes} - 1];
				                              }else{false}
				                          } 
				       },
				       upslope => sub{  my $state = shift; 
				                        my $previous_altitudes = $state->machine->{altitude}; 
				                        if(@{$previous_altitudes} == 2){
				                           if($previous_altitudes->[@{$previous_altitudes} - 1] > $previous_altitudes->[@{$previous_altitudes} - 2]){
				                               push @{$state->machine->{upslope}}, $previous_altitudes->[@{$previous_altitudes} - 2], $previous_altitudes->[@{$previous_altitudes} - 1];
				                           }
				                        } 
				       },
				       upslope => sub{  my $state = shift; 
				                        my $previous_altitudes = $state->machine->{altitude}; 
				                        if(@{$previous_altitudes} > 2){
				                           if($previous_altitudes->[@{$previous_altitudes} - 1] > $previous_altitudes->[@{$previous_altitudes} - 2]){
				                               push @{$state->machine->{upslope}}, $previous_altitudes->[@{$previous_altitudes} - 1];
				                           }
				                        } 
				       },
			],
        },
        plateau => {             
            do => sub{  my $state = shift;
                        my $previous_altitudes = $state->machine->{altitude}; 
                        my $current_altitude = shift @altitudes; 
                        push @{$previous_altitudes}, $current_altitude;
            },
            rules => [ done      => sub{  my $state = shift; 
				                          my $previous_altitudes = $state->machine->{altitude}; 
				                          !defined($previous_altitudes->[@{$previous_altitudes} - 1]) 
				       },  
				       plateau   => sub{  my $state = shift; 
				                          my $previous_altitudes = $state->machine->{altitude}; 
				                          if($previous_altitudes->[@{$previous_altitudes} - 1] == $previous_altitudes->[@{$previous_altitudes} - 2]){
				                               push @{$state->machine->{plateau}}, $previous_altitudes->[@{$previous_altitudes} - 1];
				                          }
				       }, 	    
                       downslope => sub{  my $state = shift; 
				                          my $previous_altitudes = $state->machine->{altitude}; 
				                          if($previous_altitudes->[@{$previous_altitudes} - 1] < $previous_altitudes->[@{$previous_altitudes} - 2]){
                                              push @{$state->machine->{downslope}}, @{$state->machine->{plateau}};
                                              push @{$state->machine->{downslope}}, $previous_altitudes->[@{$previous_altitudes} - 1];
				                              $state->machine->{plateau} = [];
				                          }
				       },
				       upslope   => sub{  my $state = shift; 
				                          my $previous_altitudes = $state->machine->{altitude}; 
				                          if($previous_altitudes->[@{$previous_altitudes} - 1] > $previous_altitudes->[@{$previous_altitudes} - 2]){
				                              push @{$state->machine->{upslope}}, @{$state->machine->{plateau}};
                                              push @{$state->machine->{upslope}}, $previous_altitudes->[@{$previous_altitudes} - 1];
				                              $state->machine->{plateau} = [];
				                          }
				       } 	    
            ], 
        },
        downslope => {
            do => sub{  my $state = shift;
                        my $previous_altitudes = $state->machine->{altitude}; 
                        my $current_altitude = shift @altitudes;
                        push @{$previous_altitudes}, $current_altitude;
            },
            rules => [ done      => sub{  my $state = shift; 
				                          my $previous_altitudes = $state->machine->{altitude}; 
				                          !defined($previous_altitudes->[@{$previous_altitudes} - 1]) 
				       },   
				       plateau   => sub{  my $state = shift; 
				                          my $previous_altitudes = $state->machine->{altitude}; 
				                          if($previous_altitudes->[@{$previous_altitudes} - 1] == $previous_altitudes->[@{$previous_altitudes} - 2]){
				                               push @{$state->machine->{plateau}}, $previous_altitudes->[@{$previous_altitudes} - 2], $previous_altitudes->[@{$previous_altitudes} - 1];
				                               #pop @{$state->machine->{downslope}};true;
				                          }
				       }, 	   
                       downslope => sub{  my $state = shift; 
				                          my $previous_altitudes = $state->machine->{altitude}; 
				                          if($previous_altitudes->[@{$previous_altitudes} - 1] < $previous_altitudes->[@{$previous_altitudes} - 2]){
				                              push @{$state->machine->{downslope}}, $previous_altitudes->[@{$previous_altitudes} - 1];
				                          } 
				                    },
				       upslope   => sub{  my $state = shift; 
				                          my $previous_altitudes = $state->machine->{altitude}; 
				                          if($previous_altitudes->[@{$previous_altitudes} - 1] > $previous_altitudes->[@{$previous_altitudes} - 2]){
				                               $state->machine->{upslope} = [];
				                               push @{$state->machine->{upslope}}, $previous_altitudes->[@{$previous_altitudes} - 1];
				                          }	
				                    }, 	    
            ], 
        },
        upslope => {             
            do => sub{  my $state = shift;
                        my $previous_altitudes = $state->machine->{altitude}; 
                        my $current_altitude = shift @altitudes;
                        push @{$previous_altitudes}, $current_altitude; 
            },
            rules => [ done      => sub{  my $state = shift; 
				                          my $previous_altitudes = $state->machine->{altitude}; 
				                          !defined($previous_altitudes->[@{$previous_altitudes} - 1]) 
				       },   
                       done      => sub{  my $state = shift; 
				                          my $previous_altitudes = $state->machine->{altitude}; 
				                          $previous_altitudes->[@{$previous_altitudes} - 1] < $previous_altitudes->[@{$previous_altitudes} - 2];
				       }, 
				       plateau   => sub{  my $state = shift; 
				                          my $previous_altitudes = $state->machine->{altitude}; 
				                          if($previous_altitudes->[@{$previous_altitudes} - 1] == $previous_altitudes->[@{$previous_altitudes} - 2]){
				                               push @{$state->machine->{plateau}}, $previous_altitudes->[@{$previous_altitudes} - 2], $previous_altitudes->[@{$previous_altitudes} - 1];
				                          }
				       }, 	
				       upslope   => sub{  my $state = shift; 
				                          my $previous_altitudes = $state->machine->{altitude}; 
				                          if($previous_altitudes->[@{$previous_altitudes} - 1] > $previous_altitudes->[@{$previous_altitudes} - 2]){
				                               push @{$state->machine->{upslope}}, $previous_altitudes->[@{$previous_altitudes} - 1];
				                          }
				       } 	    
            ], 
        },
        done => { 
            do => sub { my $state = shift; 
                        say q/Valley: / . join(q/, /,  @{$state->machine->{downslope}}, @{$state->machine->{upslope}});
                  } 
        },
    );
    return $fsa;
}

sub widest_valley{
    my $rules = widest_valley_rules(@_);
    $rules->start;
    $rules->switch until $rules->at(q/done/);
}

MAIN:{
    widest_valley 1, 5, 5, 2, 8;
    widest_valley 2, 6, 8, 5;
    widest_valley 2, 1, 2, 1, 3;
}