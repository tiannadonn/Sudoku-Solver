  generate_puzzle <- function(difficulty = "medium") {
    num_holes <- get_difficulty_holes(difficulty)
  
    cat("Generating a puzzle with a guaranteed unique solution and", 81-num_holes, "hints...\n\n")
  
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

  result <- generate_puzzle("hard")