# normalize all cells to character and remove NBSP
skos_vocabularies2 <- skos_vocabularies %>% 
  mutate(across(everything(), ~ nb2sp(as.character(.x))))


skosClasses <- skos_vocabularies2 %>%
  select(Class) %>% 
  filter(!is.na(Class)) %>% 
    rowwise() %>%
    mutate(block = {
      subj <- paste0(Class)
      
      lines <- c(
        paste0(subj, " a owl:Class ;"),
        paste0("  rdfs:label ", ttl_lit(Class), " ;")
      )
  
      # Force final predicate to end with "."
      last <- sub(";\\s*$", ".", trimws(lines[length(lines)]))
      body <- c(lines[-length(lines)], last)
      
      paste0(paste(body, collapse = "\n"), "\n\n")
    }) %>%
    ungroup() %>%
    pull(block)
  
  
skosConcept <- skos_vocabularies2 %>%
  rowwise() %>%
  mutate(block = {
    
    # Subject = the class being declared
    subj <- paste0("hmis:",ttl_local(Text))
    
    lines <- c(
      paste0(subj," rdfs:type ","skos:Concept", " ;"),
      paste0("  skos:prefLabel ",Text,"@en ;"),
      paste0("  skos:notation ",Value," ;"),
      paste0("  skos:notation ",Value," ;")#,
      #paste0("  skos:inScheme",`skos:inScheme`," ;") #This needs to work
    )
    
    # Force final predicate to end with "."
    last <- sub(";\\s*$", ".", trimws(lines[length(lines)]))
    body <- c(lines[-length(lines)], last)
    
    paste0(paste(body, collapse = "\n"), "\n\n")
  }) %>%
  ungroup() %>%
  pull(block)

skosConceptScheme <- skos_vocabularies2 %>%
  rowwise() %>%
  mutate(block = {
    
    # Subject = the class being declared
    subj <- paste0("hmis:",ttl_local(List))
    
    lines <- c(
      paste0(subj," rdfs:type ","skos:ConceptScheme", " ;"),
      paste0("  skos:prefLabel ",Text,"@en ;"),
      paste0("  skos:notation ",Value," ;"),
      paste0("  skos:notation ",Value," ;")
    )
    
    # Force final predicate to end with "."
    last <- sub(";\\s*$", ".", trimws(lines[length(lines)]))
    body <- c(lines[-length(lines)], last)
    
    paste0(paste(body, collapse = "\n"), "\n\n")
  }) %>%
  ungroup() %>%
  pull(block)

