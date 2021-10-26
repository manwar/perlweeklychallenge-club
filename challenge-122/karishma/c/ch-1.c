#include <stdio.h>
int main() {
    int n=0;
    int* ptr;
    printf("Enter total number of inputs to be entered: ");
    scanf("%d", &n);
    ptr = (int*)calloc(n, sizeof(int));
    if (ptr == NULL) {
        printf("Memory not allocated.\n");
        exit(0);
    }
    else {
        for (int i = 1; i <= n; i++) {
            int temp=0;
            scanf("%d",&temp);
            ptr[i] = temp;
        }
        printf("\n");
    }
    int sum = 0;
    for (int j = 1; j <= n; j++) {
        sum += ptr[j];
        printf("%d ", sum / j);
    }
    printf("\n");
    free(ptr);
    return 0;
}