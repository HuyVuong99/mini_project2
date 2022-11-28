create table match
(
    id             serial,
    match_number   integer,
    round_number   integer,
    date_time      text,
    location_match text,
    home_team      text,
    away_team      text,
    group_match    text,
    result         text default ''::text,
    goal           text default '-'::text
);

alter table match
    owner to postgres;

INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (29, 29, 2, '28/11/2022 17:00', 'Al Janoub Stadium', 'Cameroon', 'Serbia', 'Group G', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (30, 30, 2, '28/11/2022 20:00', 'Education City Stadium', 'Korea Republic', 'Ghana', 'Group H', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (31, 31, 2, '28/11/2022 23:00', 'Stadium 974', 'Brazil', 'Switzerland', 'Group G', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (32, 32, 2, '29/11/2022 02:00', 'Lusail Stadium', 'Portugal', 'Uruguay', 'Group H', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (33, 35, 3, '29/11/2022 22:00', 'Khalifa International Stadium', 'Ecuador', 'Senegal', 'Group A', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (34, 36, 3, '29/11/2022 22:00', 'Al Bayt Stadium', 'Netherlands', 'Qatar', 'Group A', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (35, 33, 3, '30/11/2022 02:00', 'Ahmad Bin Ali Stadium', 'Wales', 'England', 'Group B', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (36, 34, 3, '30/11/2022 02:00', 'Al Thumama Stadium', 'Iran', 'USA', 'Group B', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (37, 37, 3, '30/11/2022 22:00', 'Al Janoub Stadium', 'Australia', 'Denmark', 'Group D', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (39, 39, 3, '01/12/2022 02:00', 'Stadium 974', 'Poland', 'Argentina', 'Group C', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (40, 40, 3, '01/12/2022 02:00', 'Lusail Stadium', 'Saudi Arabia', 'Mexico', 'Group C', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (41, 41, 3, '01/12/2022 22:00', 'Ahmad Bin Ali Stadium', 'Croatia', 'Belgium', 'Group F', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (42, 42, 3, '01/12/2022 22:00', 'Al Thumama Stadium', 'Canada', 'Morocco', 'Group F', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (43, 43, 3, '02/12/2022 02:00', 'Khalifa International Stadium', 'Japan', 'Spain', 'Group E', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (44, 44, 3, '02/12/2022 02:00', 'Al Bayt Stadium', 'Costa Rica', 'Germany', 'Group E', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (45, 45, 3, '02/12/2022 22:00', 'Al Janoub Stadium', 'Ghana', 'Uruguay', 'Group H', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (46, 46, 3, '02/12/2022 22:00', 'Education City Stadium', 'Korea Republic', 'Portugal', 'Group H', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (47, 47, 3, '03/12/2022 02:00', 'Stadium 974', 'Serbia', 'Switzerland', 'Group G', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (48, 48, 3, '03/12/2022 02:00', 'Lusail Stadium', 'Cameroon', 'Brazil', 'Group G', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (8, 5, 1, '23/11/2022 02:00', 'Al Janoub Stadium', 'France', 'Australia', 'Group D', 'W', '4-1');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (9, 12, 1, '23/11/2022 17:00', 'Al Bayt Stadium', 'Morocco', 'Croatia', 'Group F', 'D', '0-0');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (10, 11, 1, '23/11/2022 20:00', 'Khalifa International Stadium', 'Germany', 'Japan', 'Group E', 'L', '1-2');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (11, 10, 1, '23/11/2022 23:00', 'Al Thumama Stadium', 'Spain', 'Costa Rica', 'Group E', 'W', '7-0');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (12, 9, 1, '24/11/2022 02:00', 'Ahmad Bin Ali Stadium', 'Belgium', 'Canada', 'Group F', 'W', '1-0');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (13, 13, 1, '24/11/2022 17:00', 'Al Janoub Stadium', 'Switzerland', 'Cameroon', 'Group G', 'W', '1-0');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (27, 27, 2, '27/11/2022 23:00', 'Khalifa International Stadium', 'Croatia', 'Canada', 'Group F', 'W', '3-1');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (14, 14, 1, '24/11/2022 20:00', 'Education City Stadium', 'Uruguay', 'Korea Republic', 'Group H', 'D', '0-0');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (15, 15, 1, '24/11/2022 23:00', 'Stadium 974', 'Portugal', 'Ghana', 'Group H', 'W', '3-2');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (16, 16, 1, '25/11/2022 02:00', 'Lusail Stadium', 'Brazil', 'Serbia', 'Group G', 'W', '2-0');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (17, 17, 2, '25/11/2022 17:00', 'Ahmad Bin Ali Stadium', 'Wales', 'Iran', 'Group B', 'L', '0-2');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (18, 18, 2, '25/11/2022 20:00', 'Al Thumama Stadium', 'Qatar', 'Senegal', 'Group A', 'L', '1-3');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (28, 28, 2, '28/11/2022 02:00', 'Al Bayt Stadium', 'Spain', 'Germany', 'Group E', 'D', '1-1');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (19, 19, 2, '25/11/2022 23:00', 'Khalifa International Stadium', 'Netherlands', 'Ecuador', 'Group A', 'D', '1-1');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (20, 20, 2, '26/11/2022 02:00', 'Al Bayt Stadium', 'England', 'USA', 'Group B', 'D', '0-0');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (21, 21, 2, '26/11/2022 17:00', 'Al Janoub Stadium', 'Tunisia', 'Australia', 'Group D', 'L', '0-1');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (22, 22, 2, '26/11/2022 20:00', 'Education City Stadium', 'Poland', 'Saudi Arabia', 'Group C', 'W', '2-0');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (38, 38, 3, '30/11/2022 22:00', 'Education City Stadium', 'Tunisia', 'France', 'Group D', '', '-');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (23, 23, 2, '26/11/2022 23:00', 'Stadium 974', 'France', 'Denmark', 'Group D', 'W', '2-1');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (1, 1, 1, '20/11/2022 23:00', 'Al Bayt Stadium', 'Qatar', 'Ecuador', 'Group A', 'L', '0-2');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (2, 3, 1, '21/11/2022 20:00', 'Khalifa International Stadium', 'England', 'Iran', 'Group B', 'W', '6-2');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (3, 2, 1, '21/11/2022 23:00', 'Al Thumama Stadium', 'Senegal', 'Netherlands', 'Group A', 'L', '0-2');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (25, 25, 2, '27/11/2022 17:00', 'Ahmad Bin Ali Stadium', 'Japan', 'Costa Rica', 'Group E', 'L', '0-1');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (4, 4, 1, '22/11/2022 02:00', 'Ahmad Bin Ali Stadium', 'USA', 'Wales', 'Group B', 'D', '1-1');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (5, 8, 1, '22/11/2022 17:00', 'Lusail Stadium', 'Argentina', 'Saudi Arabia', 'Group C', 'L', '1-2');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (24, 24, 2, '27/11/2022 02:00', 'Lusail Stadium', 'Argentina', 'Mexico', 'Group C', 'W', '2-0');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (26, 26, 2, '27/11/2022 20:00', 'Al Thumama Stadium', 'Belgium', 'Morocco', 'Group F', 'L', '0-2');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (6, 6, 1, '22/11/2022 20:00', 'Education City Stadium', 'Denmark', 'Tunisia', 'Group D', 'D', '0-0');
INSERT INTO public.match (id, match_number, round_number, date_time, location_match, home_team, away_team, group_match, result, goal) VALUES (7, 7, 1, '22/11/2022 23:00', 'Stadium 974', 'Mexico', 'Poland', 'Group C', 'D', '0-0');
