choco = flavors_of_cacao

choco@Cocoa.Percent = as.numeric(gsub('%',"choco@Cocoa.Percent"))
choco$`Review
Date` = as.character(choco$`Review
Date`)

str(choco)
View(choco)
plot_str(choco)
plot_missing(choco)

plot_histogram(choco)
plot_density(choco)
plot_correlation(choco,type = 'continuous','Review Date')
plot_bar(choco)