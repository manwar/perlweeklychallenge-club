#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>

#define ToLower(s)							\
  for (char *p_ptr = s; *p_ptr; p_ptr++) *p_ptr = tolower(*p_ptr);

typedef struct word_count_node {
  char *word;
  int count;
  struct word_count_node *left;
  struct word_count_node *right;
} word_count_node;

word_count_node* find_or_add_node( word_count_node *node, char *word ) {
  if (!node) {
    word_count_node *new_node = malloc(sizeof(word_count_node));
    new_node->word = strdup(word);
    new_node->count = 0;
    return new_node;
  }

  int val;
  while (1) {
    if ((val = strcmp(word, node->word))) {
      if (val < 0) {
	if (node->left) {
	  node = node->left;
	} else {
	  word_count_node *new_node = malloc(sizeof(word_count_node));
	  new_node->word = strdup(word);
	  new_node->count = 0;
	  return node->left = new_node;
	}
      } else {
	if (node->right) {
	  node = node->right;
	} else {
	  word_count_node *new_node = malloc(sizeof(word_count_node));
	  new_node->word = strdup(word);
	  new_node->count = 0;
	  return node->right = new_node;
	}
      }
    }
    else {
      return node;
    }
  }
}

word_count_node* process_left_chain( word_count_node *node ) {
  if (!(node && node->left)) {
    return node;
  }
  word_count_node *temp, *last = NULL;
  while (node) {
    temp = node->left;
    node->left = last;
    last = node;
    node = temp;
  }
  return last;
}

word_count_node* linearize_tree( word_count_node *node ) {
  word_count_node *temp, *first;
  first = node = process_left_chain( node );
  while (node->right || node->left) {
    if (node->right) {
      temp = node->right;
      node->right = process_left_chain( node->right );
      temp->left = node->left;
      node = node->right;
    } else {
      node->right = node->left;
      node = node->left;
    }
  }
  return first;
}
      
int count_common( char **words1, int n1, char **words2, int n2 ) {
  word_count_node *counts1 = find_or_add_node( NULL, words1[0] );
  counts1->count++;
  word_count_node *node;
  for (int i=1; i < n1; i++) {
    node = find_or_add_node( counts1, words1[i] );
    node->count++;
  }
  counts1 = linearize_tree( counts1 );

  word_count_node *counts2 = find_or_add_node( NULL, words2[0] );
  counts2->count++;
  for (int i=1; i < n2; i++) {
    node = find_or_add_node( counts2, words2[i] );
    node->count++;
  }
  counts2 = linearize_tree( counts2 );

  int count = 0;
  int compval;
  while (1) {
    for (; counts1 && counts1->count != 1; counts1 = counts1->right) {}
    for (; counts2 && counts2->count != 1; counts2 = counts2->right) {}

    if (!(counts1 && counts2))
      return count;

    if ((compval = strcmp(counts1->word, counts2->word))) {
      if (compval < 0) {
	counts1 = counts1->right;
      } else {
	counts2 = counts2->right;
      }
    } else {
      count++;
      counts1 = counts1->right;
      counts2 = counts2->right;
    }
  }
}

int main() {
  int const num_inputs = 3;
  int input_lengths[num_inputs][2] = {
    {4, 5},
    {6, 6},
    {6, 5}
  };
  char *words[num_inputs][2][6] = {
    {
      {"Perl", "is", "my", "friend"},
      {"Perl", "and", "Raku", "are", "friend"}
    },
    {
      {"Perl", "and", "Python", "are", "very", "similar"},
      {"Python", "is", "top", "in", "guest", "languages"}
    },
    {
      {"Perl", "is", "imperative", "Lisp", "is", "functional"},
      {"Crystal", "is", "similar", "to", "Ruby"}
    }
  };
  for (int i=0; i < num_inputs; i++) {
    int val = count_common(
			   words[i][0], input_lengths[i][0],
			   words[i][1], input_lengths[i][1]
			   );
    printf("input: %d val: %d\n",i,  val);
  }
}

