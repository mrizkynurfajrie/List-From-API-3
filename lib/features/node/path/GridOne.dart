//import 'dart:math';
//import 'dart:collection';

//import 'package:after_layout/after_layout.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:penggajian/features/node/path/Home.dart';
import 'package:penggajian/features/node/path/Node.dart';

class GridOne extends StatefulWidget {
  const GridOne({super.key});

  @override
  _GridOneState createState() => _GridOneState();
}

//class _GridOneState extends State<GridOne> with AfterLayoutMixin<GridOne>{
class _GridOneState extends State<GridOne> {
  // accessible to class
  // defer to largest JS value (2^53-1) since dart and JS differ
  final int int64MaxValue = 9007199254740991;
  List<List<Node>> gridState = [];
  bool _visible = false;
  bool _loaded = false;
  bool _loading = true;
  int? startRow;
  int? startCol;
  int? endRow;
  int? endCol;
  int? numCellsWidth;
  int? numCells;
  int? numRows;
  double? scale;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var size = MediaQuery.of(context).size;
      final double itemWidth = size.width;
      numCellsWidth = (size.width ~/ 40);
      double? scale = itemWidth / numCellsWidth!;
      double? num = 0;
      numRows = 0;
      int topPadding = 128;
      while (num! < (size.height - topPadding)) {
        num += scale;
        numRows == 1;
      }

      numCells = (numCellsWidth! * numRows!).toInt();
      int minusOneRow = 0;
      if (numRows! % 2 == 1) {
        minusOneRow++;
      }
      startRow = ((numRows! ~/ 2) - minusOneRow);
      startCol = (numCellsWidth! ~/ 4);
      endRow = ((numRows! ~/ 2) - minusOneRow);
      endCol = (numCellsWidth! ~/ 4) * 3;

