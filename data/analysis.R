setwd("C:/Users/Richard/GIT/UserModels/data")
# setwd("C:/Users/Cor Steging/Documents/UserModels/data")
# load data
results <- read.csv("all_results_experiment.csv", header=TRUE)

# leave out subject 1 (since he did not yet do derivative trials)
results <- results[!(results$subject==1), ]

# divide results into two groups for the two systems
deriv_results <- results[results$program==2, ]
std_results <- results[results$program==1, ]

# select only the correct selections
deriv_cor <- deriv_results[deriv_results$correct==1, ]
std_cor <- std_results[std_results$correct==1, ]

nrow(deriv_cor) 		# 8
nrow(deriv_results)	# 40
nrow(std_cor)		# 24
nrow(std_results)		# 40

mean(std_cor$response_time)		# 34.98883
mean(deriv_cor$response_time)		# 14.90428

# Plot of accuracy per system, for each participant
accs <- rbind(c(2,8,2),c(3,4,3),c(4,2,1),c(5,5,1),c(6,5,1))
accs <- as.data.frame(accs)
names(accs) <- c("subject", "Std", "Deriv")
accs

#boxplot per program, for time of correct trials
d0 <- std_cor$response_time
d1 <- deriv_cor$response_time
lmts <- range(d0,d1)

boxplot(d0, d1, main="Response times of correct trials for the two systems", ylim=lmts, ylab="Response time (seconds)", names=c("Standard","New"))


#Pirateplot
library("devtools")
library("yarrr")
require("BayesFactor")

pirateplot(formula = results$response_time ~ results$program,
           data = results,
           main = "Response times of correct trials for the two systems", #give it an appropriate name
           theme = 2,
           pal = "southpark", # changing the color pallette, you can find out about other pallettes if you see it in the Help tab on the right
           xlab = "System", #give it an appropriate name
           ylab = "Response time (seconds)",
           point.pch = 16,
           point.o = .1, #opacity of the points
           hdi.o = .0,
           bar.f.o = .5,#opacity of the bars
           avg.line.o = .5,
           inf.method = "se",
           gl.col = gray(.6), # Gridline specifications
           gl.lty = 0,
           gl.lwd = c(.5, 0))


# test if difference in selection time is different
# Both not normal distributed, so ttest cannot be used.
# Instead we use Two-sample Kolmogorov-Smirnov test
wilcox.test(d0, d1, paired=FALSE)

# RESULT:
# Wilcoxon rank sum test
# 
# data:  d0 and d1
# W = 185, p-value = 8.557e-06
# alternative hypothesis: true location shift is not equal to 0

