#1.使用R中的数据读写，文件路径，for循环语句，读入路径“/assignment_idaccuracy/Aminer”总的所有文件，并将数据合并成为一个data.frame输出。

#设置工作路径
getwd()
mypath = "C:/Users/Lenovo/Dropbox/bigdata_econ_2023/data/assignment_idaccuracy/Aminer"
file.exists(mypath)
setwd(mypath)
#创建一个空的数据框
library(readr)
merged_data <- data.frame()
#读入目录下包括隐藏文件在内的所有目录和文件
file_list <- list.files(mypath, pattern = "\\.csv", full.names = TRUE)
#使用for循环读取并合并数据
for (file in file_list) {
  current_data <- read.csv(file,header = TRUE, stringsAsFactors = FALSE, na.strings = "", fill = TRUE)
  merged_data <- rbind(merged_data, current_data)
}
merged_data <- merged_data[,c("doi","年份","期刊","标题")]
# 打印合并后的数据框
print(merged_data)



#2. 使用apply家族函数替代上述步骤中的for循环

# 获取文件列表
merged_dataframe <- list.files(mypath, full.names = TRUE)
# 使用lapply和do.call合并数据
data <- lapply(merged_dataframe, read.csv)
merged_dataframe <- do.call(rbind,data)
merged_dataframe<- merged_dataframe[,c("doi", "年份", "期刊", "标题")]
# 打印合并后的数据框
print(merged_dataframe)



#3.将2中代码封装成为一个可以在命令行运行的脚本，脚本的唯一一个参数为aminer论文文件所在的路径。

# 获取命令行参数
data_dir <- commandArgs(trailingOnly = TRUE)
# 获取文件列表
merged_dataframe <- list.files(mypath, full.names = TRUE)
# 初始化一个空的 data.frame 用于后续数据合并
combined_data <- data.frame()
extract <- function(merged_dataframe){
  data <- read_csv(merged_dataframe)
  if(all(c("doi", "年份", "期刊", "标题") %in% names(data))) {
    return(data[, c("doi", "年份", "期刊", "标题")])
  }
  return(data.frame())
}
# 使用lapply
combined_data <- do.call(rbind, lapply(merged_dataframe, extract))

print(combined_data)

