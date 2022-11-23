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
  
  sample_hist <- mcmc_sample %>%
    plot_hist()
  
  ggplot2::ggsave(plot = sample_hist,
                  filename = "sample_hist.pdf",
                  device="pdf",
                  family = "Japan1",
                  path = "05_report/visualize/output")
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

plot_hist <- function(input_data){
  output <- input_data %>% 
    as.data.frame() %>% 
    dplyr::as.tbl() %>% 
    dplyr::select(b1,b2) %>% 
    ggplot2::ggplot(mapping = ggplot2::aes(x=input_data$b2))+
    ggplot2::geom_histogram()+
    ggplot2::labs(title = "パラメータb2のMCMCサンプルの分布",
                  x="b2")
  return(output)
}

main()
