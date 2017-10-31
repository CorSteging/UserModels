setwd("C:/Users/Richard/GIT/UserModels/data/data") 
mat1 <- read.csv("standard/subject-1.csv")
mat1[,c("target", "total_correct", "total_response_time")]
times <- mat1[,"total_response_time"]
r_times <- rep(times[1], length(times))
r_times[2] = times[2] - times[1]
r_times[3] = times[3] - times[2]
r_times[4] = times[4] - times[3]
r_times[5] = times[5] - times[4]
r_times[6] = times[6] - times[5]
r_times[7] = times[7] - times[6]
r_times[8] = times[8] - times[7]
r_times
