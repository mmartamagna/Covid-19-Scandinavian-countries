#COVID-19 IN SCANDINAVINA COUNTRIES
### DID APPROACH
### 
# Institutional background

```{=latex}
\setlength{\arrayrulewidth}{1.2pt}
\begin{center}
\begin{table}[h!]
\begin{tabular}{ p{8cm} >{\centering}m{3.6cm} >{\centering\arraybackslash}m{3.6cm} } 
\hline \\
\textbf{Country characteristic} & \textbf{Sweden} & \textbf{Denmark} \\[8pt]
\hline \\[3pt]
Population (2019) & 10,230,185 & 5,806,081 \\[5pt]
Population density per $km^2$ (2020) & 25.419 & 145.785 \\[5pt]  
GDP per capita PPP, current international \$ (2020) & \$ 54,929.527 & \$ 60,551.567 \\[5pt] 
Life expectancy at birth, years (2020) & 80.7 & 79.6 \\[5pt] 
Healthcare spending, \% GDP (2020) & 11.4 & 10.6 \\[5pt] 
Hospital beds, per 1000 inhabitants (2019) & 2.1 & 2.6 \\[5pt]
ICU beds, per 1000 inhabitants (2020) & 1.9 & 2.5 \\[5pt]
Gen. medical practitioners, per 1000 inhab. (2018) & 4.3 & 4.2 \\[5pt]
Nursing professionals, per 1000 inhabitants (2018) & 10.8 & 10.1 \\[5pt]
Share of aged 65+ (2020) & 20.1\% & 20\% \\[5pt]
Date first 100 cases & March 6, 2020 & March 9, 2020 \\[5pt]
Cumulative COVID deaths per mln ppl. on June 3 & 447.04 & 99.77 \\[5pt]
Cumulative COVID cases per mln ppl. on June 3 & 4,060.57 & 2,024.84 \\[8pt]
\hline
\end{tabular}
\caption{Main key characteristics of Sweden and Denmark. The information inside comes from different European and international online data sources (OECD, World Bank, Our World in Data).}
\label{table:1}
\vspace{-10mm}
\end{table}
\end{center}
```

## Policy response to Covid-19

```{=latex}
\setlength{\arrayrulewidth}{1.2pt}
\begin{center}
\begin{table}[h!]
\begin{tabular}{ p{8cm} >{\centering}m{3.6cm} >{\centering\arraybackslash}m{3.6cm} } 
\hline \\
\textbf{Measure} & \textbf{Sweden} & \textbf{Denmark} \\[8pt]
\hline \\[3pt]
School closing (some levels) & March 17 - & March 13 - \\[5pt]
School closing (all levels) & - & March 13 - April 14 \\[5pt]  
Workplace closing (only at some levels) & - & March 18 - \\[5pt] 
Restriction on gatherings & March 12 - & March 13 - \\[5pt] 
Restrictions on gatherings up to 10 ppl. & - & March 18 - \\[5pt] 
Close public transport & - & - \\[5pt]
Stay at home requirements & - & - \\[5pt]
Restrictions on internal movement & - & - \\[5pt]
International travel bans (for high-risk regions) & March 19 - & March 11 - \\[5pt]
International travel bans (total border closure) & - & March 14 - May 24 \\[5pt]
Stringency Index March 18 (0-100) & 41.67 & 72.22 \\[5pt]
Stringency Index April 1 (0-100) & 64.81 & 72.22 \\[5pt]
Stringency Index June 3 (0-100) & 64.81 & 60.19 \\[8pt]
\hline
\end{tabular}
\caption{Nationwide restrictions for the time period February 26 - June 3, 2020. An open-end means that the measure was in place at least until June 3, 2020. Source: Oxford COVID-19 Government Response Tracker.}
\label{table:2}
\vspace{-10mm}
\end{table}
\end{center}
```


```{r, fig.height=4, fig.width=10}
tour <- data.frame(Country = c('Denmark', 'Sweden'), 
                   January = c(2, -1), 
                   February = c(7, -5), 
                   March = c(-66, -64), 
                   April = c(-97, -91), 
                   May = c(-96, -88), 
                   June = c(-87, -88)) %>%
  gather("Month", "Change", 2:7)
tour$Month <- factor(tour$Month, levels=c('January', 'February', 'March',
                                          'April', 'May', 'June'))

ggplot(data=tour, aes(x=Month, y=Change, fill=Country)) +
  geom_bar(stat="identity", position=position_dodge(), width=0.7, alpha=0.9) + theme_bw() +
  labs(y = '% Change') + theme(plot.caption = element_text(hjust=0.5))
```

