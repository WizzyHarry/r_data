# Pre-Processing

<b>At the time of this analysis, I was unaware of the many pre-processing strategies I could have utilized to streamline my work. All pre-processing steps were performed directly in RStudio. They are included in my R file, which covers all aspects of the analysis.</b>

## Pre-Processing Steps

<p>The Ergast API is a specialized F1 API containing racing data from 1969–2024.
The corresponding Entity Relationship Diagram is shown below.
</n>
The only outsourced data came from RacingPass, an independent blog that tracks and compiles overtake counts for each driver in every race.</p>

<p> Pre-processing steps included</p>
<ul>
  <li>Connecting drivers to driver_id</li>
  <li>Connecting races to race_id</li>
  <li>Creating qualifying quarters</li>
  <li>Handling null values</li>
  <li>Adjusting data types</li>
</ul>

<p>RacingPass provided their overtake data in a neatly structured .csv file with fields such as overtaker, overtaken, and position gained.
I replaced the overtaker/overtaken fields with driver_ids and used the position gained column to calculate the “importance of an overtake.” More details are provided in the Point Values section.</p>

## Sources

<b>All compiled statistical data came from Ergast F1 API & Racing Pass</b>

[Ergast API](https://ergast.com/mrd/)

[Racing Pass](https://racingpass.net/)

## Files

#### R file

[F1_data_analysis_R](avg_lap_times.R)

#### CSV's & Zip

[circuits.csv](circuits.csv)

[drivers.csv](drivers.csv)

[lap_times.csv](lap_times.csv)

[overtakes.csv](overtakes.csv)

[pit_stops.csv](pit_stops.csv)

[qualifying.csv](qualifying.csv)

[races.csv](races.csv)

[results.csv](results.csv)

[f1db_csv.zip](f1db_csv.zip)

[driver_names](driver_names.txt)

#### API DB Relationship Diagram

![Ergast_DB](ergast_db-1.png)