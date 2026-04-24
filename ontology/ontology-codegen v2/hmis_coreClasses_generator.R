# Transform data into the format needed to generate the classes ttl file
core_classes2 <- data.frame(allClass = unique(c(core_classes$Class, core_classes$SubClass))) %>%
  filter(!is.na(allClass)) %>%
  left_join(core_classes %>% filter(!is.na(SubClass)),
            by = c("allClass" = "SubClass")) %>% 
  mutate(across(everything(), ~ nb2sp(as.character(.x))))


classes <- core_classes2 %>%
  rowwise() %>%
  mutate(block = {
    
    # Subject = the class being declared
    subj <- paste0("hmis:", ttl_local(allClass))
    
    lines <- c(
      paste0(subj, " a owl:Class ;"),
      paste0("  rdfs:label ", ttl_lit(allClass), " ;")
    )
    
    # Optional subclass
    if (!is_blank(Class)) {
      lines <- c(
        lines,
        paste0("  rdfs:subClassOf hmis:", ttl_local(Class), " ;")
      )
    }
    
    # Force final predicate to end with "."
    last <- sub(";\\s*$", ".", trimws(lines[length(lines)]))
    body <- c(lines[-length(lines)], last)
    
    paste0(paste(body, collapse = "\n"), "\n\n")
  }) %>%
  ungroup() %>%
  pull(block)


