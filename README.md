# Sudoku Generator and Solver

This is a sudoku puzzle generator and solver built using a backtracking 
algorithm. It generates a randomized 9x9 matrix, randomly removes cells and
checks for uniqueness, and re-solves the puzzle using recursive backtracking.

## Features
- Solves any valid 9x9 Sudoku board via recursive backtracking
- Generates different puzzles with verified unique solutions
- Implemented difficulty levels (easy, medium, hard, expert) classed by number 
of cells removed from the original matrix.
- Provides a timer showing how long the computer takes to re-solve the generated
sudoku board.

## How it Works
1. **Generate a Full Board** using backtracking with randomized number order to
ensure each generated puzzle starts from a unique, solved grid.
2. **Dig Holes** Removes cells from the original matrix in a randomized order, 
checking each cell after removal that there is exactly one candidate (using a 
solution-counter function that is capped at 2.)
3. **Difficulty** is determined by the number of holes poked within the original
matrix. More holes = Less hints = Typically a more difficult puzzle.

## Example Output
\```
Generating a(n) easy puzzle with a guaranteed unique solution and 50 hints...

Confirmed unique: TRUE 

PUZZLE (0 = blank):
      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9]
 [1,]    0    5    2    0    8    7    0    0    9
 [2,]    0    9    0    4    2    5    1    8    7
 [3,]    0    0    0    9    3    0    0    2    4
 [4,]    5    6    4    0    0    9    0    7    3
 [5,]    0    3    8    6    0    2    0    4    1
 [6,]    1    2    9    0    7    4    8    0    6
 [7,]    0    8    0    0    0    1    0    0    2
 [8,]    2    1    0    7    0    3    0    9    8
 [9,]    0    0    0    2    6    8    7    1    5

Solving it back with solve_sudoku()...
      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9]
 [1,]    4    5    2    1    8    7    3    6    9
 [2,]    3    9    6    4    2    5    1    8    7
 [3,]    8    7    1    9    3    6    5    2    4
 [4,]    5    6    4    8    1    9    2    7    3
 [5,]    7    3    8    6    5    2    9    4    1
 [6,]    1    2    9    3    7    4    8    5    6
 [7,]    6    8    7    5    9    1    4    3    2
 [8,]    2    1    5    7    4    3    6    9    8
 [9,]    9    4    3    2    6    8    7    1    5

Solve time: 0.02019691 seconds

Matches the original solution? TRUE  
\```

## Known Limitations
- At higher difficulties, as the computer randomly removes hints, it is not 
always able to remove the generated number of hints while preserving a unique 
solution. There is an if() statement if this does occur, stating the accurate
number of cells the computer was able to remove.
- Generation time increases as more holes are removed, as uniqueness takes more
time to check for increasing difficulty.

## Usage
\```r
source("solver.R")
source("generator.R")
generate_puzzle("hard")
\```

## Tech
R, testthat (for unit tests)