
#' List top level names of links to the low level folders.
#'
#' @export
#'
entsoe_list_folders <- function(){

  req <- entsoe_create_url_folders()

  con <- httr::content(x = req, as = "text", encoding = "UTF-8")

  con_df <- parse_links(con)
  con_df <- lapply(con_df, as.data.frame, stringsAsFactors = FALSE)
  con_df <- do.call(rbind, con_df)
  # con_df$date <- strptime(con_df$date, format = "%b %d %H:%M", tz = "UTC")
  con_df <- dplyr::arrange(.data = con_df, links)

  con_df
}


#' Thanks to Scott Chamberlain (from the ropensci/ftp package).
parse_links <- function(x) {

  x <- strsplit(x, "\n")[[1]]

  x <-
    lapply(x, function(z) {
      perm <- strex(z, "^[a-z-]+")
      dir <- strex(z, "[0-9]\\s[a-z]+")
      group <- strex(z, "csdb-ops|1005")
      size <- strexg(z, "[0-9]{2,}")[[1]][2]
      date <- strex(z, "[A-Za-z]{3}\\s+[0-9]{1,2}\\s+[0-9]{2}:[0-9]{2}|[A-Za-z]{3}\\s+[0-9]{1,2}\\s+[0-9]{4}")
      links <- strex(z, "[A-Za-z0-9_-]+$")
      tmp <- list(perm = perm, dir = dir, group = group, size = size,
                  date = date, links = links)
      tmp[vapply(tmp, length, 1) == 0] <- ""
      tmp
    })

  x
}

