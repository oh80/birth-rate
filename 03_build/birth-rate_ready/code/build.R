library(magrittr)

main <- function(){
  my_folder <- "birth-rate"
  
  birth_rate_data <- read_data(my_folder,
                               fime_name <- "birth-rate.csv")

  
  basics$save_interim(birth_rate_data, my_folder, extension = "ready")
}

read_data <- function(folder_name,file_name){
  file_path <- here::here("02_raw",folder_name,"data",file_name)
  data <- read.csv(file = file_path,header = F) %>% 
    dplyr::as_tibble() %>% dplyr::rename("prefecture"="V1","birth_rate"="V2")
  return(data)
}

box::use(`functions`/basics)
data <- main()