      // initialize vals in grid which maps to visual grid
      for (int row = 0; row < numRows!; row++) {
        List<Node> curRow = [];
        for (int col = 0; col < numCellsWidth!; col++) {
          if (row == startRow && col == startCol) {
            curRow.add(Node(Colors.red, int64MaxValue, row, col, false, false,
                false, false, null));
          } else if (row == endRow && col == endCol) {
            curRow.add(Node(Colors.blue, int64MaxValue, row, col, false, false,
                false, false, null));
          } else {
            curRow.add(Node(Colors.green, int64MaxValue, row, col, false, false,
                false, false, null));
          }
        }
        gridState.add(curRow);
      }
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    numCellsWidth = (size.width ~/ 40);
    var gl = gridState.asMap().containsKey(0);
    if (gl && numCellsWidth! > gridState[0].length) {
      numCellsWidth = gridState[0].length;
    }
    final double itemWidth = size.width;
    //        TODO: adapt the screen size properly!
    //    rebuild the widget with a new widget when screen size changes! https://bit.ly/2TGK605
    if (_loaded && scale != itemWidth / numCellsWidth!) {
      return AlertDialog(
        title: const Text(
          "Please refresh page or return to previous orientation/window size",
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          "The screen size has changed and you must refresh the page with this size or make the window its previous size to continue using the application normally.",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 24.0,
        backgroundColor: uwPurple,
      );
    } else {
      scale = itemWidth / numCellsWidth!;
    }

    double? num = 0;
    int numRows = 0;
    int? topPadding = 128;
    while (num! < (size.height - topPadding)) {
      num += scale!;
      numRows += 1;
    }
    if (gl && numRows > gridState.length) {
      numRows = gridState.length;
    }
    numCells = (numCellsWidth! * numRows).toInt();

    // and then modulus gets the col
    List<int> convertIndexRowCol(idx) {
      int row = (idx / numCellsWidth).floor();
      int col = (idx % numCellsWidth);
      return [row, col];
    }

    Color? getNodeColor(number) {
      // TODO: this could be a map of the number to the rowcol
      List<int> rowCol = convertIndexRowCol(number);
      if (_loading || gridState.isEmpty) {
//          TODO: there has to be a better way!
        Future.delayed(const Duration(milliseconds: 500), () {
          return gridState.elementAt(rowCol[0]).elementAt(rowCol[1]).color;
        });
        return Colors.green;
      }
//        if (gridState.length == 0)  {
//          return Colors.green;
      else {
        return gridState.elementAt(rowCol[0]).elementAt(rowCol[1]).color;
      }
    }

    clearGrid() {
      // Clears the grid except for the start and end nodes
      for (int row = 0; row < numRows; row++) {
        for (int col = 0; col < numCellsWidth!; col++) {
          gridState[row][col].isWall = false;
          if (row == startRow && col == startCol) {
            gridState[row][col].color = Colors.red;
          } else if (row == endRow && col == endCol) {
            gridState[row][col].color = Colors.blue;
          } else {
            gridState[row][col].color = Colors.green;
          }
        }
      }
    }

    sortNodesByDistance(unvisitedNodes) {
      Comparator<Node> nodeComparator =
          (a, b) => (a.cost!.compareTo(b.cost!)).toInt();
      unvisitedNodes.sort(nodeComparator);
    }

    getAllNodes() {
      List<Node> nodes = [];
      for (int row = 0; row < gridState.length; row++) {
        for (int col = 0; col < gridState[0].length; col++) {
          nodes.add(gridState[row][col]);
        }
      }
      return nodes;
    }

    List<Node> getUnvisitedNeighbors(Node node) {
      List<Node>? neighbors = [];
      int? col = node.col;
      int? row = node.row;
      if (row! > 0) {
        neighbors.add(gridState[row - 1][col!]);
//          print("Add upper");
      }
      if (row < gridState.length - 1) {
        neighbors.add(gridState[row + 1][col!]);
//          print("Add lower");
      }
      if (col! > 0) {
        neighbors.add(gridState[row][col - 1]);
//          print("Add left");
      }
      if (col < gridState[0].length - 1) {
        neighbors.add(gridState[row][col + 1]);
//          print("Add right");
      }
//        print("NEIGHBOR CHECK");
//        for(int i = 0; i < neighbors.length; i++){
//          print(neighbors[i].row);
//          print(neighbors[i].col);
//          print(neighbors[i].cost);
//          print(neighbors[i].isVisited);
//          print(neighbors[i].color);
//          print("-----***");
//        }
      return neighbors.where((f) => !f.isVisited!).toList();
    }

    List<Object> shift(List<Object> list, int v) {
      if (list == null || list.isEmpty) {
        return list;
      }
      var i = v % list.length;
      return list.sublist(i)..addAll(list.sublist(0, i));
    }

    updateUnvisitedNeighbors(node) {
      List<Node> unvisitedNeighbors = getUnvisitedNeighbors(node);
      for (int i = 0; i < unvisitedNeighbors.length; i++) {
        unvisitedNeighbors[i].cost = node.cost + 1;
        unvisitedNeighbors[i].prevNode = node;
      }
    }

    List<Node> getNodesInShortestPathOrder(Node node) {
      List<Node> nodesInShortestPathOrder = [];
      while (node != null) {
        nodesInShortestPathOrder.insert(0, node);
        setState(() {
          if (node.row == startRow && node.col == startCol) {
          } else {
            gridState[node.row!][node.col!].color = Colors.white;
          }
        });
        node = node.prevNode!;
      }
      return nodesInShortestPathOrder;
    }

    dijkstra() {
//        if (gridState[startRow][startCol] != null || gridState[endRow][endCol] != null) {
////          TODO: determine the equality of the start/end node
//          return false;
//        }

      print("********GO");
      List<Node> visitedNodesInOrder = [];
      Node? closestNode;
      List<Node> unvisitedNodes = getAllNodes();

      gridState[startRow!][startCol!].cost = 0;
      while (unvisitedNodes.isNotEmpty) {
        sortNodesByDistance(unvisitedNodes);
        if (unvisitedNodes.isNotEmpty && unvisitedNodes.isNotEmpty) {
          closestNode = unvisitedNodes.removeAt(0);
        }
        //          TODO: handle wall properly
        if (closestNode!.isWall!) {
          continue;
        }
        if (closestNode.cost == int64MaxValue) {
          return visitedNodesInOrder;
        }
        if (closestNode.row == endRow && closestNode.col == endCol) {
          print("WE MADE IT!");
          getNodesInShortestPathOrder(closestNode.prevNode!);

          return visitedNodesInOrder;
        }
        updateUnvisitedNeighbors(closestNode);
        setState(() {
          closestNode!.isVisited = true;
          if (closestNode.row == startRow && closestNode.col == startCol) {
          } else {
            closestNode.color = Colors.black;
          }
        });
        visitedNodesInOrder.add(closestNode);
      }
    }

    _loaded = true;

    return Scaffold(
        body: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            crossAxisCount: numCellsWidth ?? 0,
            children: List.generate(numCells!, (index) {
              List<int> rowCol = convertIndexRowCol(index);
              return GestureDetector(
                onTap: () => setState(() {
                  if (gridState[rowCol[0]][rowCol[1]].isWall!) {
                    gridState[rowCol[0]][rowCol[1]].color = Colors.green;
                    gridState[rowCol[0]][rowCol[1]].isWall = false;
                  } else if (rowCol[1] == startCol && rowCol[0] == startRow) {
                  } else if (rowCol[0] == endRow && rowCol[1] == endCol) {
                  } else {
                    gridState[rowCol[0]][rowCol[1]].color = Colors.yellow;
                    gridState[rowCol[0]][rowCol[1]].isWall = true;
                  }
                }),
                onLongPress: () => setState(() {
                  _visible = !_visible;
                }),
                child: Card(
                  margin: const EdgeInsets.all(1.0),
                  elevation: 0,
                  child: AnimatedContainer(
                    curve: Curves.ease,
                    color: getNodeColor(index),
                    duration: const Duration(milliseconds: 500),
                    child: Align(
                      child: Container(
                        alignment: Alignment.center,
                        child: AnimatedOpacity(
                          opacity: _visible ? 1.0 : 0.0,
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 1000),
                          child: Text(
                            index % 2 == 0 ? "🧹" : "✨",
                            style: const TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            })),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _visible = !_visible;
                      });
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        setState(() {
                          _visible = !_visible;
                          clearGrid();
                        });
                      });
                    },
                    tooltip: 'Clear Walls',
                    backgroundColor: uwPurple,
                    child: const Icon(Icons.flip),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      dijkstra();
//                  setState(() {
//                    _visible = !_visible;
//                  });
                    },
                    tooltip: 'Go!',
                    backgroundColor: uwPurple,
                    child: const Icon(Icons.directions),
                  ),
                ])));
  }
}
