# include <stdlib.h>
# include <stdio.h>
# include <string.h>

int main (void) {
    char *  line    = NULL;
    size_t  len     = 0;
    char *  error   = "Stack is empty";

    struct  node    {
        long          value;
        struct node * next;
    };

    struct node * stack = NULL;

    while (getline (&line, &len, stdin) != -1) {
        /*
         * Parse a value from the line of input, and
         * push it on the stack.
         */
        if (strncmp (line, "push", 4) == 0) {
            long val;
            if (sscanf (line + 4, " %ld", &val)) {
                struct node * head;
                head = (struct node *) malloc (sizeof (struct node));
                if (head == NULL) {
                    fprintf (stderr, "Out of memory!\n");
                    exit (1);
                }
                head -> value = val;
                head -> next  = stack;
                stack = head;
            }
        }

        /*
         * Pop a value from the stack; if the stack is empty,
         * this is a no-op.
         */
        if (strncmp (line, "pop", 3) == 0 && stack != NULL) {
            struct node * next;
            next = stack -> next;
            free (stack);
            stack = next;
        }

        /*
         * Print the value from the top of the stack; if the
         * stack is empty, print an error message.
         */
        if (strncmp (line, "top", 3) == 0) {
            if (stack == NULL) {
                printf ("%s\n", error);
            }
            else {
                printf ("%ld\n", stack -> value);
            }
        }

        /*
         * Find the minimum value in the stack, and print it.
         * If the stack is empty, print an error message.
         */
        if (strncmp (line, "min", 3) == 0) {
            if (stack == NULL) {
                printf ("%s\n", error);
            }
            else {
                long min = stack -> value;
                struct node * pointer = stack -> next;
                while (pointer != NULL) {
                    if (pointer -> value < min) {
                        min = pointer -> value;
                    }
                    pointer = pointer -> next;
                }
                printf ("%ld\n", min);
            }
        }
    }
    free (line);

    return (0);
}
