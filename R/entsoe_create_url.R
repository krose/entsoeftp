

entsoe_create_url_folders <- function(){

  req <- suppressWarnings(httr::GET(url = "ftp://62.209.222.9/export/export/",
                                    httr::authenticate(user = "TP_export", password = "eG75pLwgyfyQLzjJ")))

  req
}

entsoe_create_url_files <- function(basis_name){

  req <- suppressWarnings(httr::GET(url = paste0("ftp://62.209.222.9/export/export/", basis_name, "/"),
                                    httr::authenticate(user = "TP_export", password = "eG75pLwgyfyQLzjJ")))

  req
}

entsoe_create_url_file <- function(basis_name, year, month){

  req <- suppressWarnings(httr::GET(url = paste0("ftp://62.209.222.9/export/export/", basis_name, "/", year, "_", month, "_", basis_name, ".csv"),
                                    httr::authenticate(user = "TP_export", password = "eG75pLwgyfyQLzjJ")))

  req
}

