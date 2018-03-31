
#' Function to get the file for a basis_name, year and month.
#'
#' @param basis_name
#' @param year
#' @param month
#'
#' @export
#'
entsoe_get_file <- function(basis_name, year = lubridate::year(Sys.Date()), month = lubridate::month(Sys.Date())){

  req <- httr::GET(url = paste0("ftp://62.209.222.9/export/export/", basis_name, "/", year, "_", month, "_", basis_name, ".csv"),
                   httr::authenticate(user = "TP_export", password = "eG75pLwgyfyQLzjJ"))

  con <- httr::content(req, as = "raw")

  read.delim(con, skipNul = TRUE, stringsAsFactors = FALSE)
}
