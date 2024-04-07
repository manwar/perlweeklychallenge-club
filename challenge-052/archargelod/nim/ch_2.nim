#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[deques]

type
  Player = enum
    P1, P2
  Game = object
    piles: Deque[int]
    turn: Player
    scores: tuple[p1, p2: int]
  Node = ref object
    gameState: Game
    l, r: Node
  DecisionTree = object
    head: Node

proc `$`(n: Node): string =
  $(n.l.gameState.scores, n.r.gameState.scores)

proc buildTree(node: var Node) =
  if node.gameState.piles.len == 0:
    return

  node.l = Node(gameState: node.gameState)
  node.r = Node(gameState: node.gameState)

  if node.gameState.turn == P1:
    node.l.gamestate.turn = P2
    node.r.gamestate.turn = P2
    node.l.gameState.scores.p1 += node.l.gameState.piles.popFirst()
    node.r.gameState.scores.p1 += node.r.gameState.piles.popLast()
  else:
    node.l.gamestate.turn = P1
    node.r.gamestate.turn = P1
    node.l.gameState.scores.p2 += node.l.gameState.piles.popFirst()
    node.r.gameState.scores.p2 += node.r.gameState.piles.popLast()

  buildTree(node.l)
  buildTree(node.r)

proc minimax(node: Node, maxiPlayer: bool): int =
  if node.gameState.piles.len == 0:
    if node.gameState.scores.p1 > node.gameState.scores.p2:
      return node.gameState.scores.p1
    elif node.gameState.scores.p1 < node.gameState.scores.p2:
      return -1 * node.gameState.scores.p2
    else:
      return int(0)

  if maxiPlayer:
    var bestVal = int.low
    let val = minimax(node.l, false)
    let val2 = minimax(node.r, false)
    bestVal = max(bestVal, max(val, val2))
    return bestVal
  else:
    var bestVal = int.high
    let val = minimax(node.l, true)
    let val2 = minimax(node.r, true)
    bestVal = min(bestVal, min(val, val2))
    return bestVal

proc maxWinScore*(player: Player, piles: openArray[int]): int =
  var tree = DecisionTree(
    head: Node(
      gamestate: Game(
        piles: piles.toDeque,
        turn: P1,
        scores: (0, 0)
      )
    )
  )
  buildTree(tree.head)
  minimax(tree.head, player == P1)

when isMainModule:
  import std/unittest

  suite "Lucky Winner":
    test "First player can force win with score 306":
      let score = P1.maxWinScore([100, 50, 1, 10, 5, 20, 200, 2])
      check score > 0
      check score == 306
