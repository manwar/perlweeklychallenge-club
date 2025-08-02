# include <stdio.h>

typedef struct input_tuple {
  int start;
  int step;
  int duration;
} input_tuple;


typedef struct time_tuple {
  int depart;
  int arrive;
} time_tuple;


int find_switch_minutes( const input_tuple inputs[], const int num_inputs, int output[], const int num_minutes ) {
    
  time_tuple next_depart[num_minutes];
  time_tuple next_arrive[num_minutes];
  for (int i=0; i < num_minutes; i++) {
    next_depart[i].arrive = next_arrive[i].arrive = 10000;
    next_depart[i].depart = next_arrive[i].depart = 10000;
  }
  
  for (int i=0; i < num_inputs; i++) {
    const int step = inputs[i].step;
    const int start = inputs[i].start;
    const int duration = inputs[i].duration;
    
    time_tuple fill_val;
    // now find the minimum for arrival time and minimum for departure time
    for (int i = num_minutes + start; i > -1; --i) {
      if ( (i - start) % step == 0 ) {
	fill_val.arrive = i + duration;
	fill_val.depart = i;
      }

      if (i >= num_minutes) {
	continue;
      }

      if (
	  (fill_val.depart < next_depart[i].depart) ||
	  (fill_val.depart == next_depart[i].depart && fill_val.arrive < next_arrive[i].arrive)
	  ) {
	next_depart[i].arrive = fill_val.arrive;
	next_depart[i].depart = fill_val.depart;
      } 
	    
      if (fill_val.arrive < next_arrive[i].arrive) {
	next_arrive[i].arrive = fill_val.arrive;
	next_arrive[i].depart = fill_val.depart;	  
      }
    }
  }
      
  // now check if any earliest leave time isn't an earliest arrive time
  int count_skips = 0;
  for (int i=0; i < num_minutes; i++) {
    if (next_arrive[i].arrive < next_depart[i].arrive) {
      output[count_skips++] = i;
    }
  }

  return count_skips;
}

int main() {
  const int num_minutes = 60;
  int outputs[num_minutes];
  for (int i=0; i < num_minutes; i++){
    printf( "%d, ", outputs[i] );
  }
  printf( "\n\n" );

  input_tuple inputs1[] = {
    {.step=12, .start=11, .duration=41},
    {.step=15, .start=5, .duration=35}
  };
  int num_inputs1 = 2;
  for (int i=0; i < num_inputs1; i++) {
    printf( "step :: %d start :: %d duration :: %d\n", inputs1[i].step, inputs1[i].start, inputs1[i].duration );
  }
  int skips1 = find_switch_minutes(inputs1, num_inputs1, outputs, num_minutes);
  for (int i=0; i < skips1; i++){
    printf( "%d, ", outputs[i] );
  }
  printf( "\n\n" );
    
  input_tuple inputs2[] = {
    {.step=12, .start=3, .duration=41},
    {.step=15, .start=9, .duration=35},
    {.step=30, .start=5, .duration=25}
  };
  int num_inputs2 = 3;
  for (int i=0; i < num_inputs2; i++) {
    printf( "step :: %d start :: %d duration :: %d\n", inputs2[i].step, inputs2[i].start, inputs2[i].duration );
  }
  int skips2 = find_switch_minutes(inputs2, 3, outputs, num_minutes);
  for (int i=0; i < skips2; i++){
    printf( "%d, ", outputs[i] );
  }
  printf( "\n\n" );
}
