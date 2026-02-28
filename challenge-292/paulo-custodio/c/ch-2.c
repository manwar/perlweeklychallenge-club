#include "alloc.h"

// check if we have /A[^A]+A/
bool is_ball_needed_later(char ball, Str* board) {
    // find first equal ball
    const char* p = strchr(board->body, ball);
    if (p == NULL)
        return false;

    // skip equal balls
    while (*p != '\0' && *p == ball)
        p++;
    if (*p == '\0')
        return false;

    // skip different balls
    p = strchr(p, ball);
    if (p == NULL)
        return false;
    else
        return true;
}

void ball_hand_to_board(Str* board, Str* hand, int pos_board) {
    char ball = board->body[pos_board];

    // insert in board
    str_reserve(board, 1);
    memmove(board->body+pos_board+1, board->body+pos_board, strlen(board->body+pos_board)+1);

    // delete from hand
    char* p = strchr(hand->body, ball);
    memmove(p, p+1, strlen(p+1)+1);
}

void delete_groups_of_3(Str* board) {
    for (char* p = board->body; *p != '\0'; p++) {
        char* q = p;
        while (*q != '\0' && *q == *p)
            q++;
        if (q - p >= 3) {
            memmove(p, q, strlen(q)+1);
            p = board->body-1; // needs to restart search
        }
        else {
            p = q - 1;
        }
    }
}

bool draw(Str* board, Str* hand) {
    // check if any of the balls in the hand that are not needed later
    // to complete a sequence, i.e. /A[^A]+A/
    // are the same color as a group of 2 equal balls
    for (int i = 0; hand->body[i] != '\0'; i++) {
        char ball = hand->body[i];
        if (is_ball_needed_later(ball, board))
            continue;

        char find[3] = {ball, ball, 0};
        const char* p = strstr(board->body, find);
        if (p == NULL)
            continue;

        ball_hand_to_board(board, hand, p - board->body);
        delete_groups_of_3(board);
        return true;
    }

    // play any ball from the hand next to a ball of the same color in the board
    for (int i = 0; board->body[i] != '\0'; i++) {
        char ball = board->body[i];
        const char* p = strchr(hand->body, ball);
        if (p == NULL)
            continue;

        ball_hand_to_board(board, hand, i);
        delete_groups_of_3(board);
        return true;
    }

    return false;
}

int play(Str* board, Str* hand) {
    int rounds = 0;
    while (true) {
        if (board->body[0] == '\0')
            return rounds;      // won the game
        if (hand->body[0] == '\0')
            return -1;          // lost the game
        if (!draw(board, hand))
            return -1;          // lost the game
        rounds++;
    }
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s board hand", argv[0]);

    Str* board = str_new(); str_append(board, argv[1]);
    Str* hand  = str_new(); str_append(hand,  argv[2]);

    int rounds = play(board, hand);
    printf("%d\n", rounds);

    str_free(board);
    str_free(hand);
}
