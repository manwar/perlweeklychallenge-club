#!/usr/bin/env python
from random import shuffle, choice
from collections import deque


class Lucky_Winner:
    def __init__(self):
        self.deck = deque(['£1', '50p', '1p', '10p', '5p', '20p', '£2', '2p'])
        shuffle(self.deck)

        self.values = {'£1': 1, '50p': 0.5, '1p': 0.01, '10p': 0.1, '5p': 0.05, '20p': 0.2, '£2': 2, '2p': 0.02}
        self.players = {1: 'Player', -1: 'Computer'}
        self.sides = ['L', 'R']
        self.scores = {-1: 0, 1: 0}

    def do_draw(self, side: str):
        if side == 'L':
            return self.deck.popleft()

        return self.deck.pop()

    def get_player_input(self):

        lr = ''
        while 1:
            lr = input('Please input L for left or R for right side of the line:').upper()

            if lr in ('LR'):
                break

        return lr

    def play_round(self, who: str):

        lr = ''

        if who == 1:
            lr = self.get_player_input()
        else:
            lr = choice(self.sides)

        draw = self.do_draw(lr)

        self.scores[who] += self.values[draw]

        print(f'{self.players[who]} has drawn from {lr} and won {draw} and has now score {self.scores[who]}')

    def end_game(self):

        if self.scores[1] > self.scores[-1]:
            print('Player WON!')
        elif self.scores[1] < self.scores[-1]:
            print('Computer WON!')
        else:
            print("It's a TIE!")

    def play_game(self):
        who = -1

        while 1:
            who *= -1
            self.play_round(who)
            if len(self.deck) == 0:
                break

        self.end_game()


if __name__ == '__main__':
    game = Lucky_Winner()
    game.play_game()
