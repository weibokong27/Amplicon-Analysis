library(vegan)
library(gridExtra)
library(ggplot2)

design <- read.table("design.txt", header=T, row.names= 1, sep="\t")
weighted <- read.table("beta/weighted_unifrac_cave_otu_table_css.txt", sep="\t", header=T, check.names=F)
unweighted <- read.table("beta/unweighted_unifrac_cave_otu_table_css.txt", sep="\t", header=T, check.names=F)
bray <- read.table("beta/bray_curtis_cave_otu_table_css.txt", sep="\t", header=T, check.names=F)

design.in <- read.table("design.in.txt", header=T, row.names= 1, sep="\t")
weighted.in <- read.table("in.beta/weighted_unifrac_cave.in_otu_table_css.txt", sep="\t", header=T, check.names=F)
unweighted.in <- read.table("in.beta/unweighted_unifrac_cave.in_otu_table_css.txt", sep="\t", header=T, check.names=F)
bray.in <- read.table("in.beta/bray_curtis_cave.in_otu_table_css.txt", sep="\t", header=T, check.names=F)

pcoa.aw <- cmdscale(weighted, k=3, eig=T)
points.aw <- as.data.frame(pcoa.aw$points)
colnames(points.aw) <- c("x", "y", "z") 
eig.aw <- pcoa.aw$eig
points.aw <- cbind(points.aw, design[match(rownames(points.aw), rownames(design)), ])
p1 <- ggplot(points.aw,aes(x = x,y = y, color = status, shape = sample_type)) + theme_bw() + geom_point(alpha = 0.8, size = 3) + labs(x=paste("PCoA 1 (", format(100 * eig.aw[1] / sum(eig.aw), digits=4), "%)", sep=""), y=paste("PCoA 2 (", format(100 * eig.aw[2] / sum(eig.aw), digits=4), "%)", sep=""),title = "PCoA plot of weighted unifrac distance") + scale_color_manual(values = c("lightgoldenrod2","orchid"))

pcoa.au <- cmdscale(unweighted, k=3, eig=T)
points.au <- as.data.frame(pcoa.au$points)
colnames(points.au) <- c("x", "y", "z") 
eig.au <- pcoa.au$eig
points.au <- cbind(points.au, design[match(rownames(points.au), rownames(design)), ])
p2 <- ggplot(points.au,aes(x = x,y = y, color = status, shape = sample_type)) + theme_bw() + geom_point(alpha = 0.8, size = 3) + labs(x=paste("PCoA 1 (", format(100 * eig.au[1] / sum(eig.au), digits=4), "%)", sep=""), y=paste("PCoA 2 (", format(100 * eig.au[2] / sum(eig.au), digits=4), "%)", sep=""),title = "PCoA plot of unweighted unifrac distance") + scale_color_manual(values = c("lightgoldenrod2","orchid"))

pcoa.ab <- cmdscale(bray, k=3, eig=T)
points.ab <- as.data.frame(pcoa.ab$points)
colnames(points.ab) <- c("x", "y", "z") 
eig.ab <- pcoa.ab$eig
points.ab <- cbind(points.ab, design[match(rownames(points.ab), rownames(design)), ])
p3 <- ggplot(points.ab,aes(x = x,y = y, color = status, shape = sample_type)) + theme_bw() + geom_point(alpha = 0.8, size = 3) + labs(x=paste("PCoA 1 (", format(100 * eig.ab[1] / sum(eig.ab), digits=4), "%)", sep=""), y=paste("PCoA 2 (", format(100 * eig.ab[2] / sum(eig.ab), digits=4), "%)", sep=""),title = "PCoA plot of bray curtis distance") + scale_color_manual(values = c("lightgoldenrod2","orchid"))

pcoa.w <- cmdscale(weighted.in, k=3, eig=T)
points.w <- as.data.frame(pcoa.w$points)
colnames(points.w) <- c("x", "y", "z") 
eig.w <- pcoa.w$eig
points.w <- cbind(points.w, design.in[match(rownames(points.w), rownames(design.in)), ])
p4 <- ggplot(points.w,aes(x = x,y = y, color = cave, shape = sample_type)) + theme_bw() + geom_point(alpha = 0.8, size = 3) + labs(x=paste("PCoA 1 (", format(100 * eig.w[1] / sum(eig.w), digits=4), "%)", sep=""), y=paste("PCoA 2 (", format(100 * eig.w[2] / sum(eig.w), digits=4), "%)", sep=""),title = "PCoA plot of weighted unifrac distance") + scale_color_brewer(palette = "Paired")

