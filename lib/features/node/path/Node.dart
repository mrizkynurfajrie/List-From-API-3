import 'package:flutter/material.dart';

class Node {
  int? row, col;
  int? cost;
  Color? color;
  bool? startNode;
  bool? endNode;
  bool? isWall;
  bool? isVisited;
  Node? prevNode;

  Node(
    this.color,
    this.cost,
    this.row,
    this.col,
    this.startNode,
    this.endNode,
    this.isWall,
    this.isVisited,
    this.prevNode,
  ) {
    color = color;
    cost = cost;
    row = row;
    col = col;
    startNode = startNode;
    endNode = endNode;
    isWall = isWall;
    isVisited = isVisited;
    prevNode = prevNode;
  }

  setColor(color) {
    this.color = color;
  }

  int compareTo(other) {
    if (cost! - other.cost < 0) {
      return -1;
    }
    if (cost! - other.cost > 0) {
      return 1;
    }
    if (cost! - other.cost == 0) {
      return 0;
    }
    // shouldn't get here
    return -1;
  }
}
