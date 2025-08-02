# include <stdio.h>
# include <stdlib.h>
# include <string.h>

typedef struct word_ll {
  char *word;
  struct word_ll *next;
} word_ll ;

word_ll build_word_chaff_ll( char *str ) {
  word_ll head = { .word=malloc( sizeof(char) * 100), .next=NULL };
  word_ll *next = &head;

  int status = 0;
  size_t word_ctr = 0;
  for (char *c = str; *c != '\0'; c++) {
    
    if (
	(status != 1 && ( (*c >= 65 && *c <= 90) || (*c >= 97 && *c <= 122) ) ) ||
	(status != 0 && !( (*c >= 65 && *c <= 90) || (*c >= 97 && *c <= 122) ))
	) {      
      next = next->next = malloc( sizeof(word_ll) );
      next->word = malloc( sizeof(char) * 100);
      word_ctr = 0;
      status = (status + 1) % 2;
    }
    next->word[word_ctr++] = *c;
  }
  
  return head;
}
  
void goatify_word( char *word, size_t alen ) {
  char temp[100] = "\0";
  int i=1;
  // starts with vowel?
  switch (*word) {
  case 'A':case 'E':case 'I':case 'O':case 'U':case 'a':case 'e':case 'i':case 'o':case 'u':
    break;
  default:
    for (i=1; word[i] != '\0'; i++) {
      temp[i-1] = word[i];
    }
    temp[i-1] = word[0];
    strcpy( word, temp );
    break;
  }
  
  i = strlen( word );
  word[i++] = 'm';
  for (int j=0; j <= alen; j++) {
    word[i++] = 'a';
  }
  word[i] = '\0';
}
      

word_ll make_to_goat_latin( char *str ) {
  word_ll list_head = build_word_chaff_ll( str );
  int word_ctr = 0;

  for (word_ll *next = &list_head; next != NULL; next = next->next) {
    if (word_ctr++ % 2) {
      goatify_word(next->word, word_ctr/2);
    }
  }
  return list_head;
}

int main(){
  char *inputs[] = {
    "I love Perl",
    "Perl and Raku are friends",
    "The Weekly Challenge",
    "Perl! and Raku?     are... friends>",
    "C is pretty good too!"
  };

  word_ll goated;
  for (int i=0; i < 5; i++) {  
    goated = make_to_goat_latin( inputs[i] );
    
    for (word_ll *next = &goated; next != NULL; next = next->next) {
      printf( "%s", next->word );
    }
    printf("\n");
    
  }
}
