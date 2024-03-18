#include <stdlib.h>
typedef struct vector {
  size_t cap;		/* actual size allocated (reduces calls to realloc)*/
  size_t size;			/* size of data */
  int* data;			/* integer data */
} vec;

void init_vec(struct vector* v) {
  v->size = 0;
  v->cap = 10;
  v->data = malloc(v->cap * sizeof(int));
}
void destroy_vec(struct vector* v) {
  free (v->data);		/* good habit */  
}

/* If a vector needs more memory, add 10 slots */
void stretch_vec(struct vector* v) {
  if (v->size == v->cap) {
    v->cap += 10;
    v->data = realloc(v->data, sizeof(int) * v->cap);
  }
}
void push(struct vector* v, int value) {
  v->size++;
  stretch_vec(v);
  v->data[v->size - 1] = value;
}
void unshift(struct vector* v, int value) {
  v->size++;
  stretch_vec(v);  
  for (int i = v->size - 1; i > 0; i--) {
    v->data[i] = v->data[i - 1];
  }
  v->data[0] = value;
}
int shift(struct vector* v) {
  int x = v->data[0];
  v->size--;
  for (int i = 0; i < v->size; i++) {
    v->data[i] = v->data[i + 1];
  }
  v->data[v->size] = 0;
  return x;
}
int pop(struct vector* v) {
  int x = v->data[v->size-- - 1];
  v->data[v->size] = 0;
  return x;
}

void push_list(struct vector* v, int* list) {
  // ... 
}

void sort(struct vector* v) {
  int cnt;
  do {
    cnt = 0;
    for (int i = 0; i < v->size - 1; i++) {
      if (v->data[i] > v->data[i + 1]) {
	cnt++;
	int tmp = v->data[i];
	v->data[i] = v->data[i+1];
	v->data[i+1] = tmp;
      }
    }
  } while(cnt > 0);
}
  
void reverse(struct vector* v) {
  int k = v->size / 2;
  for (int i = 0; i < k; i++) {
    int x = v->data[k-1-i];
    int idx = (v->size % 2 == 0) ? k+i : k+1+i;
    v->data[k-1-i] = v->data[idx];
    v->data[idx] = x;
  }
}

void display(struct vector* v) {
  printf("[");
  if (v->size > 0){
  for (int i = 0; i < v->size - 1; i++)
    printf("%d, ", v->data[i]);
  printf("%d", v->data[v->size-1]);
  }
  printf("]\n");
}

/* to do : allow list of chars, or strings. Maybe a union for data? */
