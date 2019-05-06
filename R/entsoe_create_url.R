

entsoe_create_url_folders <- function(){

  # req <- suppressWarnings(httr::GET(url = "sftp://sftp-transparency.entsoe.eu/TP_export/",
  #                                   httr::authenticate(user = Sys.getenv("ENTSOE_USER"), password = Sys.getenv("ENTSOE_PASSWORD"))))
  h <- curl::new_handle()
  curl::handle_setopt(h, .list = list(httpauth = 1, userpwd = paste0(Sys.getenv("ENTSOE_USER"), ":", Sys.getenv("ENTSOE_PASSWORD")), httpget = TRUE))
  req <- curl::curl_fetch_memory(url = "sftp://sftp-transparency.entsoe.eu/TP_export/", h)

  req
}

entsoe_create_url_files <- function(basis_name){

  # req <- suppressWarnings(httr::GET(url = paste0("sftp://sftp-transparency.entsoe.eu/TP_export/", basis_name, "/"),
  #                                   httr::authenticate(user = Sys.getenv("ENTSOE_USER"), password = Sys.getenv("ENTSOE_PASSWORD"))))
  h <- curl::new_handle()
  curl::handle_setopt(h, .list = list(httpauth = 1, userpwd = paste0(Sys.getenv("ENTSOE_USER"), ":", Sys.getenv("ENTSOE_PASSWORD")), httpget = TRUE))
  req <- curl::curl_fetch_memory(url = paste0("sftp://sftp-transparency.entsoe.eu/TP_export/", basis_name, "/"), h)

  req
}

entsoe_create_url_file <- function(basis_name, year, month){

  # req <- suppressWarnings(httr::GET(url = paste0("sftp://sftp-transparency.entsoe.eu/TP_export/", basis_name, "/", year, "_", month, "_", basis_name, ".csv"),
  #                                   httr::authenticate(user = Sys.getenv("ENTSOE_USER"), password = Sys.getenv("ENTSOE_PASSWORD"))))
  h <- curl::new_handle()
  curl::handle_setopt(h, .list = list(httpauth = 1, userpwd = paste0(Sys.getenv("ENTSOE_USER"), ":", Sys.getenv("ENTSOE_PASSWORD")), httpget = TRUE))
  req <- curl::curl_fetch_memory(url = paste0("sftp://sftp-transparency.entsoe.eu/TP_export/", basis_name, "/", year, "_", month, "_", basis_name, ".csv"), h)

  req
}


entsoe_create_url_log <- function(){

  # req <- suppressWarnings(httr::GET(url = paste0("sftp://sftp-transparency.entsoe.eu/TP_export/Export_log.CSV"),
  #                                   httr::authenticate(user = Sys.getenv("ENTSOE_USER"), password = Sys.getenv("ENTSOE_PASSWORD"))))
  h <- curl::new_handle()
  curl::handle_setopt(h, .list = list(httpauth = 1, userpwd = paste0(Sys.getenv("ENTSOE_USER"), ":", Sys.getenv("ENTSOE_PASSWORD")), httpget = TRUE))
  req <- curl::curl_fetch_memory(url = paste0("sftp://sftp-transparency.entsoe.eu/TP_export/Export_log.CSV"), h)

  req
}
