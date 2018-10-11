

entsoe_create_url_folders <- function(){

  req <- suppressWarnings(httr::GET(url = "sftp://sftp-transparency.entsoe.eu/TP_export/",
                                    httr::authenticate(user = Sys.getenv("ENTSOE_USER"), password = Sys.getenv("ENTSOE_PASSWORD"))))

  req
}

entsoe_create_url_files <- function(basis_name){

  req <- suppressWarnings(httr::GET(url = paste0("sftp://sftp-transparency.entsoe.eu/TP_export/", basis_name, "/"),
                                    httr::authenticate(user = Sys.getenv("ENTSOE_USER"), password = Sys.getenv("ENTSOE_PASSWORD"))))

  req
}

entsoe_create_url_file <- function(basis_name, year, month){

  req <- suppressWarnings(httr::GET(url = paste0("sftp://sftp-transparency.entsoe.eu/TP_export/", basis_name, "/", year, "_", month, "_", basis_name, ".csv"),
                                    httr::authenticate(user = Sys.getenv("ENTSOE_USER"), password = Sys.getenv("ENTSOE_PASSWORD"))))

  req
}