```{r, echo=FALSE, include=FALSE}
#Data import
Sys.setlocale(category = "LC_ALL", locale = "english")
dta <- read.csv("DiD_data.csv") %>%
  arrange(Time, Country)
#Factorize countries and make dates
dta$Time <- as.Date(dta$Time)
dta$Country <- factor(dta$Country)

#Plot
ggplot(dta, aes(x=Time, y=stringency_index, color=Country)) +
  geom_point(alpha=0.9, shape=23, size=0.8) + geom_line(alpha=0.9) + theme_bw() +
  labs(y='Stringency Index') + theme(plot.caption = element_text(hjust=0.5))
```

# Data

```{r, fig.height=4, fig.width=12 }
ggplot(dta, aes(x=Time,y=new_cases,color=Country)) +
  geom_point(alpha=0.35) + geom_line(alpha=0.35) + theme_bw()+
  labs(y='New cases per million') +
  geom_vline(xintercept = as.Date("2020-03-18"), linetype='dashed', color='blue', size=0.7) +
  geom_vline(xintercept = as.Date("2020-04-01"), linetype='dashed', color='red', size=0.7) +
  geom_vline(xintercept = as.Date("2020-04-08"), linetype='dashed', color='black', size=0.7) +
  scale_x_continuous(breaks=as.Date(c('2020-03-01', '2020-03-18', '2020-04-01', 
                                      '2020-04-08', '2020-05-01', '2020-06-01')), 
                     labels=c('Mar', 'Mar18', 'Apr1', 'Apr8', 'May', 'Jun')) +
  geom_line(aes(y=new_cases_per_million_smoothed, color=Country), size=1)
```

```{r, fig.height=4, fig.width=12}
ggplot(dta, aes(x=Time,y=new_deaths,color=Country)) +
  geom_point(alpha=0.35) + geom_line(alpha=0.35) + theme_bw()+
  labs(y='New deaths per million') +
  geom_vline(xintercept = as.Date("2020-03-18"), linetype='dashed', color='blue', size=0.7) +
  geom_vline(xintercept = as.Date("2020-04-01"), linetype='dashed', color='red', size=0.7) +
  geom_vline(xintercept = as.Date("2020-04-08"), linetype='dashed', color='black', size=0.7) +
  scale_x_continuous(breaks=as.Date(c('2020-03-01', '2020-03-18', '2020-04-01', 
                                      '2020-04-08', '2020-05-01', '2020-06-01')), 
                     labels=c('Mar', 'Mar18', 'Apr1', 'Apr8', 'May', 'Jun')) +
  geom_line(aes(y=new_deaths_per_million_smoothed, color=Country), size=1)
```

# Model estimation
# Standard DiD equation

```{=latex}
\begin{equation}
y_{c,t} = \alpha + \gamma \cdot Treat_c + \lambda \cdot Post_t + \delta (Treat_c \cdot Post_t) + \varepsilon_{c,t}
\end{equation}
```

```{r}
#Factorize the indicator
dta$C2_Workplace <- factor(dta$C2_Workplace)

#No measure = Recommended = 0; Required = 1
levels(dta$C2_Workplace) <- c(0,0,1)

#Create Treat and Post dummies
dta$Post.1 <- factor(ifelse(dta$Time >= as.Date("2020-03-18"), 1, 0))
dta$Post.2 <- factor(ifelse(dta$Time >= as.Date("2020-04-01"), 1, 0))
dta$Post.3 <- factor(ifelse(dta$Time >= as.Date("2020-04-08"), 1, 0))
dta$Treat <- factor(ifelse(dta$Country=='DNK', 1, 0))

#Models for cases
###Post-1
smooth.cases.1 <- lm(new_cases_per_million_smoothed ~ Treat + Post.1 + Post.1*Treat, dta, subset=1:84)

###Post-2
smooth.cases.2 <- lm(new_cases_per_million_smoothed ~ Treat + Post.2 + Post.2*Treat, dta, subset=29:112)

###Post-3
smooth.cases.3 <- lm(new_cases_per_million_smoothed ~ Treat + Post.3 + Post.3*Treat, dta, subset=43:126)

#Model for deaths
###Post-1
smooth.deaths.1 <- lm(new_deaths_per_million_smoothed ~ Treat + Post.1 + Post.1*Treat, dta, subset=1:84)

###Post-2
smooth.deaths.2 <- lm(new_deaths_per_million_smoothed ~ Treat + Post.2 + Post.2*Treat, dta, subset=29:112)

###Post-3
smooth.deaths.3 <- lm(new_deaths_per_million_smoothed ~ Treat + Post.3 + Post.3*Treat, dta, subset=43:126)

#check summary() for coefficients
```

