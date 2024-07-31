#ifndef VEC_H
#define VEC_H
#include <stdlib.h>
#include <string.h>
#define VECMAXSTRLEN 50
#define VECCAP 10
typedef struct vector {
  size_t cap;		/* actual size allocated (reduces calls to realloc)*/
  size_t size;			/* size of data */
  int* data;			/* integer data */
  char* datac;			/* char data */
  char** datas;			/* string data */
  char type;			/* i, c, or s */
} vec;

vec* new_vec(char t) {
  struct vector* v = malloc(sizeof(vec));
  if ( t != 'c' && t != 'i' && t != 's') {
    exit(1);
  }
  v->type = t;
  v->size = 0;
  v->cap = VECCAP;
  v->data = malloc(v->cap * sizeof(int));
  v->datac = malloc(v->cap * sizeof(char));
  v->datas = malloc(v->cap * sizeof(char*));
  for (int i = 0; i < v->cap; i++)
    v->datas[i] = malloc(VECMAXSTRLEN);
  return v;
}

void destroy_vec(struct vector* v) {
  free (v->data);		/* good habit */
  free (v->datac);
  for (int i = 0; i < v->cap; i++)
    free(v->datas[i]);
  free (v->datas);
  free(v);
}

/* If a vector needs more memory, add VECCAP (e.g. 10) slots */
void stretch_vec(struct vector* v) {
  if (v->size == v->cap) {
    v->cap += VECCAP;
    switch(v->type) {
    case 'i':
      v->data = realloc(v->data, sizeof(int) * v->cap);
      break;
    case 'c':
      v->datac = realloc(v->datac, sizeof(char) * v->cap);
      break;
    case 's':
      v->datas = realloc(v->datas, sizeof(char*) * v->cap);
      for (int i = v->size; i < v->cap; i++)
	v->datas[i] = malloc(VECMAXSTRLEN);
      break;
    }
  }
}

void push(struct vector* v, void* value) {
  v->size++;
  stretch_vec(v);
  switch(v->type) {
  case 'i':
    v->data[v->size - 1] = *(int *) value;
    break;
  case 'c':
    v->datac[v->size - 1] = *(char *) value;
    break;
  case 's':
    strcpy(v->datas[v->size - 1], (char *) value);
    break;
  }
}


void unshift(struct vector* v, void* value) {
  v->size++;
  stretch_vec(v);
  switch(v->type) {
  case 'i':
    for (int i = v->size - 1; i > 0; i--)
      v->data[i] = v->data[i - 1];
    v->data[0] = * (int*) value;
    break;
  case 'c':
    for (int i = v->size - 1; i > 0; i--)
      v->datac[i] = v->datac[i - 1];
    v->datac[0] = * (char*) value;
    break;
  case 's':
    for (int i = v->size - 1; i > 0; i--)
      strcpy(v->datas[i], v->datas[i - 1]);
    strcpy(v->datas[0], (char*) value);
    break;
  }
}

void* shift(struct vector* v) {
  void *x = NULL;
  if (v->size == 0) return NULL;
  v->size--;
  switch(v->type) {
  case 'i':
    x = malloc(sizeof(int));
    if (x == NULL) return NULL;
    *(int*)x = v->data[0];
    for (int i = 0; i < v->size; i++)
      v->data[i] = v->data[i + 1];
    v->data[v->size] = 0;
    break;
  case 'c':
    x = malloc(sizeof(char));
    if (x == NULL) return NULL;
    *(char *)x = v->datac[0];
    for (int i = 0; i < v->size; i++)
      v->datac[i] = v->datac[i + 1];
    v->datac[v->size] = '\0';
    break;
  case 's':
    x = malloc(VECMAXSTRLEN);
    if (x == NULL) return NULL;
    strcpy(x, v->datas[0]);
    for (int i = 0; i < v->size; i++)
      strcpy(v->datas[i], v->datas[i + 1]);
    strcpy(v->datas[v->size], "");
    break;
  }
  return x;
}

