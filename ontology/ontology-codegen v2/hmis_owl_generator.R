library(dplyr)
library(readxl)

HMIS <- "http://www.semanticweb.org/61084/ontologies/2026/2/hmis#"
df <- read_xlsx(file.choose(), sheet = 3)

# --- helpers ---
nb2sp <- function(x) gsub("\u00A0", " ", x, fixed = TRUE) #non-breaking to space

ttl_local <- function(x) {
  x <- nb2sp(trimws(as.character(x)))
  x <- gsub("[^A-Za-z0-9_]", "_", x)     # replace illegal chars ([], space, -, etc.)
  x <- gsub("_+", "_", x)               # collapse repeats
  x <- gsub("^_|_$", "", x)             # trim underscores
  if (grepl("^[0-9]", x)) x <- paste0("_", x)  # local names can't start with digit safely
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

# normalize all cells to character and remove NBSP early
df2 <- df %>%
  mutate(across(everything(), ~ nb2sp(as.character(.x))))

ttl_header <- c(
  paste0("@prefix hmis: <", HMIS, "> ."),
  "@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .",
  "@prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .",
  "@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .",
  "@prefix owl:  <http://www.w3.org/2002/07/owl#> .",
  "@prefix skos: <http://www.w3.org/2004/02/skos/core#> .",
  ""
)

rows <- df2 %>%
  rowwise() %>%
  mutate(block = {
    subj <- paste0("hmis:", ttl_local(Name))
    
    lines <- c(
      paste0(subj, " a owl:DatatypeProperty ;"),
      paste0("  rdfs:domain hmis:", ttl_local(Class), " ;"),
      paste0("  rdfs:range ", trimws(Range), " ;")
    )
    
    # metadata as literals (only include if nonblank)
    if (!is_blank(DataElement))   lines <- c(lines, paste0("  hmis:dataElementNumber ", ttl_lit(DataElement), " ;"))
    if (!is_blank(FieldNumber))   lines <- c(lines, paste0("  hmis:dataElementFieldNumber ", ttl_lit(FieldNumber), " ;"))
    if (!is_blank(Name))          lines <- c(lines, paste0("  hmis:dataDictionaryName ", ttl_lit(Name), " ;"))
    if (!is_blank(CSVTable))      lines <- c(lines, paste0("  hmis:CSVExportTable ", ttl_lit(CSVTable), " ;"))
    
    if (!is_blank(inScheme)) {
      iri <- clean_iri(inScheme)
      lines <- c(lines, paste0("  hmis:linkedVocabulary <", iri, "> ;"))
    }
    
    # force the final line to end with "." no matter what
    last <- sub(";\\s*$", ".", trimws(lines[length(lines)]))
    body <- c(lines[-length(lines)], last)
    
    paste0(paste(body, collapse = "\n"), "\n\n")
  }) %>%
  ungroup() %>%
  pull(block)

writeLines(c(ttl_header, rows), "hmis_project_schema.ttl", useBytes = TRUE)
