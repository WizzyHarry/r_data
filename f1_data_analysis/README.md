# F1 Racing Analysis

## Is there a better driver than the winner?

**Keith Faunce**

***This is a statistical study done purely for fun and has no implications on Formula 1***

<p>In the world of F1, there has long been debate: are winning drivers
(notably Verstappen and Hamilton) dominant because of their talent, or their car?
Lando Norris himself has fueled this conversation with subtle remarks toward Lewis Hamilton and his machinery.

With questions like these, I set out to measure driver performance differently—placing emphasis on **overtakes**, inspired by Murray Walker’s famous phrase:
*"Catching is one thing; passing is another."*</p>

<br>

## Measuring Sucess

<b>The Process</b>
<p>Driver success is measured using a points system. Points are awarded based on race metrics, these metrics can yield positive and negative results.</p>

<b> The Metrics </b>
<p> Positive: </p>
<ul>
  <li>Qualifying placement</li>
  <li>Average lap time</li>
  <li>Fastest lap time</li>
  <li>Laps leading</li>
  <li>Overtakes</li>
</ul>
<p> Negative: </p>
<ul>
  <li>Pit stops</li>
  <li>Overtakes</li>
</ul>

<br>

### Point Values

[Calculation Information](point_values/README.md)

### Data Allocation & Citations

<p>Contains .R file that was used for parsing, and calculations used to generate final results. Details
of steps taken in Pre-Processing, and links to data resources & citations.</p>

[Data Resources](data/README.md)

<br>

## The Results

***Individual race breakdowns found below***

### Official 2024 F1 Season Driver Points

![official points](race_db_images/real_points.PNG)

### Data Analysis 2024 F1 Season Driver Points

![unofficial points](race_db_images/analysis_points.PNG)

<br>

## Races

<b> Shown table attributes include: </b>
<ul>
  <li>Driver Name</li>
  <li>Overtake points: Typically the most influential category</li>
  <li>Total points: Sum of a driver's points per race</li>
  <li>Race result: Actual position driver finished in</li>
  <li>Point result: Ranks drivers by number of points earned</li>
</ul>

#### Note:
<ul>
  <li>If the overtakes field is blank, that driver had no statistical passing situations</li>
  <li>Overtakes are weighted differently, the higher the position the more valuable</li>
  <li>If race result is marked as R: Driver retired</li>
  <li>If race result is marked as D: Driver disqualified</li>
  <li>In final tally, retired (R) & disqualified (D) drivers points count as 0 instead of -25</li>
  <li>This analysis covers the first 21 races of the season</li>
</ul>

### Bahrain

![Bahrain](race_db_images/bahrain.PNG)

### Saudi Arabia

![Saudi](race_db_images/Saudi_Arabia.PNG)

### Australia

![Australia](race_db_images/australia.PNG)

### Japan

![Japan](race_db_images/japanese.PNG)

### China

![China](race_db_images/china.PNG)

### Miami

![Miami](race_db_images/miami.PNG)

### Emilia Romagna

![Emilia](race_db_images/emilia.PNG)

### Monaco

![Monaco](race_db_images/monaco.PNG)

### Canada

![Canada](race_db_images/canada.PNG)

### Spain

![Spain](race_db_images/spain.PNG)

### Austria

![Austria](race_db_images/austrian.PNG)

### Britian

![Britian](race_db_images/british.PNG)

### Hungary

![Hungry](race_db_images/hungry.PNG)

### Belgium

![Belgium](race_db_images/belgian.PNG)

### Netherlands

![Netherlands](race_db_images/dutch.PNG)

### Italy

![Italy](race_db_images/italy.PNG)

### Azerbaijan

![Azerbaijan](race_db_images/azerbajan.PNG)

### Singapore

![Singapore](race_db_images/singapore.PNG)

### United States(TX)

![TX](race_db_images/ustx.PNG)

### Mexico

![Mexico](race_db_images/mexico.PNG)

### Sao Paulo

![Sao_Paulo](race_db_images/sao_paulo.PNG)
