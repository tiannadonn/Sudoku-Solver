  get_difficulty_holes <- function(difficulty) {
    ranges <- list(
      easy= c(30, 38),
      medium= c(39, 47),
      hard= c(48, 55),
      expert= c(56, 64)
    )
  
    difficulty <- tolower(trimws(difficulty))
  
    if (!(difficulty %in% names(ranges))) {
      stop("Invalid difficulty: please choose from easy, medium, hard, or expert.")
    }
  
    range <- ranges[[difficulty]]
    sample(range[1]:range[2], 1)
  }

  

  has_unique_solution <- function(board) count_solutions(board, limit = 2) == 1

  generate_unique_sudoku <- function(target_holes = 45) {
    fill_board <- function(board) {
      empty <- find_empty(board)
      if (is.null(empty)) return(board)
      row <- empty[1]; col <- empty[2]
    
      for (num in sample(1:9)) {
        if (is_valid(board, row, col, num)) {
          board[row, col] <- num
          result <- fill_board(board)
          if (!is.null(result)) return(result)
          board[row, col] <- 0
        }
      }
      return(NULL)
    }
  
    full_board <- fill_board(matrix(0, nrow = 9, ncol = 9))
    puzzle <- full_board
  
    cell_order <- sample(1:81) 
    # Randomizes cell order to ensure holes vary from puzzle to puzzle.
    holes_made <- 0
  
  
    for (pos in cell_order) {
      if (holes_made >= target_holes) break
    
      row <- ((pos - 1) %% 9) + 1
      col <- ((pos - 1) %/% 9) + 1
      if (puzzle[row, col] == 0) next
    
      saved_value <- puzzle[row, col]
      puzzle[row, col] <- 0
    
      if (has_unique_solution(puzzle)) {
        holes_made <- holes_made + 1
      } else {
        puzzle[row, col] <- saved_value 
      }
    }
    list(puzzle = puzzle, solution = full_board, num_holes = holes_made)
  }