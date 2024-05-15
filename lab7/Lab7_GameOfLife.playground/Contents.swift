import UIKit
let rowsGrid = 4
let columnsGrid = 4

var old = [[Int]]()

for i in 0..<rowsGrid {
    var row = [Int]()
    for j in 0..<columnsGrid {
        row.append(Int(arc4random() % 2))
    }
    old.append(row)
}

// old = [[1, 1, 0, 1], [0, 1, 0, 0], [0, 0, 0, 0], [1, 1, 1, 0]]

// Deep copy
var new = [[Int]]()
for row in old {
    var newRow = [Int]()
    for element in row {
        newRow.append(element)
    }
    new.append(newRow)
}

print(old)

let neighbours = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1),  (1, 0),  (1, 1)]

nextGeneration()

print(new)

func nextGeneration () {
    for i in 0..<rowsGrid {
        for j in 0..<columnsGrid {
            var liveNeighbours = countLiveNeighbors(row: i, col: j, grid: new)
            applyRules(currentRow: i, currentColumn: j, liveNeighbours: liveNeighbours)
        }
    }
}

func applyRules (currentRow: Int, currentColumn: Int, liveNeighbours: Int) {
    if new[currentRow][currentColumn] == 1 {
        if liveNeighbours < 2 {
            new[currentRow][currentColumn] = 0
        } else if liveNeighbours > 3 {
            new[currentRow][currentColumn] = 0
        }
    } else if liveNeighbours == 3 {
        new[currentRow][currentColumn] = 1
    }
}

func countLiveNeighbors(row: Int, col: Int, grid: [[Int]]) -> Int {
    var liveNeighbours = 0
    for neighbour in neighbours {
        var neighbourRow = row + neighbour.0
        var neighbourCol = col + neighbour.1
        
        // check if within boundaries
        if (neighbourRow >= 0 && neighbourRow < rowsGrid && neighbourCol >= 0 && neighbourCol < columnsGrid) {
            if grid[neighbourRow][neighbourCol] == 1 {
                liveNeighbours+=1
            }
        }
    }
    return liveNeighbours
}
