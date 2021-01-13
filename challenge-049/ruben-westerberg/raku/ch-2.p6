#!/usr/bin/env raku

my ($GET_CMD,$SET_CMD,$SYNC_CMD,$UPDATE_CMD,$DUMP_CMD)=0..4;


put "Inital backing store  contents:";
largeSlowStore($DUMP_CMD);

my $counter=0;

for ^20 {
	put "\nOperation: $counter";
	fastSmallCache(($SET_CMD+1).rand.Int,index=>20.rand.Int, value=>100.rand.Int);
	fastSmallCache($DUMP_CMD);
	put '=' x 20;
	$counter++;
}

put "Resulting backing store before flush/sync of lru cache";
largeSlowStore($DUMP_CMD);

fastSmallCache($SYNC_CMD);                                        
put "Resulting backing store after sync ";
largeSlowStore($DUMP_CMD);                                        

sub fastSmallCache($cmd,:$index,:$value){
	state $capacity=5;
	state %index;
	state @lru;
	do {
		given $cmd {
			when $GET_CMD {
				put "\nRead Cache: ";
				do {	given %index{$index} {
						when Any {
							put "-Miss";
							#cache miss
							my $val=largeSlowStore($GET_CMD,:$index);
							fastSmallCache($UPDATE_CMD,:$index,value=>$val) if  defined $val;
						}

						default {
							#cache hit
							put "-Hit";
							fastSmallCache($UPDATE_CMD,:$index,value=>$_);
						}
					}
				}

			}

			when ($SET_CMD) {
				put "\nWrite cache: ";
				fastSmallCache($UPDATE_CMD,:$index,:$value);
			}

			when ($SYNC_CMD) {
				put "Syncing cache";
				largeSlowStore($SET_CMD,index=>$_, value=>%index{$_}) for (@lru);
				%index=();
				@lru=();
			}

			when ($UPDATE_CMD) {
				put "Updating cache: $index =>  $value";
				my ($k)=(^@lru).grep({@lru[$_] == $index});
				my $tmp;
				$tmp=@lru.splice($k,1) when $k.defined;
				my $del=@lru.shift unless @lru < $capacity;
				if (defined $del) {
					put "Cache overflow";
					largeSlowStore($SET_CMD,index=>$del,value=>%index{$del});	
					%index{$del}:delete;
				}
				@lru.push: $index;
				%index{$index}=$value;	
			}
			when ($DUMP_CMD) {
				put "LRU keys: ", @lru.join: ", ";
				put "\n";
			}
			
		}
	}
}



sub largeSlowStore($cmd,:$index,:$value) {
	state @data= 10.rand.Int xx 10;
	do {
		given ($cmd) {
			sleep(2.rand);
			when ($GET_CMD) {
				put "Read backing store";
				@data[$index];
			};
			when ($SET_CMD) {
				put "Write backing store";
				@data[$index]=$value;
			}
			when ($DUMP_CMD) {
				put @data.map({ defined($_)??$_!!"N/A"}).join: ", ";
				put "";
			}
		}
	}
}
