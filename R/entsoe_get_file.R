
#' Function to get the file for a basis_name, year and month.
#'
#' @param basis_name High level folder name of the file.
#' @param year Year.
#' @param month Month (example: 1 or 11).
#' @param file_name File name of file to download. If this param is used it will overwrite basis_name, year and month.
#'
#' @export
#'
entsoe_get_file <- function(basis_name = NULL, year = lubridate::year(Sys.Date()), month = lubridate::month(Sys.Date()), file_name = NULL){

  if(!is.null(file_name)){
    message(paste("Parsing file_name:", file_name))
    file_decom_df <- entsoe_split_file_name(file_name)
    basis_name <- file_decom_df$basis_name
    year <- file_decom_df$year
    month <- file_decom_df$month
  }

  if(is.null(basis_name)){
    stop("The parameter basis_name, needs a value if a file_name is not supplied.")
  }

  req <- entsoe_create_url_file(basis_name, year, month)

  # con <- httr::content(req, as = "raw")
  con <- req$content

  # fix BOM and embeeded NULL
  con <- con[!con %in% charToRaw("ÿþ")]
  con <- con[!con %in% as.raw(0)]

  con_df <- suppressWarnings(suppressMessages(readr::read_tsv(con, na = "N/A")))

  # remove error lines.
  con_df$Year <- suppressWarnings(as.integer(con_df$Year))
  con_df <- con_df[!is.na(con_df$Year),]

  con_df <- suppressMessages(readr::type_convert(con_df))

  con_df
}

#' Split a filename into it's year, month and basis_name components.
#'
#' @param file_name File name.
#'
#' @export
#'
#'
entsoe_split_file_name <- function(file_name){

  file_decom <- stringr::str_split(string = file_name, pattern = "[_]", n = 3, simplify = TRUE)
  file_decom <- as.data.frame(file_decom)
  names(file_decom) <- c("year", "month", "basis_name")
  file_decom$basis_name <- stringr::str_replace(string = file_decom$basis_name, pattern = ".csv", replacement = "")

  file_decom
}
