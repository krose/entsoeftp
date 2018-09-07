
#' Function to get the file for a basis_name, year and month.
#'
#' @param basis_name High level folder name of the file.
#' @param year Year.
#' @param month Month (example: 1 or 11).
#'
#' @export
#'
entsoe_get_file <- function(basis_name, year = lubridate::year(Sys.Date()), month = lubridate::month(Sys.Date())){

  req <- entsoe_create_url_file(basis_name, year, month)

  con <- httr::content(req, as = "raw")

  # fix BOM and embeeded NULL
  con <- con[!con %in% charToRaw("ÿþ")]
  con <- con[!con %in% as.raw(0)]

  con_df <- suppressWarnings(suppressMessages(readr::read_tsv(con, na = "N/A")))

  # remove error lines.
  con_df <- con_df[!is.na(con_df$month), ]
  con_df$year <- as.integer(con_df$year)

  con_df
}
