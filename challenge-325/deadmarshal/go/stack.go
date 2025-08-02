package main

import (
	"errors"
)

var ErrStackEmpty = errors.New("ErrStackEmpty")

type Node[T comparable] struct {
	data T
	next *Node[T]
}

// Stack using singly linked list:
type Stack[T comparable] struct {
	head *Node[T]
}

func (stack Stack[T]) IsEmpty() bool {
	return stack.head == nil
}

func (stack *Stack[T]) Push(data T) {
	stack.head = &Node[T]{data: data, next: stack.head}
}

func (stack *Stack[T]) Pop() (T, error) {
	var res T
	if stack.IsEmpty() {
		return res, ErrStackEmpty
	}
	res = stack.head.data        // save the data
	stack.head = stack.head.next // move the head one node forward
	return res, nil
}

func (stack Stack[T]) Peek() (T, error) {
	var res T
	if stack.IsEmpty() {
		return res, ErrStackEmpty
	}
	res = stack.head.data
	return res, nil
}
