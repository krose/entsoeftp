
#' Function to get the file for a basis_name, year and month.
#'
#' @export
#'
entsoe_get_log <- function(){

  req <- entsoe_create_url_log()

  con <- req$content

  # fix BOM and embeeded NULL
  con <- con[!con %in% charToRaw("ÿþ")]
  con <- con[!con %in% as.raw(0)]

  con_df <- suppressWarnings(suppressMessages(readr::read_tsv(con, na = "N/A")))

  # remove first line of with -------
  con_df <- con_df[-1, ]

  con_df <- suppressMessages(readr::type_convert(con_df))

  con_df
}
