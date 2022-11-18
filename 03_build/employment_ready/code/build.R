library(magrittr)

main <- function(){
  employment_data <- read_employment(folder_name <-   "employment",
                                    fime_name <- "employment.csv")
  female_pop_data <- read_pop(folder_name  <- "female-pop",
                              fime_name <- "female-pop.csv") 
  
  employment_ready <- master_data(employment_data,female_pop_data) %>% 
    fill_na() %>% 
    add_col() %>% 
    select_col() %>% return()
  
  basics$save_interim(employment_ready,"employment", extension = "ready")
}

read_employment <- function(folder_name,file_name){
  file_path <- here::here("02_raw",folder_name,"data",file_name)
  data <- read.csv(file = file_path,header = F) %>% 
    dplyr::as_tibble() %>% dplyr::rename("prefecture"="V1",
                                         "regular_employment"="V2") 
  data$regular_employment <- sub(",","",data$regular_employment) 
  data$regular_employment <- sub(",","",data$regular_employment)
  data <- data %>% dplyr::mutate(regular_employment=as.numeric(regular_employment))
  
  data$prefecture <- sub(" ","",data$prefecture)
  data$prefecture <- sub(" ","",data$prefecture)
  data$prefecture <- sub(" ","",data$prefecture)
  
  return(data)
}

read_pop <- function(folder_name,file_name){
  file_path <- here::here("02_raw",folder_name,"data",file_name)
  data <- read.csv(file = file_path,header = F) %>% 
    dplyr::as_tibble() %>% dplyr::rename("prefecture"="V1",
                                         "female_pop"="V2")%>% 
    dplyr::mutate(female_pop=as.numeric(female_pop)*1000)

  return(data)
}

master_data <- function(input_data1,input_data2){
  output_data <- input_data2 %>% 
    dplyr::left_join(input_data1,by="prefecture") %>% 
  return(output_data)
}

fill_na <- function(input_data){
  input_data$regular_employment[33]=c(179600)
  input_data$regular_employment[47]=c(114600)
  output_data <- input_data
  return(output_data)
}

add_col <- function(input_data){
  output_data <- input_data %>% 
    dplyr::mutate(regular_employment_rate =regular_employment/female_pop)
  return(output_data)
}

select_col <- function(input_data){
  output_data <- input_data %>% 
    dplyr::select("prefecture","regular_employment_rate")
  return(output_data)
}

box::use(`functions`/basics)
data <-main()
