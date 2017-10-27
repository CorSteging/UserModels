setwd("C:/Users/Richard/GIT/UserModels/data")
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

boxplot(d0, d1, main="Response times of correct trials for the two systems", ylim=lmts, ylab="Response time (seconds)", names=c("Standard","Derivative"))

# test if difference in selection time is different
# Both not normal distributed, so ttest cannot be used.
# Instead we use Two-sample Kolmogorov-Smirnov test
ks.test(d0, d1)

# RESULT:
# Two-sample Kolmogorov-Smirnov test
#
# data:  d0 and d1
# D = 0.875, p-value = 3.537e-05
# alternative hypothesis: two-sided

