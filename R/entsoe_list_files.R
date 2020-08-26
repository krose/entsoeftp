
#' Function to list files in a directory.
#'
#' @param  basis_name High level folder name of the file.
#'
#' @export
#'
entsoe_list_files <- function(basis_name){

  req <- entsoe_create_url_files(basis_name)

  # con <- httr::content(x = req, as = "text", encoding = "UTF-8")
  con <- rawToChar(req$content)

  con_df <- parse_ftp_files(con)

  # con_df <- parse_files(con)
  # con_df <- lapply(con_df, as.data.frame, stringsAsFactors = FALSE)
  # con_df <- do.call(rbind, con_df)
  # # con_df$date <- strptime(con_df$date, format = "%b %d %H:%M", tz = "UTC")
  # con_df <- dplyr::arrange(.data = con_df, file)
  # con_df <- dplyr::filter(.data = con_df, !stringr::str_detect(perm, "^d"))

  con_df
}

parse_ftp_files <- function(x){
  df_files <- as.data.frame(suppressWarnings(readr::read_fwf(file = x, readr::fwf_widths(widths = c(10, 5, 4, 10, 14, 13, 60)))))

  names(df_files) <- c("perm", "unknown1", "unknown2", "unknown3", "size", "date", "file")
  time_or_year <- stringr::str_sub(df_files$date, start = -5)
  time_and_year <- dplyr::if_else(!stringr::str_detect(time_or_year, " [0-9]{4}"), paste0(lubridate::year(Sys.Date()), " ", time_or_year), paste0(time_or_year, " 00:00"))
  df_files$date <- stringr::str_replace(df_files$date, time_or_year, "")
  df_files$date <- paste0(df_files$date, time_and_year)
  df_files$date <- stringr::str_replace(df_files$date, "  ", " ")
  df_files$date <- lubridate::mdy_hm(df_files$date, tz = "UTC")

  df_files <- df_files[df_files$unknown1 == 1, ]

  df_files
}



#' Thanks to Scott Chamberlain (from the ropensci/ftp package).
parse_files <- function(x) {

  x <- strsplit(x, "\n")[[1]]

  x <-
    lapply(x, function(z) {
      perm <- strex(z, "^[a-z-]+")
      dir <- strex(z, "[0-9][[:space:]][a-z]+")
      #group <- strex(z, "csdb-ops|1005")
      size <- strexg(z, "[0-9]{2,}")[[1]][2]
      date <- strex(z, "[A-Za-z]{3}[[:space:]]+[0-9]{1,2}[[:space:]]+[0-9]{2}:[0-9]{2}|[A-Za-z]{3}[[:space:]]+[0-9]{1,2}[[:space:]]+[0-9]{4}")
      file <- strex(z, "[A-Za-z0-9_.-]+$")
      tmp <- list(perm = perm, dir = dir,
                  #group = group,
                  size = size,
                  date = date, file = file)
      tmp[vapply(tmp, length, 1) == 0] <- ""
      tmp
    })

  x
}

