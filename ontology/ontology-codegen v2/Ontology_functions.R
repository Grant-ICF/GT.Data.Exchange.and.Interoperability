library(dplyr)
library(readxl)


# Functions to clean up text
nb2sp <- function(x) gsub("\u00A0", " ", x, fixed = TRUE) #non-breaking to space

ttl_local <- function(x) {
  x <- nb2sp(trimws(as.character(x)))
  x <- gsub("[^A-Za-z0-9_]", "_", x)     # replace illegal chars ([], space, -, etc.)
  x <- gsub("_+", "_", x)               # collapse repeats
  x <- gsub("^_|_$", "", x)             # trim underscores
  if (grepl("^[0-9]", x)) x <- paste0("_", x)  #Set it so that the string doesn't start with a number
  x
}

ttl_lit <- function(x) {
  x <- nb2sp(as.character(x))
  x[is.na(x)] <- ""
  x <- trimws(x)
  x <- gsub("\\\\", "\\\\\\\\", x)      # escape backslash
  x <- gsub("\"", "\\\\\"", x)          # escape quotes
  paste0("\"", x, "\"")
}

is_blank <- function(x) {
  x <- nb2sp(as.character(x))
  is.na(x) | trimws(x) == ""
}

clean_iri <- function(x) {
  x <- nb2sp(as.character(x))
  x <- trimws(x)
  x <- gsub("\\s+", "", x)              # remove any remaining whitespace
  x
}