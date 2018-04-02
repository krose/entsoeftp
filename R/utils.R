

#' Thanks to Scott Chamberlain (from the ropensci/ftp package).
strex <- function(string, pattern) {
  regmatches(string, regexpr(pattern, string))
}

#' Thanks to Scott Chamberlain (from the ropensci/ftp package).
strexg <- function(string, pattern) {
  regmatches(string, gregexpr(pattern, string))
}

