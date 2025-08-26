rm(list = ls(envir = globalenv()), envir = globalenv());
if(!is.null(dev.list())) dev.off(); gc(); cat("\014")

# setwd("C:/Users/sirsh/Desktop/f1 data")

setwd("C:/Users/sirsh/github/portfolio/f1_data_analysis/data")
# reading data
pit_stops <- read.csv("pit_stops.csv", header = TRUE, sep = ",")
lap_times <- read.csv("lap_times.csv", header = TRUE, sep = ",")
drivers <- read.csv("drivers.csv", header = TRUE, sep = ",")
qualifying <- read.csv("qualifying.csv", header = TRUE, sep = ",")
results <- read.csv("results.csv", header = TRUE, sep = ",")
overtakes <- read.csv("overtakes.csv", header = TRUE, sep = ",")
races <- read.csv("races.csv", header = TRUE, sep = ",")

# data structure
str(lap_times)
str(find_driverId)
str(pit_stops)
str(qualifying)
str(results)
str(overtakes)
str(races)

#library
install.packages("lubridate")
install.packages("formattable")
install.packages("DT")

library(dplyr)
library(lubridate)
library(formattable)
library(DT)


# universal attributes
race_filter <- 1121:1141
driver_filter <- c(1, 830, 815, 832, 844, 847, 822, 846, 857, 4, 840, 855, 825,
                   858, 817, 852, 848, 807, 839, 842, 860, 861, 859) %>%
  as.integer(driver_filter)
driver_filter <- unique(drivers$driverId)
race_filter <- unique(races$raceId[races$raceId >= 1121 & races$raceId <= 1141])
# -----------------------------------------------------------




# queried points data
# 1/31 points are not ordered, just grouped by race
# pit stops
pit_stop_points <- pit_stops %>%
  filter(raceId %in% race_filter, driverId %in% driver_filter) %>%
  group_by(raceId, driverId) %>%
  summarise(num_stops = n(), .groups = "drop") %>%
  mutate(pit_stop_points = 1.25 * num_stops * -1) %>%
  rename(points = pit_stop_points)


# qualifying
qualifying_points <- qualifying %>%
  filter(raceId %in% race_filter, driverId %in% driver_filter) %>%
  group_by(raceId, driverId) %>%
  summarise(position = min(position), groups = "drop") %>%
  mutate(
    qualifying_points = case_when(
      position == 1 ~ 5,
      position == 2 ~ 4.5,
      position == 3 ~ 4,
      position == 4 ~ 3.5,
      position == 5 ~ 3,
      position == 6 ~ 2.5,
      position == 7 ~ 2,
      position == 8 ~ 1.5,
      position == 9 ~ 1,
      position == 10 ~ 0.5,
      TRUE ~ 0
    )
  ) %>%
  rename(points = qualifying_points)


# best lap points
fastest_lap_points <- results %>%
  filter(raceId %in% race_filter, driverId %in% driver_filter) %>%
  group_by(raceId, driverId) %>%
  summarise(rank = min(rank),
            # shows driver results and DNF
            positionText = first(positionText),
            groups = "drop") %>%
  mutate(
    fastest_lap_points = case_when(
      rank == 1 ~ 5,
      rank == 2 ~ 4.5,
      rank == 3 ~ 4,
      rank == 4 ~ 3.5,
      rank == 5 ~ 3,
      rank == 6 ~ 2.5,
      rank == 7 ~ 2,
      rank == 8 ~ 1.5,
      rank == 9 ~ 1,
      rank == 10 ~ 0.5,
      TRUE ~ 0
    )
  ) %>%
  rename(points = fastest_lap_points)


