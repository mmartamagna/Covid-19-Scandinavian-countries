# Difference-in-Differences to identify the causal effect of NPIs during Covid-19: evidence from Denmark and Sweden

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

<img width="452" alt="tabella covid" src="https://user-images.githubusercontent.com/87983033/219108045-871e32f9-2e48-4dbb-8d13-5376d6cf190f.png">

### 2. Policy response to Covid-19
As previously stated, the emergency management of Sweden and Denmark has attracted our attention because, despite all their similarities in terms of culture, climate, healthcare, and institutional framework, it has resulted in different strategies and timing of intervention. While Denmark followed to some extent the European trend of adopting strict non-pharmaceutical interventions (e.g. closing of workplaces and lockdowns), the Swedish government was less severe and opted for introducing measures mainly based on trust and individual responsibility. Regarding this, the Swedish containment strategy was presented to Nature by the epidemiologist Anders Tegnell, who declared in April 2020 that “as a society, we are more into nudging: continuously reminding people to use measures, improving measures where we see day by day that they need to be adjusted. We do not need to close down everything completely because it would be counterproductive” (Paterlini, 2020). In general, the Swedish scheme to contain Covid-19 spread was based on the voluntary social distancing and self-restraint of citizens, who were accustomed to receive daily briefings and instructions concerning self-protection techniques from the Swedish Public Health Agency and press conferences held by state epidemiologists, the Prime Minister, and other government representatives (Yan et al., 2020). To make more intuitive the comparison between the different policies adopted by these two countries during the first wave, we summarized the containment measures and the dates of their introduction based on the Oxford COVID-19 Government Response Tracker (Table 2).

<img width="500" alt="tabella 2" src="https://user-images.githubusercontent.com/87983033/219108052-2ebb744b-ebb5-49f7-98dc-0a46b4c30dd5.png">

<img width="500" alt="figure 1" src="https://user-images.githubusercontent.com/87983033/219109493-0757bebc-1c67-49ba-b344-f528deee3369.png">

<img width="500" alt="figure 2" src="https://user-images.githubusercontent.com/87983033/219109503-ae4d77e5-325f-4b02-bac9-84c102bd7741.png">



### 3. Data
Information on daily Covid-19 deaths and cases in Sweden and Denmark covers the period from February 26 up to June 3, 2020. In particular, the data employed to perform the empirical investigation are drawn from the European Centre for Disease Prevention. In this study, the main two outcomes are the 7-day moving average of new daily Covid-19 cases and deaths. Despite the availability of daily data about Covid- 19 cases and deaths, we opted for using only the 7-day moving average in the DiD implementation because it provides an average line over time and mitigates the daily fluctuations of deaths and cases. Since, as seen in the Institutional background section, the two countries have a rather different population size, such numbers has been normalized per million population. In order to distinguish between pre- and post-treatment periods, we used policies’ information from the Oxford COVID-19 Government Response Tracker, which report March 18 as the first day when gatherings restrictions and workplace closing were applied in Denmark, but not in Sweden. We highlight that this difference persists for the whole studied period (i.e. until June 3). Preliminary descriptive graphs for daily Covid-19 deaths and cases with 7-day moving average are presented below.

<img width="500" alt="figura 3 e 4" src="https://user-images.githubusercontent.com/87983033/219110508-d6de74a3-75f6-487f-9069-6bb0937be562.png">


### 4. Model estimation (DiD)
The purpose of the article is thus to apply a Difference-in-Differences (DiD) framework to estimate the causal effect of NPIs (especially workplace closing and gatherings restrictions), which took place in Denmark but not in Sweden, on the 7-day moving average of daily Covid-19 deaths and cases, normalized per million
population. In particular, the period considered covers February 26 - June 3, 2020, which comprehends the first wave of Covid-19 in Scandinavia. The DiD approach has been chosen because it “makes use of naturally occurring phenomena or policy changes that may induce some form of randomization across individuals in the eligibility of the assignment to the treatment” (Blundell et al., 2009). In this setting, the job places closing and gathering restrictions contribute to naturally creating a reasonable control group (Sweden) and a reasonable treatment group (Denmark) through which it is possible to evaluate the efficacy of the policy. We found evidence that such policies were significantly effective in curbing down the curve of deaths and cases in Denmark, as compared to the Swedish situation. Moreover, we found such effects to be particularly persistent over time.

### 5. Conclusions




