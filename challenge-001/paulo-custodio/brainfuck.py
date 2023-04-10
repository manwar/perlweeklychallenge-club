#!/usr/bin/python3

# Run brainfuck from input
# Option:                       -t - trace execution

import sys
import getopt
import re

TAPE_SIZE = 30000
do_trace = False

class TuringMachine:
    def __init__(self, prog):
        self.tape = [0 for x in range(TAPE_SIZE)]
        self.ptr = 0
        self.prog = self.parse(prog)
        self.ip = 0

    def parse(self, prog):
        prog = re.sub(r"[^-+<>,.\[\]]+", "", prog)  # remove non-brainfuck operations
        return prog

    def done(self):
        return self.ip >= len(self.prog)

    def run(self):
        while not self.done():
            self.step()

    def step(self):
        global do_trace

        op, n = self.get_op()
        if op=="+":
            self.tape[self.ptr] = (self.tape[self.ptr] + n) & 0xff
        elif op=="-":
            self.tape[self.ptr] = (self.tape[self.ptr] - n) & 0xff
        elif op=="<":
            self.ptr -= n
            if self.ptr < 0:
                print("pointer beyond tape start")
                sys.exit(1)
        elif op==">":
            self.ptr += n
            if self.ptr < 0:
                print("pointer beyond tape end")
                sys.exit(1)
        elif op==".":
            print(chr(self.tape[self.ptr]), end="")
            if do_trace:
                print("")
        elif op==",":
            self.tape[self.ptr] = ord(sys.stdin.read(1))
        elif op=="[":
            if self.tape[self.ptr]==0:
                self.find_close()
        elif op=="]":
            if self.tape[self.ptr]!=0:
                self.find_open()
        else:
            pass                        # ignore other characters

        if do_trace:
            print(op, end=" ")
            if n!=1:
                print(n, end=" ")
            print("", end="\t")
            for i in range(self.ptr+10):
                if i==self.ptr:
                    print(f"[{self.tape[i]:3d}]", end="")
                else:
                    print(f" {self.tape[i]:3d} ", end="")
            print("")

    def get_op(self):
        if self.ip > len(self.prog):
            print("execution beyond program end")
            sys.exit(1)

        op = self.prog[self.ip]
        self.ip += 1
        n = 1
        if op in ('+', '-', '<', '>'):
            while self.ip < len(self.prog) and self.prog[self.ip]==op:
                self.ip += 1
                n += 1
        return op, n

    def find_close(self):
        num_open = 1
        while num_open > 0:
            op, n = self.get_op()
            if op=='[':
                num_open += 1
            elif op==']':
                num_open -= 1

    def find_open(self):
        num_open = 1
        self.ip -= 2            # point to op before ]
        while num_open > 0:
            if self.ip < 0:
                print("execution beyond program start")
                sys.exit(1)
            op = self.prog[self.ip]
            if op==']':
                num_open += 1
            elif op=='[':
                num_open -= 1
                if num_open==0:
                    self.ip += 1
                    return
            self.ip -= 1

# parse command line options
try:
    opts, args = getopt.getopt(sys.argv[1:], 't')
except getopt.GetoptError as err:
    print(err)
    sys.exit(1)
for o, a in opts:
    if o=="-t":
        do_trace = True
    else:
        print("unhandled option")
        sys.exit(1)
if len(args)!=1:
    print("Usage: brainfuck.py [-t] file")
    sys.exit(1)
with open(args[0]) as f:
    prog = "".join(f.readlines())

# initialize and run Turing Machine
tm = TuringMachine(prog)
tm.run()
