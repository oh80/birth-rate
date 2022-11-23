library(magrittr)

main <- function(){
  file_name = "04_analize/analize/output/result.obj"
  mcmc_sample <- readRDS(file_name) 
  
  summary_table_code <- mcmc_sample %>% 
    to_df() %>% 
    summraize_data() %>% 
    to_table_code() 

  saveRDS(summary_table_code,
          file = "05_report/visualize/output/table_code.obj")
}

to_df <- function(input_data){
  output_data <- input_data %>% 
    as.data.frame() %>% 
    dplyr::as.tbl() %>% 
    dplyr::select(b1,b2) %>% 
    tidyr::pivot_longer(cols = c("b1","b2"),
                        names_to = "variable",
                        values_to = "sample")
  return(output_data)
}

summraize_data <-function(input_data){
  output_data <- input_data %>% 
    dplyr::group_by(variable) %>% 
    dplyr::summarise(mean=mean(sample),
                     sd=sd(sample),
                     quantile_0.025=quantile(sample,0.025),
                     quantile_0.977=quantile(sample,0.975))
  return(output_data)
}

to_table_code <- function(input_data){
  output <- xtable::xtable(input_data)
  return(output)
}

main()
