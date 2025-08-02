#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define max_length 200
#define rows_in_file 500
#define max_num_of_fields 12
#define length_of_fieldname 30

char** read_file(char* filename) {
  FILE* fp = fopen(filename, "r");
  if (fp == NULL) return NULL;
  char** words = malloc(rows_in_file * sizeof(char*));
  if (words == NULL) return NULL;
  char buffer[max_length];
  int i = 0;
  while (fgets(buffer, max_length, fp) != NULL) {
    words[i] = malloc(max_length * sizeof(char));
    if (words[i] == NULL) return NULL;
    strcpy(words[i], buffer);
    i++;
  }
  fclose(fp);
  return words;
}  

int prev_space(int pos, char* line) {
  int i = 0;
  for (i = pos; line[i] != ' '; i--);
  return i;
}

void proc(int line_num, char* line, char* field[rows_in_file][max_num_of_fields], char* value[rows_in_file][max_num_of_fields]) {
  if (line[0] == '{') {
    int equals_position[max_num_of_fields] = {0};
    int j = 0;
    for (int i = 2; i < strlen(line); i++) {
      if (line[i] == '=') {
	equals_position[j] = i;
	j++;
      }
    }
    int num_of_fields = j;
    char id[length_of_fieldname] = {};
    j = 0;
    int id_flag = 1;
    for (int i = 3; i < strlen(line); i++) {
      if ((id_flag == 1) && (line[i] == ' '))
	continue;
      else if (id_flag == 1) {
	id[j] = line[i];
	j++;
	id_flag = 0;
      }
      else {
	if (line[i] == ' ')
	  break;
	else {
	  id[j] = line[i];
	  j++;
	}
      }
    }
    id[j] = '\0';

    char beg[4];
    for (int i = 0; i < 3; i++) {
      beg[i] = id[i];
    }
    beg[3] = '\0';
    if (0 == strcmp(beg, "end"))
      return;
    
    printf("name => %s\n", id);
    
    for (int i = 0; i < num_of_fields; i++) {
      int eq = equals_position[i];
      int sp = prev_space(eq, line);
      char word[length_of_fieldname];
      int j = 0;
      for (int k = sp + 1; k < eq; k++) {
	word[j] = line[k];
	j++;
      }
      word[j] = '\0';
      field[line_num][i] = malloc( sizeof(char) * length_of_fieldname );
      strcpy(field[line_num][i], word);
    }
    
    for (int l = 0; l < num_of_fields - 1; l++) {
      int eq = equals_position[l];
      int eq_next = equals_position[l + 1];
      int fieldlen = strlen(field[line_num][l + 1]);
      char value_word[max_length];
      int j = 0;
      for (int k = eq + 1; k < eq_next - fieldlen; k++) {
	value_word[j] = line[k];
	j++;
      }
      value_word[j] = '\0';
      value[line_num][l] = malloc( sizeof(char) * max_length );
      strcpy(value[line_num][l], value_word);
      
    }
    int eq = equals_position[num_of_fields - 1];
    char last_field[length_of_fieldname];
    j = 0;
    for (int i = eq + 1; i < strlen(line) - 3; i++) {
      last_field[j] = line[i];
      j++;
    }
    last_field[j] = '\0';
    value[line_num][num_of_fields - 1] = malloc( sizeof(char) * max_length );
    strcpy(value[line_num][num_of_fields - 1], last_field);
    
    for (int l = 0; l < num_of_fields; l++)
      printf("%s -> %s\n", field[line_num][l], value[line_num][l]);

    printf("\n");

    for (int l = 0; l < num_of_fields; l++) {
      free(value[line_num][l]);
      free(field[line_num][l]);
    }
  } else {
    printf("Text => %s", line);
  }
    
}

int main() {
  char* field[rows_in_file][max_num_of_fields];
  char* value[rows_in_file][max_num_of_fields];
  char** row = read_file("259.txt");
  for (int i = 0; row[i] != NULL; i++)
    proc(i, row[i], field, value);
  for (int i = 0; row[i] != NULL; i++) 
    free(row[i]);
  free(row);
}
