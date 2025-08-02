# include <stdio.h>
# include <string.h> // strcpy, strcat, strtok_r


void defang(char * input, char * output) {
  size_t out_index = 0;
  for (; *input != '\0'; input++) {
    if (*input == '.') {
      output[out_index++] = '[';
      output[out_index++] = '.';
      output[out_index++] = ']';
    }
    else {
      output[out_index++] = *input;
    }
  }
  output[out_index] = '\0';
}


int main() {
  const size_t strmax = 20;
  const size_t num_strings = 2;
  char inputs[num_strings][strmax] = {
    "1.1.1.1",
    "255.101.1.0"
  };

  // max size if all chars are '.'
  char outputs[num_strings][strmax * 3];
  for (int i=0; i < num_strings; i++) {
      printf("%s => ", inputs[i]);
      defang(inputs[i], outputs[i]);
      printf("%s\n", outputs[i]);
  }
}
