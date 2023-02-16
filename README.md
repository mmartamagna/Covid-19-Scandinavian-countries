# Difference-in-Differences to identify the causal effect of NPIs during Covid-19: evidence from Denmark and Sweden
_This project was prepared with a M.Sc. colleague for the Labour economics and Policy evaluation course. Everything written and plotted below was entirely prepared by the authors._

During the first wave of Covid-19, not all European countries adopted the same restrictive strategies and policies. An interesting case is the one regarding Sweden, which decided to not impose severe confinement measures and to rely on community trust and individual decision-making. Conversely, confining Scandinavian countries such as Denmark immediately introduced severe non-pharmaceutical interventions (NPIs) to tackle the emergency. In this project, we exploit policy variation between Denmark and Sweden to investigate the causal effect of introducing NPIs, namely workplace closing and gatherings restrictions, on the 7-day moving average of deaths and cases. Our Difference-in-Differences (DiD) models provide evidence that during the first Covid-19 wave such policies have been significantly effective and persistent over time in curtailing the curve of deaths and cases in Denmark, as compared to the Swedish situation.

## Project outline

1. [Institutional background](#insitutional-background)
2. [Policy response to Covid-19](#policy-response-to-Covid-19)
3. [Data](#data)
4. [Model estimation (DiD)](#model-estimation-(DiD))
5. [Conclusions](#conclusions)


### 1. Institutional background
The different responses to the Covid-19 crisis that occurred in neighbouring countries such as Sweden and Denmark attracted our attention because they are generally known for having nearly identical state-society relations and political-administrative systems (Plümper et al., 2020). These aspects contributed to considering them as optimal candidates for a DiD application, because in a such setting the only difference between the treated and control groups is supposed to be the treatment itself. In this DiD analysis, Sweden served as a counterfactual to Denmark because it was the only country that has not applied strict containment measures. Before defining the model, it’s crucial to provide a comprehensive comparison between the two Scandinavian countries in terms of economics, healthcare and demographic characteristics, to better understand their similarities and differences.

Table 1 displays some key characteristics of Sweden and Denmark. Sweden has almost twice the population of Denmark, whereas Denmark presents a significantly higher population density. This is meaningful from the moment that, in absence of any kind of non-pharmaceutical intervention, epidemics are likely to spread faster in countries with a higher population density (Juranek et al., 2021). Nonetheless, characteristics such as population and population density were considered fixed in the model estimation, so that such differences are captured by state-specific fixed effects.

<img width="600" alt="tabella covid" src="https://user-images.githubusercontent.com/87983033/219108045-871e32f9-2e48-4dbb-8d13-5376d6cf190f.png">

### 2. Policy response to Covid-19
As previously stated, the emergency management of Sweden and Denmark has attracted our attention because, despite all their similarities in terms of culture, climate, healthcare, and institutional framework, it has resulted in different strategies and timing of intervention. While Denmark followed to some extent the European trend of adopting strict non-pharmaceutical interventions (e.g. closing of workplaces and lockdowns), the Swedish government was less severe and opted for introducing measures mainly based on trust and individual responsibility. Regarding this, the Swedish containment strategy was presented to Nature by the epidemiologist Anders Tegnell, who declared in April 2020 that “as a society, we are more into nudging: continuously reminding people to use measures, improving measures where we see day by day that they need to be adjusted. We do not need to close down everything completely because it would be counterproductive” (Paterlini, 2020). In general, the Swedish scheme to contain Covid-19 spread was based on the voluntary social distancing and self-restraint of citizens, who were accustomed to receive daily briefings and instructions concerning self-protection techniques from the Swedish Public Health Agency and press conferences held by state epidemiologists, the Prime Minister, and other government representatives (Yan et al., 2020). To make more intuitive the comparison between the different policies adopted by these two countries during the first wave, we summarized the containment measures and the dates of their introduction based on the Oxford COVID-19 Government Response Tracker (Table 2).

<img width="600" alt="tabella 2" src="https://user-images.githubusercontent.com/87983033/219108052-2ebb744b-ebb5-49f7-98dc-0a46b4c30dd5.png">

```ruby
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
<img width="600" alt="figure 1" src="https://user-images.githubusercontent.com/87983033/219109493-0757bebc-1c67-49ba-b344-f528deee3369.png">

```ruby
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

<img width="600" alt="figure 2" src="https://user-images.githubusercontent.com/87983033/219109503-ae4d77e5-325f-4b02-bac9-84c102bd7741.png">


### 3. Data
Information on daily Covid-19 deaths and cases in Sweden and Denmark covers the period from February 26 up to June 3, 2020. In particular, the data employed to perform the empirical investigation are drawn from the European Centre for Disease Prevention. In this study, the main two outcomes are the 7-day moving average of new daily Covid-19 cases and deaths. Despite the availability of daily data about Covid- 19 cases and deaths, we opted for using only the 7-day moving average in the DiD implementation because it provides an average line over time and mitigates the daily fluctuations of deaths and cases. Since, as seen in the Institutional background section, the two countries have a rather different population size, such numbers has been normalized per million population. In order to distinguish between pre- and post-treatment periods, we used policies’ information from the Oxford COVID-19 Government Response Tracker, which report March 18 as the first day when gatherings restrictions and workplace closing were applied in Denmark, but not in Sweden. We highlight that this difference persists for the whole studied period (i.e. until June 3). Preliminary descriptive graphs for daily Covid-19 deaths and cases with 7-day moving average are presented below.

```ruby
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

```ruby
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
  
<img width="600" alt="figura 3 e 4" src="https://user-images.githubusercontent.com/87983033/219110508-d6de74a3-75f6-487f-9069-6bb0937be562.png">


### 4. Model estimation (DiD)
The purpose of the article is thus to apply a **Difference-in-Differences (DiD)** framework to estimate the causal effect of NPIs (especially workplace closing and gatherings restrictions), which took place in Denmark but not in Sweden, on the 7-day moving average of daily Covid-19 deaths and cases, normalized per million population. In particular, the period considered covers February 26 - June 3, 2020, which comprehends the first wave of Covid-19 in Scandinavia. The DiD approach has been chosen because it “makes use of naturally occurring phenomena or policy changes that may induce some form of randomization across individuals in the eligibility of the assignment to the treatment” (Blundell et al., 2009). In this setting, the job places closing and gathering restrictions contribute to naturally creating a reasonable control group (Sweden) and a reasonable treatment group (Denmark) through which it is possible to evaluate the efficacy of the policy. 

In the absence of randomized controlled trials, we used observational data to test the efficacy of NPIs on the 7-day moving average of Covid-19 deaths and cases. As seen in the institutional background section, Denmark and Sweden share sufficient similarities so that, when faced with an exogenous policy intervention in one country, it is possible to consider them as a reasonable treatment group (Denmark) and control group (Sweden). In particular, the effect of NPIs (workplace closures and gatherings restrictions) on Covid-19 cases and deaths was investigated with two different approaches:

• **Standard DiD equation**: a simple regression equation is estimated with a single coefficient of interest, corresponding to the Average Treatment Effect on the Treated (ATT), that is the number of Covid-19 cases and deaths (in terms of 7-day moving average) avoided by the Danish government thanks to stricter restrictions. We expected this coefficient to be negative and significant. However, since the effects of a lockdown cannot be observed immediately after its introduction, we estimated this model using different values for the date defining the pre- and post-treatment period: March 18 (the actual implementation of the policy), April 1 (two weeks later) and April 8 (three weeks later), each time centering the chosen time point in a six-weeks window.

• **Event study approach**: the main drawback of the standard DiD equation is that its coefficient of interest (ATT) is an average estimate, which does not allow to study in detail how the policy effects evolved over time. Nevertheless, by applying the event-study approach it was possible to inspect how the “lockdown effect” changed over time and the extent to which it remained significant. 

#### 4.1 DiD assumptions
In order to be theoretically supported, the formal identification of a DiD model requires three main assumptions to be respected.

1) **Common trend assumption**. The identification of the ATT using DiD relies on the assumption that, in the absence of the treatment (NPIs introduction), the treatment group (Denmark) and the control group (Sweden) would have experienced parallel trends in terms of 7-day moving average of Covid-19 cases and deaths. 
We observed that both daily Covid-19 cases and deaths experienced a common and parallel trend until the policy introduction and beyond (see Fig. 3 and Fig. 4).
This because the incubation period for Covid-19 (i.e., the time between exposure to the virus and the onset of symptoms) is estimated to be between one and 14 days (WHO, 2021) leading us to suppose that the effect of policy restrictions cannot be evident close to the policy introduction date (March 18).

2) **Participation into the treatment is independent of idiosyncratic shocks**. In order to ensure a meaningful comparability, participation into treatment must be exogenous, i.e., not driven by some time-variant state-specific characteristics or shock. In this case, the “Ashenfelter’s Dip”, which is the phenomenon explaining the anticipation effects regarding future participation into the treatment (Bergemann et al., 2009), is not observed in Fig. 3 and Fig. 4. Therefore, we assumed that the ATT estimate referred to the NPIs introduction and not to other idiosyncratic shocks.

3) **Absence of systematic composition changes within each group**. If systematic composition changes (e.g. in population density) occurred within each group, the observed difference in the outcome would be caused not only by the treatment itself but also by those changes. It is unlikely this assumption to be disregarded. The populations of the considered countries are large, and so a huge movement of people would be needed to change the composition substantially. Second, many travel bans were adopted at that time.

### 4.2 Standard DiD equation
In the current section, we estimated a simple Difference-in-Differences (DiD) model to identify the restrictions’ effect on deaths and cases due to Covid-19. Therefore, we defined the following equation:

$y_{c,t}$ = $α$ + $γ$ * $Treat_c$ + $λ$ * $Post_t$ + $δ$($Treat_c$ * $Post_t$) + $ε_{c,t}$

Where $y_{c,t}$ denotes the outcome variable for country $c$ at time $t$, $Treat_c$ is a dummy identifying the treated country (1 for Denmark, 0 for Sweden), $Post_t$ is a dummy variable identifying the post-treatment observations, and $\delta$ is the coefficient of interest (the ATT). As already said, different specifications are used to define pre- and post-treatment periods ($t=t_0$) and the model is estimated with two different outcome variables: 7-day moving average of new daily cases and new daily deaths per million population. The results of the model, estimated through the `lm` R function, are shown in the table below.

```ruby
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
<img width="500" alt="table 3" src="https://user-images.githubusercontent.com/87983033/219318735-2476645e-6a65-4f69-a958-4279e17c50da.png">

### 4.3 Event-study approach
As previously said, the event-study approach allows to inspect how the “lockdown effect” changed over time and the extent to which it remained significant. Restrictions were heavier in Denmark than in Sweden until June 3, where the policies were placed on the same level (both countries forbade gatherings greater than 10 people). We estimated an event-study model using 7-day moving average observations up to June 3 in order to evaluate the joint effect of workplace closures and gatherings restrictions in the eleven weeks after the policies introduction (March 18). The model has the following form: 

$y_{c,t,w}$ = $α$ + $γ$ * $Treat_c$+ $Σ_{w=2}^{W}$($λ_w$ * $Week_w$) + $Σ_{w=1}^{W}$($δ_w$ * $TStatus_{c,t}$ * $Week_w$) + $ε_{c,t}$

Where $y_{c,t,w}$ denotes the outcome variable for country $c$ at day $t$ and week $w$, $Treat_c$ is a dummy identifying the treated state (1 for Denmark, 0 for Sweden), $\lambda_w$ are the week-fixed effects coefficients, and $TStatus_{c,t}$ is a dummy equal to 1 if and only if country $c$ is treated at time $t$. Our coefficients of interest are the $\delta_w$'s, which capture the differences between the two states in the outcome variable caused by the treatment across eleven weeks from the beginning of the treatment. Estimates for $\delta_w$ and relative 95% C.I. are shown in the plots below. 

```ruby
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
<img width="500" alt="fig 5" src="https://user-images.githubusercontent.com/87983033/219320158-36446bdd-ed04-49d8-b8f1-cba31c14f0b6.png">

<img width="500" alt="fig 6" src="https://user-images.githubusercontent.com/87983033/219320141-cd774f00-14ed-4e39-b3f8-8214105b6133.png">

### 5. Conclusions




