library(tidyverse)

# all g1k
ggplot(plot,aes(x=X1,y=X2,colour=Super.Population,shape=Population)) + geom_point(size=3, alpha=0.4) + geom_point(data=subset(plot,ID=='1501'), aes(x=X1, y=X2), size=3) + scale_fill_viridis() + theme_bw() + scale_shape_manual(values=c(19,1:15,17,18,21:24,40:45)) + scale_alpha(range = c(0.1, 1)) +xlab('t-SNE 1') + ylab('t-SNE 2')

# all g1k, zoom into EAS
ggplot(plot,aes(x=X1,y=X2,colour=Super.Population,shape=Population)) + geom_point(size=3, alpha=1) + geom_point(data=subset(plot,ID=='1501'), aes(x=X1, y=X2), size=3) + scale_fill_viridis() + theme_bw() + scale_shape_manual(values=c(19,1:15,17,18,21:24,40:45)) + scale_alpha(range = c(0.1, 1)) + coord_cartesian(xlim=c(-23,-48),ylim=c(5,35)) + xlab('t-SNE 1') + ylab('t-SNE 2')

# EAS only
ggplot(subset(plot, Super.Population %in% c('EAS','1501')),aes(x=X1,y=X2,colour=Population,shape=Population)) + geom_point(size=3, alpha=1) + geom_point(data=subset(plot,ID=='1501'), aes(x=X1, y=X2), size=3) + scale_fill_viridis() + theme_bw() + scale_shape_manual(values=c(19,1:15,17,18,21:24,40:45)) + scale_alpha(range = c(0.1, 1)) + coord_cartesian(xlim=c(-23,-48),ylim=c(5,35)) + xlab('t-SNE 1') + ylab('t-SNE 2')

