clear all
cls
cd "/Users/luoyao/Downloads/Github/Panel/ps5"
log using "ps5.text", replace
bcuse jtrain2
// estimate the propensity score
 probit train lre74 lre75 agesq nodegree married black hisp
 predict ps

// regress y on 1 D p(x)
regress unem78 train ps

// regress y on 1 D p(x) D(p-u)
egen mean_ps = mean(ps)
generate u = ps - mean_ps
generate dp = train*u
regress unem78 train ps dp

// regress y on 1 d x
regress  unem78 train lre74 lre75 agesq nodegree married black hisp

log close
