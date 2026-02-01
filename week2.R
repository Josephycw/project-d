library(sotu)
library(tidyverse)
library(tidytext)

corpus_meta <- sotu_meta
corpus_text <- sotu_text

corpus <-
  corpus_meta %>%
  bind_cols(corpus_text) %>%
  rename("text" = "...7",
          "doc_id" = "X") %>%
  as_tibble() # a data format that can be easily modified

length(unique(corpus$president))

# create a subcorpus that limit to Obama's comments
obama_subcorpus <- corpus %>%
filter(president == "Barack Obama") %>%
unnest_tokens(word, text) # break a phrase into words

# count the total word number
obama_subcorpus_wordcount <- obama_subcorpus %>%
group_by(doc_id) %>%
summarize(word_count = n())
obama_subcorpus_wordcount

# Calculate word count distribution for sub-corpus
summary(obama_subcorpus_wordcount$word_count)
sd(obama_subcorpus_wordcount$word_count)

