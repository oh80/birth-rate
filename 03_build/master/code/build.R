library(magrittr)

main <- function(){
  employment_data <- basics$read_interim("employment", extension = "ready")  %>% print()
  birth_rate_data <- basics$read_interim("birth-rate", extension = "ready") 
  
  maste_data <- master(employment_data,birth_rate_data) 
  
  basics$save_interim(master_data, "master")
}

master <- function(input_data1,input_data2){
  output_data <- input_data1 %>% 
    dplyr::inner_join(input_data2,by="prefecture")
  return(output_data)
}

box::use(`functions`/basics)
main()