pcoa.u <- cmdscale(unweighted.in, k=3, eig=T)
points.u <- as.data.frame(pcoa.u$points)
colnames(points.u) <- c("x", "y", "z") 
eig.u <- pcoa.u$eig
points.u <- cbind(points.u, design.in[match(rownames(points.u), rownames(design.in)), ])
p5 <- ggplot(points.u,aes(x = x,y = y, color = cave, shape = sample_type)) + theme_bw() + geom_point(alpha = 0.8, size = 3) + labs(x=paste("PCoA 1 (", format(100 * eig.u[1] / sum(eig.u), digits=4), "%)", sep=""), y=paste("PCoA 2 (", format(100 * eig.u[2] / sum(eig.u), digits=4), "%)", sep=""),title = "PCoA plot of unweighted unifrac distance") + scale_color_brewer(palette = "Paired")

pcoa.b <- cmdscale(bray.in, k=3, eig=T)
points.b <- as.data.frame(pcoa.b$points)
colnames(points.b) <- c("x", "y", "z") 
eig.b <- pcoa.b$eig
points.b <- cbind(points.b, design.in[match(rownames(points.b), rownames(design.in)), ])
p6 <- ggplot(points.b,aes(x = x,y = y, color = cave, shape = sample_type)) + theme_bw() + geom_point(alpha = 0.8, size = 3) + labs(x=paste("PCoA 1 (", format(100 * eig.b[1] / sum(eig.b), digits=4), "%)", sep=""), y=paste("PCoA 2 (", format(100 * eig.b[2] / sum(eig.b), digits=4), "%)", sep=""),title = "PCoA plot of bray curtis distance") + scale_color_brewer(palette = "Paired")

variability_table = function(cca){
  chi = c(cca$tot.chi, cca$CCA$tot.chi, cca$CA$tot.chi)
  variability_table = cbind(chi, chi/chi[1])
  colnames(variability_table) = c("inertia", "proportion")
  rownames(variability_table) = c("total", "constrained", "unconstrained")
  return(variability_table)
}

capscale.samp <- capscale(unweighted.in ~ sample_type, data=design.in, add=F, sqrt.dist=F)
perm_anova.samp <- anova.cca(capscale.samp,permutations = how(nperm = 999))
var_tbl.samp <- variability_table(capscale.samp)
eig.samp <- capscale.samp$CCA$eig
variance.samp <- var_tbl.samp["constrained", "proportion"]
p.val.samp <- perm_anova.samp[1, 4]
points.samp <- capscale.samp$CCA$wa[, 1:2]
points.samp <- as.data.frame(points.samp)
colnames(points.samp) = c("x", "y")
points.samp <- cbind(points.samp, design.in[match(rownames(points.samp), rownames(design.in)),])
p7 <- ggplot(points.samp, aes(x=x, y=y, color=cave, shape=sample_type)) + theme_bw() + geom_point(alpha = 0.8,size=3) + labs(x=paste("CPCoA 1 (", format(100 * eig.samp[1] / sum(eig.samp), digits=4), "%)", sep=""),y=paste("CPCoA 2 (", format(100 * eig.samp[2] / sum(eig.samp), digits=4), "%)", sep="")) + ggtitle(paste(format(100 * variance.samp, digits=3), " % of variance; p=",format(p.val.samp, digits=2),sep="")) + scale_color_brewer(palette = "Paired")

capscale.cave <- capscale(unweighted.in ~ cave, data=design.in, add=F, sqrt.dist=F)
perm_anova.cave <- anova.cca(capscale.cave,permutations = how(nperm = 999))
var_tbl.cave <- variability_table(capscale.cave)
eig.cave <- capscale.cave$CCA$eig
variance.cave <- var_tbl.cave["constrained", "proportion"]
p.val.cave <- perm_anova.cave[1, 4]
points.cave <- capscale.cave$CCA$wa[, 1:2]
points.cave <- as.data.frame(points.cave)
colnames(points.cave) <- c("x", "y")
points.cave <- cbind(points.cave, design.in[match(rownames(points.cave), rownames(design.in)),])
p8 <- ggplot(points.cave, aes(x=x, y=y, color=cave, shape=sample_type)) + theme_bw() + geom_point(alpha = 0.8,size = 3) + labs(x=paste("CPCoA 1 (", format(100 * eig.cave[1] / sum(eig.cave), digits=4), "%)", sep=""),y=paste("CPCoA 2 (", format(100 * eig.cave[2] / sum(eig.cave), digits=4), "%)", sep="")) + ggtitle(paste(format(100 * variance.cave, digits=3), " % of variance; p=",format(p.val.cave, digits=2),sep="")) + scale_color_brewer(palette = "Paired")

p <- grid.arrange(p5,p8,nrow=1)
pp <- grid.arrange(p4,p6,p2,p7,nrow=2)
ggsave(p,filename = "beta.pdf",width = 10,height = 4)
ggsave(pp,filename = "beta_other.pdf",width = 10,height = 8)