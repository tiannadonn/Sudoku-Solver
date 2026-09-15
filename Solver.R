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
