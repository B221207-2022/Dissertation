#code based on https://gettinggeneticsdone.blogspot.com/2011/03/forest-plots-using-rstats-and-ggplot2.html
library(ggplot2)

forestplot <- function(d, xlab="Heritability", ylab=""){
  require(ggplot2)
  p <- ggplot(d, aes(x=Trait, y=Herit, ymin=X95_low, ymax=X95_high)) + 
    geom_pointrange(aes(color=Sex)) + 
    scale_color_manual(values= c("Female" = "#cc0066", "Male" = "#0066cc" )) +
    coord_flip() +
    geom_hline(aes(yintercept=0), lty=2) +
    ylab(xlab) +
    xlab(ylab) + #switch because of the coord_flip() above
    theme_bw() +
    theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
  ggsave("forestplot_heritibaility.png",plot=p)
  return(p)
}

data <- read.table("Heritability.txt", sep="\t", header=T)
data$Trait <- as.factor(data$Trait)
str(data)

data

forestplot(data)