```{=latex}
\setlength{\arrayrulewidth}{1.2pt}
\begin{center}
\begin{table}[h!]
\begin{tabular}{ p{3cm} >{\centering}m{4cm} >{\centering}m{4cm} >{\centering\arraybackslash}m{4cm} } 
 \hline \\
 \textbf{Coefficient} & $\mathbf{t_0=March \ 18}$ & $\mathbf{t_0=April \ 1}$ & $\mathbf{t_0=April \ 8}$ \\[8pt]
 \hline\\[1pt]
 \multirow{2}{*}{$\delta \ for \ y = Cases$} & $-2.15$ & $-8.52$ ** & $-16.47$  ***\\ 
 & (4.54) & (3.02) & (4.71)\\[5pt]  
 $R^2$ & 0.50 & 0.82 & 0.55\\[5pt]
 Observations & 84 & 84 & 84 \\[8pt]
 \hline\\
 \multirow{2}{*}{$\delta \ for \ y = Deaths$} & $-1.28$ * & $-4.96$ *** & $-5.14$ *** \\
 & (0.51) & (0.51) & (0.54)\\[5pt] 
 $R^2$ & 0.44 & 0.87 & 0.86\\[5pt]
 Observations & 84 & 84 & 84 \\[8pt]
 \hline
\end{tabular}
\caption{For each estimate, standard errors are reported in parentheses. Level of significance: * = p-value < 0.05; ** = p-value < 0.01; *** = p-value < 0.001. Each model considers a six-week window: three weeks before $t_0$ and three weeks afterwards, resulting in 84 daily observations.}
\label{table:3}
\end{table}
\end{center}
```

# Event-study approach

```{=latex}
\begin{equation}
y_{c,t,w} = \alpha + \gamma \cdot Treat_c + \sum_{w=2}^{W} (\lambda_w \cdot Weeek_w) + \sum_{w=1}^{W} (\delta_w \cdot TStatus_{c,t} \cdot Week_w) + \varepsilon_{c,t}
\end{equation}
```

```{r, fig.height=4, fig.width=10}
#Week fixed effects
dta$Week <- factor(rep(1:14, each=14))

#CASES Event study
event.study.cases <- lm(new_cases_per_million_smoothed ~ Treat + Week + Week*C2_Workplace - C2_Workplace, dta)
coeff.cases <- as.data.frame(summary(event.study.cases)$coefficients[-c(1:15), c('Estimate', "Std. Error", "Pr(>|t|)")])
coeff.cases$Inf.Limit <- coeff.cases$Estimate - (1.96 * coeff.cases$`Std. Error`)
coeff.cases$Sup.Limit <- coeff.cases$Estimate + (1.96 * coeff.cases$`Std. Error`)

###Plot
ggplot(coeff.cases, aes(x=1:11, y=Estimate)) + geom_point(size=3, color='#BC412B') + 
  geom_line(linetype='dashed', color='#BC412B') + geom_hline(yintercept = 0, linetype='dashed') +
  geom_errorbar(aes(ymin=Inf.Limit, ymax=Sup.Limit), width=0.4, color='black', size=1, alpha=0.4) + 
  theme_bw() +
  labs(x='Weeks after March 18')
```

```{r, fig.height=4, fig.width=10}
#DEATHS Event study
event.study.deaths <- lm(new_deaths_per_million_smoothed ~ Treat + Week + Week*C2_Workplace - C2_Workplace, dta)
coeff.deaths <- as.data.frame(summary(event.study.deaths)$coefficients[-c(1:15), c('Estimate', "Std. Error", "Pr(>|t|)")])
coeff.deaths$Inf.Limit <- coeff.deaths$Estimate - (1.96 * coeff.deaths$`Std. Error`)
coeff.deaths$Sup.Limit <- coeff.deaths$Estimate + (1.96 * coeff.deaths$`Std. Error`)

###Plot
ggplot(coeff.deaths, aes(x=1:11, y=Estimate)) + geom_point(size=3, color='#BC412B') + 
  geom_line(linetype='dashed', color='#BC412B') + geom_hline(yintercept = 0, linetype='dashed') +
  geom_errorbar(aes(ymin=Inf.Limit, ymax=Sup.Limit), width=0.5, color='black', size=1, alpha=0.5) +
  theme_bw() +
  labs(x='Weeks after March 18')
```
