library(maftools)

args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0) {
  stop("At least one argument must be supplied (e.g., input file path).", call. = FALSE)
} else {
  # Arguments are stored in the 'args' character vector
  snv_dir <- args[1]
  output_dest <- args[2]

  # If an argument is meant to be numeric, you must convert it
  numeric_value <- as.numeric(args[1])
}

input_mafs <- sprintf("%s/*/quartet/*.quartet.maf", snv_dir)

total_maf <- merge_mafs(Sys.glob(input_mafs))
write.table(total_maf@data, file = output_dest, sep = "\t", quote = FALSE, row.names = FALSE)
