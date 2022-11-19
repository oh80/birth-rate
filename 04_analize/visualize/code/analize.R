library(magrittr)

main <- function(){
  data <- basics$read_interim("master") 
  
  my_plot <- data %>% 
    lay_basic() %>% 
    lay_shape() %>% 
    lay_titles() 
  
  ggplot2::ggsave(plot = my_plot,
                  filename = "scatter_plot.pdf",
                  device="pdf",
                  family = "Japan1",
                  path = "04_analize/visualize/figure")

}

lay_basic <- function(input_data){
  output <- input_data %>% 
    ggplot2::ggplot(mapping = ggplot2::aes(x=regular_employment_rate,
                                  y=birth_rate))
  return(output)
}

lay_shape <- function(input){
  output <- input+
    ggplot2::geom_point()
  return(output)
}

lay_titles <- function(input){
  output <- input+
    ggplot2::labs(title = "女性の正規雇用者の割合と合計特殊出生率の関係",
                  y = "合計特殊出生率",
                  x = "女性の人口に占める正規雇用者数の割合")
  return(output)
}


main()

