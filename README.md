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
<img width="715" height="559" alt="image" src="https://github.com/user-attachments/assets/b5dc7d6c-e715-47f2-b8d1-64780eef904b" />

## Known Limitations
- At higher difficulties, as the computer randomly removes hints, it is not 
always able to remove the generated number of hints while preserving a unique 
solution. There is an if() statement if this does occur, stating the accurate
number of cells the computer was able to remove.
- Generation time increases as more holes are removed, as uniqueness takes more
time to check for increasing difficulty.


