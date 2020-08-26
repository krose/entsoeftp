
#' List top level names of links to the low level folders.
#'
#' @export
#'
entsoe_list_folders <- function(){

  req <- entsoe_create_url_folders()

  # con <- httr::content(x = req, as = "text", encoding = "UTF-8")
  con <- rawToChar(req$content)

  con_df <- parse_ftp_links(con)
  # con_df <- lapply(con_df, as.data.frame, stringsAsFactors = FALSE)
  # con_df <- do.call(rbind, con_df)
  # # con_df$date <- strptime(con_df$date, format = "%b %d %H:%M", tz = "UTC")
  # con_df <- dplyr::arrange(.data = con_df, links)

  con_df
}


parse_ftp_links <- function(x){
  df_links <- as.data.frame(readr::read_fwf(file = x, readr::fwf_widths(widths = c(10, 5, 4, 10, 14, 13, 60))))

  names(df_links) <- c("perm", "unknown1", "unknown2", "unknown3", "size", "date", "link")
  time_or_year <- stringr::str_sub(df_links$date, start = -5)
  time_and_year <- dplyr::if_else(!stringr::str_detect(time_or_year, " [0-9]{4}"), paste0(lubridate::year(Sys.Date()), " ", time_or_year), paste0(time_or_year, " 00:00"))
  df_links$date <- stringr::str_replace(df_links$date, time_or_year, "")
  df_links$date <- paste0(df_links$date, time_and_year)
  df_links$date <- stringr::str_replace(df_links$date, "  ", " ")
  df_links$date <- lubridate::mdy_hm(df_links$date, tz = "UTC")

  df_links <- df_links[df_links$unknown1 == 2, ]

  df_links
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

