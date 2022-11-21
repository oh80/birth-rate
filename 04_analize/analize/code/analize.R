library(magrittr)

main <- function(){
  #prepare_stan()
  data <- basics$read_interim("master")
  
  data_list <- prepare_run_model(data) 
  fit <- run_model(data_list)
  
  ms <- rstan::extract(fit)
  saveRDS(ms,file = "04_analize/analize/output/result.obj")
}


prepare_stan <- function(){
  install.packages("rstan")
  library(rstan)
}

prepare_run_model <- function(input_data){
  input_data <- input_data %>% 
    dplyr::mutate(birth_rate=birth_rate*100)
  output <- list(N=nrow(input_data),
                 X=input_data$regular_employment_rate,
                 Y=input_data$birth_rate)
  return(output)
}

run_model <- function(input_data){
  model_path <- "04_analize/analize/code/model.stan"
  fit <- rstan::stan(file=model_path,data=input_data,seed=123)
  return(fit)
}

options(box.path = here::here("01_admin"))
box::use(`functions`/basics)
main()

