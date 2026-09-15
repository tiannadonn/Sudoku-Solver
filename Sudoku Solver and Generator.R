# ============================================
# SUDOKU SOLVER AND GENERATOR
# ============================================
# Board is represented with a 9x9 matrix where 0 = a blank space.


# 
  is_valid <- function(board, row, col, num) {
    if (num %in% board[row, ]) return(FALSE)
    if (num %in% board[, col]) return(FALSE)
  
    box_row_start <- ((row - 1) %/% 3) * 3 + 1 
    box_col_start <- ((col - 1) %/% 3) * 3 + 1
    box <- board[box_row_start:(box_row_start + 2),
               box_col_start:(box_col_start + 2)]
    if (num %in% box) return(FALSE)
  
    TRUE
  }
  
#
  
  find_empty <- function(board) {
    for (row in 1:9) {
      for (col in 1:9) {
        if (board[row, col] == 0) return(c(row, col))
      }
    }
    return(NULL)
  }
  
# 
  
  solve_sudoku <- function(board) {
    empty <- find_empty(board)
    if (is.null(empty)) return(board)
    
    row <- empty[1]; col <- empty[2]
    
    for (num in 1:9) {
      if (is_valid(board, row, col, num)) {
        board[row, col] <- num
        result <- solve_sudoku(board)
        if (!is.null(result)) return(result)
        board[row, col] <- 0
      }
    }
    return(NULL)
  }
  
#
  
  count_solutions <- function(board, limit=2) { 
  # Function limited to two solutions because solution MUST be unique.
  # Solution is either value (1), unique, or (2+), not unique.
  # Any value higher than 2 is redundant.
    counter <- new.env()
    counter$count <- 0
    
    helper <- function(board) {
      if (counter$count >= limit) return(invisible(NULL))
    
      empty <- find_empty(board)
      if (is.null(empty)) {
        counter$count <- counter$count + 1
        return(invisible(NULL))
      }
    
    row <- empty[1]; col <- empty[2]
    for (num in 1:9) {
      if (counter$count >= limit) break
      if(is_valid(board, row, col, num)) {
        board[row, col] <- num
        helper(board)
        board[row, col] <- 0
      }
    }
  }
  
  helper(board)
  counter$count
  }
  
  
  # Setting parameters for difficulty
  
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
  
  #

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

  generate_puzzle <- function(difficulty = "medium") {
    num_holes <- get_difficulty_holes(difficulty)
    
    cat("Generating a(n)", difficulty, "puzzle with a guaranteed unique solution and", 81-num_holes, "hints...\n\n")
    
    result <- generate_unique_sudoku(target_holes = num_holes)
    
    cat("Confirmed unique:", has_unique_solution(result$puzzle), "\n\n")
    
    cat("PUZZLE (0 = blank):\n")
    print(result$puzzle)
    
    if (result$num_holes < num_holes) {
      cat("Note: could only remove", result$num_holes, "holes (target was", num_holes, ") while keeping a unique solution.\n")
    }
    
    cat("\nSolving it back with solve_sudoku()...\n")
    
    start_time <- Sys.time()
    re_solved <- solve_sudoku(result$puzzle)
    end_time <- Sys.time()
    solve_time <- as.numeric(end_time - start_time, units = "secs")
    
    print(re_solved)
    cat("\nSolve time:", solve_time, "seconds\n")
    cat("\nMatches the original solution?", all(re_solved == result$solution), "\n")
    
    invisible(result)
  }  
  
  result <- generate_puzzle("easy")