# avg lap points
# getting avg lap time through converting seconds using lubridate library
avg_laps_points <- lap_times %>%
  filter(raceId %in% race_filter, driverId %in% driver_filter) %>%
  group_by(raceId, driverId) %>%
  summarise(
    avg_lap_seconds = mean(as.numeric(ms(time)), na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(raceId, avg_lap_seconds) %>% # sorts by avg time ASC
  group_by(raceId) %>%
  mutate(
    rank = row_number(), # with avg time being sorted, row_num does rest
    avg_laps_points = case_when(
      rank == 1 ~ 10,
      rank == 2 ~ 9,
      rank == 3 ~ 8,
      rank == 4 ~ 7,
      rank == 5 ~ 6,
      rank == 6 ~ 5,
      rank == 7 ~ 4,
      rank == 8 ~ 3,
      rank == 9 ~ 2,
      rank == 10 ~ 1,
      rank == 11 ~ 0.9,
      rank == 12 ~ 0.8,
      rank == 13 ~ 0.7,
      rank == 14 ~ 0.6,
      rank == 15 ~ 0.5,
      rank == 16 ~ 0.4,
      rank == 17 ~ 0.3,
      rank == 18 ~ 0.2,
      rank == 19 ~ 0.1,
      TRUE ~ 0
    )
  ) %>%
  ungroup() %>%
  rename(points = avg_laps_points)


# laps led points
laps_led_points <- lap_times %>%
  filter(raceId %in% race_filter, driverId %in% driver_filter) %>%
  group_by(raceId, driverId) %>%
  summarise(
    laps_led = sum(position == 1, na.rm = TRUE),
    .groups = "drop",
  ) %>%
  mutate(
    laps_led_points = case_when(
      laps_led >= 25 ~ 10,
      laps_led >= 10 ~ 6,
      laps_led >= 5 ~ 4,
      TRUE ~ 0
    )
  ) %>%
  rename(points = laps_led_points)


# overtake data for points
# overtaker points
overtaker_points <- overtakes %>%
  filter(raceId %in% race_filter, overtaker %in% driver_filter) %>%
  mutate(
    overtaker_points = case_when(
      for_position %in% 1:6 ~ 3,
      for_position %in% 7:13 ~ 2,
      for_position %in% 14:20 ~ 1,
      TRUE ~ 0
    )
  ) %>%
  group_by(raceId, overtaker) %>%
  summarise( # count overtake points
    overtaker_total_points = sum(overtaker_points),
    .groups = "drop"
  )

# overtaken points
overtaken_points <- overtakes %>%
  filter(raceId %in% race_filter, overtaken %in% driver_filter) %>%
  mutate(
    overtaken_points = case_when(
      for_position %in% 1:6 ~ 3,
      for_position %in% 7:13 ~ 2,
      for_position %in% 14:20 ~ 1,
      TRUE ~ 0
    )
  ) %>%
  group_by(raceId, overtaken) %>%
  summarise(
    overtaken_total_points = sum(overtaken_points),
    .groups = "drop"
  ) 

# join overtakes and takens
overtakes_points <- full_join(
  overtaker_points,
  overtaken_points,
  by = c("raceId" = "raceId", "overtaker" = "overtaken")
) %>%
  mutate( # ensures any null values do not result in points
    overtaker_total_points = coalesce(overtaker_total_points, 0),
    overtaken_total_points = coalesce(overtaken_total_points, 0),
    total_points = overtaker_total_points - overtaken_total_points
  ) %>%
  rename(driverId = overtaker) %>%
  rename(points = total_points) 

glimpse(overtakes_points)


# other tables for organization in mega table
# race name and date
new_race <- races %>%
  filter(raceId %in% race_filter) %>%
  select(raceId, name, date)
glimpse(new_race)

race_info <- merge(new_drivers, new_race, all = TRUE)

# driver names
new_drivers <- drivers %>%
  filter(driverId %in% driver_filter) %>%
  select(driverId, forename, surname)
glimpse(new_drivers)




# -----------------------------------------------------------
# checking for consistency accross tables
# issues with the final join.
colnames(race_info)
colnames(fastest_lap_points)
colnames(qualifying_points)
colnames(pit_stop_points)
colnames(avg_laps_points)
colnames(laps_led_points)
colnames(overtakes_points)

# data types match
# no nulls
class(race_info)
head(race_info)
is.null(race_info)
str(race_info)
str(fastest_lap_points)
str(qualifying_points)
str(pit_stop_points)
str(avg_laps_points)
str(laps_led_points)
str(overtakes_points)
is.null(fastest_lap_points)
is.null(qualifying_points)
is.null(pit_stop_points)
is.null(avg_laps_points)
is.null(laps_led_points)
is.null(overtakes_points)
# -----------------------------------------------------------




# ----------------------------------------------------------------
  
  
# Merging of all tables, points are seperate with suffixes 
inter_join <- race_info %>%
  left_join(
    fastest_lap_points %>%
      select(driverId, raceId, points, positionText), 
    by = c("driverId", "raceId"),
    suffix = c("", "_fastest_lap")
  ) %>%
  left_join(
    pit_stop_points %>%
      select(driverId, raceId, points),
    by = c("driverId", "raceId"),
    suffix = c("", "_pit_stop")
  ) %>%
  left_join(
    qualifying_points %>%
      select(driverId, raceId, points),
    by = c("driverId", "raceId"),
    suffix = c("", "_qualifying")
  ) %>%
  left_join(
    avg_laps_points %>%
      select(driverId, raceId, points),
    by = c("driverId", "raceId"),
    suffix = c("", "_avg_lap")
  ) %>%
  left_join(
    laps_led_points %>%
      select(driverId, raceId, points),
    by = c("driverId", "raceId"),
    suffix = c("", "_laps_led")
  ) %>%
  left_join(
    overtakes_points %>%
      select(driverId, raceId, points),
    by = c("driverId", "raceId"),
    suffix = c("", "_overtakes")
  )
  

# adding point values and retirement condition
final_results <- inter_join %>%
  rowwise() %>%
  mutate(total_points = sum(c_across(starts_with("points_")), na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(total_points = if_else(!is.na(positionText) & positionText == "R", -15, total_points)) %>%
  arrange(raceId, desc(total_points)) %>%
  filter(!is.na(positionText))

# select clause for readme
photo <- final_results %>%
  select(raceId, name, date, forename, surname, points_overtakes, total_points, positionText) %>%
  group_by(raceId) %>% 
  mutate(rank = dense_rank(desc(total_points))) %>%
  ungroup() %>%
  arrange(raceId, desc(total_points)) %>%
  rename(race_result = positionText) %>%
  rename(points_result = rank)
  
datatable(photo, 
          options = list(
            scrollX = TRUE,
            scrollY = "400px",
            fixedHeader = TRUE,  # fix table headers
            pageLength = nrow(photo)
          ))

year_points <- final_results %>%
  select(driverId, forename, surname, total_points) %>%
  mutate(total_points = if_else(total_points == -15, 0, total_points)) %>%
  # replace retired values for 0
  group_by(driverId) %>%
  mutate(total_points = sum(total_points)) %>%
  distinct(driverId, .keep_all = TRUE) %>%
  ungroup() %>%
  arrange(desc(total_points))


# total points for the year
datatable(year_points,
          options = list(
            scrollX = TRUE,
            scrollY = "350px",
            fixedHeader = TRUE,
            pageLength = nrow(year_points)
          ))



# data filtration for setting up unique values, such as total pit stops, avg lap
# ------------------------------------------------------------------------------
# Pre Processing
unique_race_ids <- unique(my_data$raceId)
print(unique_race_ids)

# shows position for laps led
driver_1_race_841 <- lap_times[lap_times$raceId == 1144 & lap_times$driverId == 1, ]
print(driver_1_race_841)

# Looking for other drivers
do_driver_exist <- my_data[my_data$raceId == 1144, ]
print(do_driver_exist)

# driverIds contain ALL drivers, seemingly random IDs
driver_1_race_1121 <- my_data[my_data$raceId == 1121 & my_data$driverId == 1, ]
print(driver_1_race_1121)

driver_names <- find_driverId[, c("driverId","forename","surname")]
print(driver_names)

'pit_format <- pit_stops[pit_stops$driverId == 830 & pit_stops$raceId == 1121, ]
print(pit_format)'
# seeing maxs pit stops for Bahrain
  
# seeing max qual for bahrain
max_quali_bahrain <- qualifying[qualifying$driverId == 830 & qualifying$raceId == 1121, ]
print(max_quali_bahrain)
# shows quali times for each quarter, want to see what happens if they don't qualify
# ricciardo went out in q2, seeing his
daniel_quali_bahrain <- qualifying[qualifying$driverId == 817 & qualifying$raceId == 1121, ]
print(daniel_quali_bahrain)
# if value is null \\N is presented

# seeing organization of results
results_org <- results[results$raceId == 1121, ]
print(results_org)

# all drivers and Ids
sink(NULL)
options(max.print = 10000)
sink("driver_names.txt")  
print(driver_names)          
sink() 

# results for gasly @ saudi, he DNF'd
gasly_dnf <- results[results$raceId == 1122 & results$driverId == 842, ]
print(gasly_dnf)
# shows R in position text
max_didnt_dnf <- results[results$raceId == 1122 & results$driverId == 830, ]
print(max_didnt_dnf)

# is Spain number correct? 
spain_1130 <- results[results$raceId == 1130, ]
print(spain_1130)
# correct

# abu correct?
abu_1144 <- results[results$raceId == 1144, ]
print(abu_1144)
# correct
# updating ovetakes db

# ------------------------------------------------------------------------------