void* pop(struct vector* v) {
  void *x = NULL;
  if (v->size == 0) return NULL;
  v->size--;
  switch(v->type) {
  case 'i':
    x = malloc(sizeof(int));
    *(int*)x = v->data[v->size];
    v->data[v->size] = 0;
    break;
  case 'c':
    x = malloc(sizeof(char));
    *(char*)x = v->datac[v->size];
    v->datac[v->size] = '\0';
    break;
  case 's':
    x = malloc(VECMAXSTRLEN);
    strcpy(x, v->datas[v->size]);
    strcpy(v->datas[v->size], " ");
    break;
  }
  return x;
}

void push_list(struct vector* v, void* list, int listlen) {
  for (int i = 0; i < listlen; i++)
    switch(v->type) {
    case 'i':
      push(v, &((int*)list)[i]);
      break;
    case 'c':
      push(v, &((char*)list)[i]);
      break;
    case 's':
      push(v, ((char**)list)[i]);
      break;
    }
}

void sort(struct vector* v) {
  int cnt;
  do {
    cnt = 0;
    for (int i = 0; i < v->size - 1; i++) {
      switch(v->type) {
      case 'i':
	if (v->data[i] > v->data[i + 1]) {
	  cnt++;
	  int tmp = v->data[i];
	  v->data[i] = v->data[i+1];
	  v->data[i+1] = tmp;
	}
	break;
      case 'c':
	if (v->datac[i] > v->datac[i + 1]) {
	  cnt++;
	  char tmp = v->datac[i];
	  v->datac[i] = v->datac[i+1];
	  v->datac[i+1] = tmp;
	}
	break;
      case 's':
	if (strcmp(v->datas[i], v->datas[i + 1]) > 0) {
	  cnt++;
	  char* tmp = v->datas[i];
	  v->datas[i] = v->datas[i+1];
	  v->datas[i+1] = tmp;
	}
	break;
      }
    }
  } while(cnt > 0);
}

void reverse(struct vector* v) {
  if (v->size == 1) return;
  int k = v->size / 2;
  for (int i = 0; i < k; i++) {
    int idx = (v->size % 2 == 0) ? k+i : k+1+i;
    int idy =  k - i - 1;
    switch(v->type) {
    case 'i':
      {
	int x = v->data[idy];
	v->data[idy] = v->data[idx];
	v->data[idx] = x;
      }
      break;
    case 'c':
      {
	char x = v->datac[k-1-i];
	v->datac[idy] = v->datac[idx];
	v->datac[idx] = x;
      }
      break;
    case 's':
      {
	char* x = v->datas[k-1-i];
	v->datas[idy] = v->datas[idx];
	v->datas[idx] = x;
      }
      break;
    }
  }
}

void display(struct vector* v) {
  printf("[");
  if (v->size > 0){
    switch(v->type) {
    case 'i':
      for (int i = 0; i < v->size - 1; i++) printf("%d, ", v->data[i]);
      printf("%d", v->data[v->size-1]);
      break;
    case 'c':
      for (int i = 0; i < v->size - 1; i++) printf("%c, ", v->datac[i]);
      printf("%c", v->datac[v->size-1]);
      break;
    case 's':
      for (int i = 0; i < v->size - 1; i++) printf("%s, ", v->datas[i]);
      printf("%s", v->datas[v->size-1]);
      break;
    }
  }
  printf("]");
}

void* get(struct vector* v, int k) {
  void* x = NULL;
  switch(v->type) {
  case 'i':
    x = malloc(sizeof(int));
    *(int*) x = v->data[k];
    break;
  case 'c':
    x = malloc(sizeof(char));
    *(char*) x = v->datac[k];
    break;
  case 's':
    x = malloc(VECMAXSTRLEN);
    strcpy(x, v->datas[k]);
    break;
  }
  return x;
}

void set(struct vector* v, int k, void* value) {
  switch(v->type) {
  case 'i':
    v->data[k] = *(int*) value;
    break;
  case 'c':
    v->datac[k] = *(char*) value;
    break;
  case 's':
    strcpy(v->datas[k], (char*) value);
    break;
  }

}
#endif
