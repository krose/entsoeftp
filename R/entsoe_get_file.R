
#' Function to get the file for a basis_name, year and month.
#'
#' @param basis_name High level folder name of the file.
#' @param year Year.
#' @param month Month (example: 1 or 11).
#'
#' @export
#'
entsoe_get_file <- function(basis_name, year = lubridate::year(Sys.Date()), month = lubridate::month(Sys.Date())){

  req <- suppressWarnings(httr::GET(url = paste0("ftp://62.209.222.9/export/export/", basis_name, "/", year, "_", month, "_", basis_name, ".csv"),
                   httr::authenticate(user = "TP_export", password = "eG75pLwgyfyQLzjJ")))

  con <- httr::content(req, as = "raw")

  # fix BOM and embeeded NULL
  con <- con[!con %in% charToRaw("ÿþ")]
  con <- con[!con %in% as.raw(0)]

  con_df <- suppressMessages(readr::read_tsv(con, na = "N/A"))

  con_df
}
