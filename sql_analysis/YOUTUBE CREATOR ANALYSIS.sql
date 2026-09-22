USE YouTube_Creator_Performance_Analysis;

SELECT *
FROM stg_youtube_channels;

SELECT *
FROM ref_country;

/*TO CONFIRM THE NO OF IMPORTED ROWS AND COLUMNS*/
SELECT COUNT(*) as channel_rows
from stg_youtube_channels;

SELECT COUNT(*) as total_country
from ref_country;

/*TO CHECK WHETHER THERE IS A COUNTRY NOT IN THE REFRENCE TABLE*/
SELECT DISTINCT c.country
FROM stg_youtube_channels AS c
LEFT JOIN ref_country AS r
    ON c.country = r.country
WHERE c.country IS NOT NULL
  AND r.country IS NULL;

/*NOW TO CHANGE THE COUNTRY REFRENCE FROM ABBREVATIONS TO ACTUAL NAMES*/

SELECT *
FROM ref_country
ORDER BY country;

/*NOW UPDATING THE TABLE BY ADDING COLUMNS AND USING CHATGPT TO GENERATE COUNTRY MAPPINGS*/
ALTER TABLE ref_country
ADD country_name VARCHAR(100);

SELECT *
FROM ref_country;

/*CHANGING THE DATA TYPE TO AVOID ISSUES DURING ANALYSIS*/
ALTER TABLE stg_youtube_channels
ALTER COLUMN subscriber_count BIGINT;

ALTER TABLE stg_youtube_channels
ALTER COLUMN view_count BIGINT;

ALTER TABLE stg_youtube_channels
ALTER COLUMN video_count BIGINT;

UPDATE ref_country
SET country_name =
    CASE country
        WHEN 'AE' THEN 'United Arab Emirates'
        WHEN 'AF' THEN 'Afghanistan'
        WHEN 'AG' THEN 'Antigua and Barbuda'
        WHEN 'AL' THEN 'Albania'
        WHEN 'AQ' THEN 'Antarctica'
        WHEN 'AR' THEN 'Argentina'
        WHEN 'AT' THEN 'Austria'
        WHEN 'AU' THEN 'Australia'
        WHEN 'BA' THEN 'Bosnia and Herzegovina'
        WHEN 'BD' THEN 'Bangladesh'
        WHEN 'BE' THEN 'Belgium'
        WHEN 'BG' THEN 'Bulgaria'
        WHEN 'BH' THEN 'Bahrain'
        WHEN 'BM' THEN 'Bermuda'
        WHEN 'BR' THEN 'Brazil'
        WHEN 'BY' THEN 'Belarus'
        WHEN 'CA' THEN 'Canada'
        WHEN 'CH' THEN 'Switzerland'
        WHEN 'CL' THEN 'Chile'
        WHEN 'CN' THEN 'China'
        WHEN 'CO' THEN 'Colombia'
        WHEN 'CR' THEN 'Costa Rica'
        WHEN 'CX' THEN 'Christmas Island'
        WHEN 'CY' THEN 'Cyprus'
        WHEN 'CZ' THEN 'Czechia'
        WHEN 'DE' THEN 'Germany'
        WHEN 'DK' THEN 'Denmark'
        WHEN 'DO' THEN 'Dominican Republic'
        WHEN 'DZ' THEN 'Algeria'
        WHEN 'EC' THEN 'Ecuador'
        WHEN 'EE' THEN 'Estonia'
        WHEN 'EG' THEN 'Egypt'
        WHEN 'ES' THEN 'Spain'
        WHEN 'FI' THEN 'Finland'
        WHEN 'FR' THEN 'France'
        WHEN 'GB' THEN 'United Kingdom'
        WHEN 'GE' THEN 'Georgia'
        WHEN 'GH' THEN 'Ghana'
        WHEN 'GM' THEN 'Gambia'
        WHEN 'GR' THEN 'Greece'
        WHEN 'HK' THEN 'Hong Kong'
        WHEN 'HN' THEN 'Honduras'
        WHEN 'HR' THEN 'Croatia'
        WHEN 'HU' THEN 'Hungary'
        WHEN 'ID' THEN 'Indonesia'
        WHEN 'IE' THEN 'Ireland'
        WHEN 'IL' THEN 'Israel'
        WHEN 'IN' THEN 'India'
        WHEN 'IQ' THEN 'Iraq'
        WHEN 'IS' THEN 'Iceland'
        WHEN 'IT' THEN 'Italy'
        WHEN 'JM' THEN 'Jamaica'
        WHEN 'JO' THEN 'Jordan'
        WHEN 'JP' THEN 'Japan'
        WHEN 'KE' THEN 'Kenya'
        WHEN 'KH' THEN 'Cambodia'
        WHEN 'KR' THEN 'South Korea'
        WHEN 'KZ' THEN 'Kazakhstan'
        WHEN 'LA' THEN 'Laos'
        WHEN 'LB' THEN 'Lebanon'
        WHEN 'LK' THEN 'Sri Lanka'
        WHEN 'LT' THEN 'Lithuania'
        WHEN 'LU' THEN 'Luxembourg'
        WHEN 'LV' THEN 'Latvia'
        WHEN 'LY' THEN 'Libya'
        WHEN 'MA' THEN 'Morocco'
        WHEN 'MC' THEN 'Monaco'
        WHEN 'MD' THEN 'Moldova'
        WHEN 'ME' THEN 'Montenegro'
        WHEN 'MK' THEN 'North Macedonia'
        WHEN 'MT' THEN 'Malta'
        WHEN 'MX' THEN 'Mexico'
        WHEN 'MY' THEN 'Malaysia'
        WHEN 'NG' THEN 'Nigeria'
        WHEN 'NL' THEN 'Netherlands'
        WHEN 'NO' THEN 'Norway'
        WHEN 'NP' THEN 'Nepal'
        WHEN 'NZ' THEN 'New Zealand'
        WHEN 'OM' THEN 'Oman'
        WHEN 'PE' THEN 'Peru'
        WHEN 'PH' THEN 'Philippines'
        WHEN 'PK' THEN 'Pakistan'
        WHEN 'PL' THEN 'Poland'
        WHEN 'PR' THEN 'Puerto Rico'
        WHEN 'PT' THEN 'Portugal'
        WHEN 'PY' THEN 'Paraguay'
        WHEN 'QA' THEN 'Qatar'
        WHEN 'RO' THEN 'Romania'
        WHEN 'RS' THEN 'Serbia'
        WHEN 'RU' THEN 'Russia'
        WHEN 'SA' THEN 'Saudi Arabia'
        WHEN 'SE' THEN 'Sweden'
        WHEN 'SG' THEN 'Singapore'
        WHEN 'SI' THEN 'Slovenia'
        WHEN 'SK' THEN 'Slovakia'
        WHEN 'SV' THEN 'El Salvador'
        WHEN 'TH' THEN 'Thailand'
        WHEN 'TN' THEN 'Tunisia'
        WHEN 'TR' THEN 'Türkiye'
        WHEN 'TW' THEN 'Taiwan'
        WHEN 'TZ' THEN 'Tanzania'
        WHEN 'UA' THEN 'Ukraine'
        WHEN 'UG' THEN 'Uganda'
        WHEN 'UM' THEN 'United States Minor Outlying Islands'
        WHEN 'US' THEN 'United States'
        WHEN 'UY' THEN 'Uruguay'
        WHEN 'VI' THEN 'U.S. Virgin Islands'
        WHEN 'VN' THEN 'Vietnam'
        WHEN 'ZA' THEN 'South Africa'
        WHEN 'ZW' THEN 'Zimbabwe'
    END;

SELECT 
    c.channel_id,
    c.channel_name,
    c.view_count,
    r.country_name,
    c.subscriber_count
FROM stg_youtube_channels AS c
JOIN ref_country AS r
    ON c.country = r.country

/*CREATE THE ANALYTICAL VIEW FOR OUR DATA*/
CREATE VIEW vw_youtube_channels AS
SELECT
    c.channel_id,
    c.channel_name,
    c.country AS country_code,
    r.country_name,
    c.category,
    c.subscriber_count,
    c.view_count,
    c.video_count,
    c.created_date
FROM stg_youtube_channels AS c
LEFT JOIN ref_country AS r
    ON c.country = r.country;

SELECT COUNT(*)
FROM vw_youtube_channels
WHERE country_name IS NULL

/*CHECKING WHICH  COUNTRY HAS THE LARGEST CREATOR PRESENCE USING THE COUNT FUNCTION*/

SELECT TOP 10
    country_name,
    COUNT(*) AS channel_count
FROM vw_youtube_channels
WHERE country_name IS NOT NULL
GROUP BY country_name
ORDER BY channel_count DESC;


/*CHECKING THE LARGEST CREATOR USING THE COUNT ANM OF CHANNELS, SUBSCRIBERS AND VIEWS*/
SELECT TOP 10
  country_name,
  COUNT(*) AS channel_count,
  SUM(subscriber_count) AS total_subscribers,
  SUM(view_count) AS total_views
FROM dbo.vw_youtube_channels
WHERE country_name IS NOT NULL
GROUP BY country_name
ORDER BY total_subscribers DESC;


SELECT TOP 10
    country_name,
    COUNT(*) AS channel_count,
    SUM(subscriber_count) AS total_subscribers,
    AVG(CAST(subscriber_count AS DECIMAL(18,2))) AS avg_subscribers
FROM vw_youtube_channels
WHERE country_name IS NOT NULL
GROUP BY country_name
ORDER BY avg_subscribers DESC;

/*CALCULATING THE AVERAGE VIEW PER COUNT*/
SELECT TOP 10
    country_name,
    COUNT(*) AS channel_count,
    SUM(view_count) AS total_views,
    AVG(CAST(view_count AS DECIMAL(18,2))) AS avg_views
FROM vw_youtube_channels
WHERE country_name IS NOT NULL
GROUP BY country_name
ORDER BY avg_views DESC;

/*AFTER CHECKING AND NOTICING THAT COUNTRIES LIKE JORDAN AND EL SALVADOR RANKS
THE SUBSCRIBERS AND VIEWS COUNT BY 2 CHANNELS 
WHICH IS NOT ENOUGH TO MEASURE A COUNTRY'S PERFORMANCE,
I DECIDED TO SET A MINIMUM OF 10 CHANNELS USING 'HAVING'*/

SELECT
    country_name,
    COUNT(*) AS channel_count,
    SUM(subscriber_count) AS total_subscribers,
    AVG(CAST(subscriber_count AS DECIMAL(18,2))) AS avg_subscribers
FROM vw_youtube_channels
WHERE country_name IS NOT NULL
GROUP BY country_name
HAVING COUNT(*) >= 10
ORDER BY avg_subscribers DESC;

SELECT
    country_name,
    COUNT(*) AS channel_count,
    SUM(view_count) AS total_views,
    AVG(CAST(view_count AS DECIMAL(18,2))) AS avg_views
FROM vw_youtube_channels
WHERE country_name IS NOT NULL
GROUP BY country_name
HAVING COUNT(*) >= 10
ORDER BY avg_views DESC;

/*After filtering out channels less than 10,
i discovered that on 7 channels have higer gaps thereby making it unreasonable to filter the <10 channels count
and decided on using cast to determine the percentage of each country's views, subscribers and counts*/
SELECT
    country_name,
    COUNT(*) AS channel_count,

    CAST(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER ()
        AS DECIMAL(10,2)
    ) AS channel_share_pct,

    SUM(subscriber_count) AS total_subscribers,

    CAST(
        SUM(subscriber_count) * 100.0 /
        SUM(SUM(subscriber_count)) OVER ()
        AS DECIMAL(10,2)
    ) AS subscriber_share_pct,

    SUM(view_count) AS total_views,

    CAST(
        SUM(view_count) * 100.0 /
        SUM(SUM(view_count)) OVER ()
        AS DECIMAL(10,2)
    ) AS view_share_pct,

    AVG(CAST(subscriber_count AS DECIMAL(18,2))) AS avg_subscribers,

    AVG(CAST(view_count AS DECIMAL(18,2))) AS avg_views

FROM vw_youtube_channels
WHERE country_name IS NOT NULL
GROUP BY country_name
ORDER BY channel_count DESC;

/*...*/

SELECT
    COUNT(subscriber_count) AS subscriber_count_n,
    MIN(subscriber_count) AS subscriber_min,
    MAX(subscriber_count) AS subscriber_max,
    AVG(CAST(subscriber_count AS DECIMAL(38,2))) AS subscriber_mean,
    STDEV(CAST(subscriber_count AS DECIMAL(38,2))) AS subscriber_stddev,

    COUNT(view_count) AS view_count_n,
    MIN(view_count) AS view_min,
    MAX(view_count) AS view_max,
    AVG(CAST(view_count AS DECIMAL(38,2))) AS view_mean,
    STDEV(CAST(view_count AS DECIMAL(38,2))) AS view_stddev,

    COUNT(video_count) AS video_count_n,
    MIN(video_count) AS video_min,
    MAX(video_count) AS video_max,
    AVG(CAST(video_count AS DECIMAL(38,2))) AS video_mean,
    STDEV(CAST(video_count AS DECIMAL(38,2))) AS video_stddev
FROM vw_youtube_channels;

/*...*/

WITH Stats AS
(
    SELECT DISTINCT
        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY subscriber_count)
            OVER () AS sub_q1,
        PERCENTILE_CONT(0.50)
            WITHIN GROUP (ORDER BY subscriber_count)
            OVER () AS sub_median,
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY subscriber_count)
            OVER () AS sub_q3,

        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY view_count)
            OVER () AS view_q1,
        PERCENTILE_CONT(0.50)
            WITHIN GROUP (ORDER BY view_count)
            OVER () AS view_median,
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY view_count)
            OVER () AS view_q3,

        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY video_count)
            OVER () AS video_q1,
        PERCENTILE_CONT(0.50)
            WITHIN GROUP (ORDER BY video_count)
            OVER () AS video_median,
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY video_count)
            OVER () AS video_q3

    FROM vw_youtube_channels
)
SELECT
    'Subscribers' AS metric,
    MIN(subscriber_count) AS min_value,
    MAX(subscriber_count) AS max_value,
    AVG(CAST(subscriber_count AS DECIMAL(38,2))) AS mean_value,
    STDEV(CAST(subscriber_count AS DECIMAL(38,2))) AS std_dev,
    MAX(sub_q1) AS q1,
    MAX(sub_median) AS median,
    MAX(sub_q3) AS q3
FROM vw_youtube_channels
CROSS JOIN Stats
WHERE subscriber_count IS NOT NULL

UNION ALL

SELECT
    'Views',
    MIN(view_count),
    MAX(view_count),
    AVG(CAST(view_count AS DECIMAL(38,2))),
    STDEV(CAST(view_count AS DECIMAL(38,2))),
    MAX(view_q1),
    MAX(view_median),
    MAX(view_q3)
FROM vw_youtube_channels
CROSS JOIN Stats
WHERE view_count IS NOT NULL

UNION ALL

SELECT
    'Videos',
    MIN(video_count),
    MAX(video_count),
    AVG(CAST(video_count AS DECIMAL(38,2))),
    STDEV(CAST(video_count AS DECIMAL(38,2))),
    MAX(video_q1),
    MAX(video_median),
    MAX(video_q3)
FROM vw_youtube_channels
CROSS JOIN Stats
WHERE video_count IS NOT NULL;

/*...*/

WITH Quartiles AS
(
    SELECT DISTINCT
        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY subscriber_count)
            OVER () AS sub_q1,
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY subscriber_count)
            OVER () AS sub_q3,

        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY view_count)
            OVER () AS view_q1,
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY view_count)
            OVER () AS view_q3,

        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY video_count)
            OVER () AS video_q1,
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY video_count)
            OVER () AS video_q3
    FROM vw_youtube_channels
)

SELECT
    'Subscribers' AS metric,
    MAX(sub_q1) AS q1,
    MAX(sub_q3) AS q3,
    MAX(sub_q3 - sub_q1) AS iqr,
    MAX(sub_q3 + (1.5 * (sub_q3 - sub_q1))) AS upper_fence,
    SUM(
        CASE
            WHEN v.subscriber_count >
                 (q.sub_q3 + (1.5 * (q.sub_q3 - q.sub_q1)))
            THEN 1 ELSE 0
        END
    ) AS upper_outliers,
    COUNT(v.subscriber_count) AS valid_records,
    CAST(
        100.0 *
        SUM(
            CASE
                WHEN v.subscriber_count >
                     (q.sub_q3 + (1.5 * (q.sub_q3 - q.sub_q1)))
                THEN 1 ELSE 0
            END
        )
        / COUNT(v.subscriber_count)
        AS DECIMAL(10,2)
    ) AS outlier_percentage
FROM vw_youtube_channels v
CROSS JOIN Quartiles q
WHERE v.subscriber_count IS NOT NULL

UNION ALL

SELECT
    'Views',
    MAX(view_q1),
    MAX(view_q3),
    MAX(view_q3 - view_q1),
    MAX(view_q3 + (1.5 * (view_q3 - view_q1))),
    SUM(
        CASE
            WHEN v.view_count >
                 (q.view_q3 + (1.5 * (q.view_q3 - q.view_q1)))
            THEN 1 ELSE 0
        END
    ),
    COUNT(v.view_count),
    CAST(
        100.0 *
        SUM(
            CASE
                WHEN v.view_count >
                     (q.view_q3 + (1.5 * (q.view_q3 - q.view_q1)))
                THEN 1 ELSE 0
            END
        )
        / COUNT(v.view_count)
        AS DECIMAL(10,2)
    )
FROM vw_youtube_channels v
CROSS JOIN Quartiles q
WHERE v.view_count IS NOT NULL

UNION ALL

SELECT
    'Videos',
    MAX(video_q1),
    MAX(video_q3),
    MAX(video_q3 - video_q1),
    MAX(video_q3 + (1.5 * (video_q3 - video_q1))),
    SUM(
        CASE
            WHEN v.video_count >
                 (q.video_q3 + (1.5 * (q.video_q3 - q.video_q1)))
            THEN 1 ELSE 0
        END
    ),
    COUNT(v.video_count),
    CAST(
        100.0 *
        SUM(
            CASE
                WHEN v.video_count >
                     (q.video_q3 + (1.5 * (q.video_q3 - q.video_q1)))
            THEN 1 ELSE 0
            END
        )
        / COUNT(v.video_count)
        AS DECIMAL(10,2)
    )
FROM vw_youtube_channels v
CROSS JOIN Quartiles q
WHERE v.video_count IS NOT NULL;

/**/

WITH CountryStats AS
(
    SELECT
        country_name,
        COUNT(*) AS channel_count,
        SUM(subscriber_count) AS total_subscribers,
        SUM(view_count) AS total_views,
        AVG(CAST(subscriber_count AS DECIMAL(38,2))) AS avg_subscribers,
        AVG(CAST(view_count AS DECIMAL(38,2))) AS avg_views
    FROM vw_youtube_channels
    WHERE country_name IS NOT NULL
    GROUP BY country_name
),
Totals AS
(
    SELECT
        SUM(channel_count) AS total_channels,
        SUM(total_subscribers) AS total_subscribers,
        SUM(total_views) AS total_views
    FROM CountryStats
)
SELECT
    c.country_name,
    c.channel_count,
    CAST(
        100.0 * c.channel_count / t.total_channels
        AS DECIMAL(10,2)
    ) AS channel_share_pct,

    c.total_subscribers,
    CAST(
        100.0 * c.total_subscribers / t.total_subscribers
        AS DECIMAL(10,2)
    ) AS subscriber_share_pct,

    c.total_views,
    CAST(
        100.0 * c.total_views / t.total_views
        AS DECIMAL(10,2)
    ) AS view_share_pct,

    c.avg_subscribers,
    c.avg_views

FROM CountryStats c
CROSS JOIN Totals t
ORDER BY c.channel_count DESC;

/**/

SELECT
  COUNT(*) AS total_channels,
  SUM(CASE WHEN country_name IS NULL THEN 1 ELSE 0 END) AS missing_country_channels,
  CAST(
    100.0 * SUM(CASE WHEN country_name IS NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0)
    AS DECIMAL(10,2)
  ) AS missing_country_pct,
  SUM(CASE WHEN country_name IS NOT NULL THEN 1 ELSE 0 END) AS known_country_channels,
  CAST(
    100.0 * SUM(CASE WHEN country_name IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0)
    AS DECIMAL(10,2)
  ) AS known_country_pct
FROM dbo.vw_youtube_channels;
/**/
SELECT TOP 10
    channel_name,
    country_name,
    subscriber_count,
    view_count,
    video_count,
    created_date
FROM vw_youtube_channels
WHERE subscriber_count IS NOT NULL
ORDER BY subscriber_count DESC;
/**/
SELECT TOP 10
    channel_name,
    country_name,
    subscriber_count,
    view_count,
    video_count,
    created_date
FROM vw_youtube_channels
WHERE view_count IS NOT NULL
ORDER BY view_count DESC;

/**/
SELECT TOP 10
    channel_name,
    country_name,
    subscriber_count,
    view_count,
    video_count,
    created_date
FROM vw_youtube_channels
WHERE video_count IS NOT NULL
ORDER BY video_count DESC;

/**/
SELECT
    COUNT(*) AS valid_channels,
    CORR(subscriber_count, view_count) AS subscriber_view_correlation
FROM vw_youtube_channels
WHERE subscriber_count IS NOT NULL
  AND view_count IS NOT NULL;

  /*running pearson correlation manually because sql does not have a built in function 
  r=(n∑X2−(∑X)2)(n∑Y2−(∑Y)2)n∑XY−∑X∑Y​. Also casting "decimal" and "float" function because the subscribers and 
  views count are up to billions */
  /*subscribers count and view count correlation*/
SELECT
    COUNT(*) AS valid_channels,

    CAST(
        (
            COUNT(*) * SUM(
                CAST(subscriber_count AS FLOAT) *
                CAST(view_count AS FLOAT)
            )
            -
            SUM(CAST(subscriber_count AS FLOAT)) *
            SUM(CAST(view_count AS FLOAT))
        )
        /
        NULLIF(
            SQRT(
                (
                    COUNT(*) * SUM(
                        CAST(subscriber_count AS FLOAT) *
                        CAST(subscriber_count AS FLOAT)
                    )
                    -
                    POWER(
                        SUM(CAST(subscriber_count AS FLOAT)),
                        2
                    )
                )
                *
                (
                    COUNT(*) * SUM(
                        CAST(view_count AS FLOAT) *
                        CAST(view_count AS FLOAT)
                    )
                    -
                    POWER(
                        SUM(CAST(view_count AS FLOAT)),
                        2
                    )
                )
            ),
            0
        )
        AS DECIMAL(10,4)
    ) AS subscriber_view_correlation

FROM vw_youtube_channels
WHERE subscriber_count IS NOT NULL
  AND view_count IS NOT NULL;

/*relationship between subscriber count and video count*/
SELECT
    COUNT(*) AS valid_channels,

    CAST(
        (
            COUNT(*) * SUM(
                CAST(subscriber_count AS FLOAT) *
                CAST(video_count AS FLOAT)
            )
            -
            SUM(CAST(subscriber_count AS FLOAT)) *
            SUM(CAST(video_count AS FLOAT))
        )
        /
        NULLIF(
            SQRT(
                (
                    COUNT(*) * SUM(
                        CAST(subscriber_count AS FLOAT) *
                        CAST(subscriber_count AS FLOAT)
                    )
                    -
                    POWER(
                        SUM(CAST(subscriber_count AS FLOAT)),
                        2
                    )
                )
                *
                (
                    COUNT(*) * SUM(
                        CAST(video_count AS FLOAT) *
                        CAST(video_count AS FLOAT)
                    )
                    -
                    POWER(
                        SUM(CAST(video_count AS FLOAT)),
                        2
                    )
                )
            ),
            0
        )
        AS DECIMAL(10,4)
    ) AS subscriber_video_correlation

FROM vw_youtube_channels
WHERE subscriber_count IS NOT NULL
  AND video_count IS NOT NULL;

  /*views count and videos count correlation*/
  SELECT
    COUNT(*) AS valid_channels,

    CAST(
        (
            COUNT(*) * SUM(
                CAST(view_count AS FLOAT) *
                CAST(video_count AS FLOAT)
            )
            -
            SUM(CAST(view_count AS FLOAT)) *
            SUM(CAST(video_count AS FLOAT))
        )
        /
        NULLIF(
            SQRT(
                (
                    COUNT(*) * SUM(
                        CAST(view_count AS FLOAT) *
                        CAST(view_count AS FLOAT)
                    )
                    -
                    POWER(
                        SUM(CAST(view_count AS FLOAT)),
                        2
                    )
                )
                *
                (
                    COUNT(*) * SUM(
                        CAST(video_count AS FLOAT) *
                        CAST(video_count AS FLOAT)
                    )
                    -
                    POWER(
                        SUM(CAST(video_count AS FLOAT)),
                        2
                    )
                )
            ),
            0
        )
        AS DECIMAL(10,4)
    ) AS view_video_correlation

FROM vw_youtube_channels
WHERE view_count IS NOT NULL
  AND video_count IS NOT NULL;

  /*now the relationships */

  WITH ChannelMetrics AS
(
    SELECT
        channel_name,
        country_name,
        subscriber_count,
        view_count,
        video_count,
        created_date,

        CAST(view_count AS FLOAT)
            / NULLIF(CAST(subscriber_count AS FLOAT), 0)
            AS views_per_subscriber,

        CAST(view_count AS FLOAT)
            / NULLIF(CAST(video_count AS FLOAT), 0)
            AS views_per_video,

        CAST(video_count AS FLOAT)
            / NULLIF(
                DATEDIFF(DAY, created_date, GETDATE()) / 365.25,
                0
            )
            AS videos_per_year

    FROM vw_youtube_channels
    WHERE created_date IS NOT NULL
)
SELECT
    COUNT(*) AS channels,

    AVG(views_per_subscriber) AS avg_views_per_subscriber,
    AVG(views_per_video) AS avg_views_per_video,
    AVG(videos_per_year) AS avg_videos_per_year,

    MIN(views_per_subscriber) AS min_views_per_subscriber,
    MAX(views_per_subscriber) AS max_views_per_subscriber,

    MIN(views_per_video) AS min_views_per_video,
    MAX(views_per_video) AS max_views_per_video,

    MIN(videos_per_year) AS min_videos_per_year,
    MAX(videos_per_year) AS max_videos_per_year

FROM ChannelMetrics;

DATEDIFF(DAY, created_date, GETDATE()) / 365.25

SELECT *
from vw_youtube_channels;

SELECT TOP 10
    channel_name,
    country_name,
    created_date,
    video_count,

    DATEDIFF(DAY, created_date, GETDATE()) AS channel_age_days,

    CAST(
        DATEDIFF(DAY, created_date, GETDATE()) / 365.25
        AS DECIMAL(12,2)
    ) AS channel_age_years,

    CAST(
        CAST(video_count AS FLOAT)
        /
        NULLIF(
            DATEDIFF(DAY, created_date, GETDATE()) / 365.25,
            0
        )
        AS DECIMAL(18,2)
    ) AS videos_per_year

FROM vw_youtube_channels
WHERE created_date IS NOT NULL
  AND video_count IS NOT NULL
ORDER BY videos_per_year DESC;

/**/

WITH ChannelMetrics AS
(
    SELECT
        CAST(video_count AS FLOAT)
        /
        NULLIF(
            DATEDIFF(DAY, created_date, GETDATE()) / 365.25,
            0
        ) AS videos_per_year
    FROM vw_youtube_channels
    WHERE created_date IS NOT NULL
      AND video_count IS NOT NULL
),
Quartiles AS
(
    SELECT DISTINCT
        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY videos_per_year)
            OVER () AS Q1,

        PERCENTILE_CONT(0.50)
            WITHIN GROUP (ORDER BY videos_per_year)
            OVER () AS Median,

        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY videos_per_year)
            OVER () AS Q3
    FROM ChannelMetrics
)
SELECT
    Q1,
    Median,
    Q3,
    Q3 - Q1 AS IQR,
    Q3 + 1.5 * (Q3 - Q1) AS Upper_Fence
FROM Quartiles;

/**/

WITH ChannelMetrics AS (
    SELECT
        channel_id,
        channel_name,
        country_code,
        country_name,
        created_date,
        video_count,
        DATEDIFF(DAY, created_date, GETDATE()) / 365.25 AS channel_age_years,
        CAST(video_count AS FLOAT) /
            NULLIF(DATEDIFF(DAY, created_date, GETDATE()) / 365.25, 0)
            AS videos_per_year
    FROM vw_youtube_channels
    WHERE created_date IS NOT NULL
),
Quartiles AS (
    SELECT
        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY videos_per_year)
            OVER () AS Q1,
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY videos_per_year)
            OVER () AS Q3
    FROM ChannelMetrics
    WHERE videos_per_year IS NOT NULL
),
Fences AS (
    SELECT DISTINCT
        Q1,
        Q3,
        Q3 - Q1 AS IQR,
        Q3 + 1.5 * (Q3 - Q1) AS Upper_Fence
    FROM Quartiles
),
OutlierSummary AS (
    SELECT
        COUNT(*) AS Valid_Records,
        SUM(
            CASE
                WHEN cm.videos_per_year > f.Upper_Fence THEN 1
                ELSE 0
            END
        ) AS Upper_Outliers,
        f.Q1,
        f.Q3,
        f.IQR,
        f.Upper_Fence
    FROM ChannelMetrics cm
    CROSS JOIN Fences f
    WHERE cm.videos_per_year IS NOT NULL
    GROUP BY
        f.Q1,
        f.Q3,
        f.IQR,
        f.Upper_Fence
)
SELECT
    Valid_Records,
    Upper_Outliers,
    CAST(Upper_Outliers * 100.0 / Valid_Records AS DECIMAL(10,2))
        AS Outlier_Percentage,
    Q1,
    Q3,
    IQR,
    Upper_Fence
FROM OutlierSummary;

/*views*/

WITH ChannelMetrics AS (
    SELECT
        channel_id,
        channel_name,
        country_code,
        country_name,
        subscriber_count,
        view_count,
        CAST(view_count AS FLOAT) /
            NULLIF(subscriber_count, 0) AS views_per_subscriber
    FROM vw_youtube_channels
),
Quartiles AS (
    SELECT
        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY views_per_subscriber)
            OVER () AS Q1,
        PERCENTILE_CONT(0.50)
            WITHIN GROUP (ORDER BY views_per_subscriber)
            OVER () AS Median,
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY views_per_subscriber)
            OVER () AS Q3
    FROM ChannelMetrics
    WHERE views_per_subscriber IS NOT NULL
),
Fences AS (
    SELECT DISTINCT
        Q1,
        Median,
        Q3,
        Q3 - Q1 AS IQR,
        Q3 + 1.5 * (Q3 - Q1) AS Upper_Fence
    FROM Quartiles
),
OutlierSummary AS (
    SELECT
        COUNT(*) AS Valid_Records,
        SUM(
            CASE
                WHEN cm.views_per_subscriber > f.Upper_Fence
                THEN 1
                ELSE 0
            END
        ) AS Upper_Outliers,
        f.Q1,
        f.Median,
        f.Q3,
        f.IQR,
        f.Upper_Fence
    FROM ChannelMetrics cm
    CROSS JOIN Fences f
    WHERE cm.views_per_subscriber IS NOT NULL
    GROUP BY
        f.Q1,
        f.Median,
        f.Q3,
        f.IQR,
        f.Upper_Fence
)
SELECT
    Valid_Records,
    Upper_Outliers,
    CAST(Upper_Outliers * 100.0 / Valid_Records AS DECIMAL(10,2))
        AS Outlier_Percentage,
    Q1,
    Median,
    Q3,
    IQR,
    Upper_Fence
FROM OutlierSummary;

/*videos*/

WITH ChannelMetrics AS (
    SELECT
        channel_id,
        channel_name,
        country_code,
        country_name,
        video_count,
        view_count,
        CAST(view_count AS FLOAT) /
            NULLIF(video_count, 0) AS views_per_video
    FROM vw_youtube_channels
),
Quartiles AS (
    SELECT
        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY views_per_video)
            OVER () AS Q1,
        PERCENTILE_CONT(0.50)
            WITHIN GROUP (ORDER BY views_per_video)
            OVER () AS Median,
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY views_per_video)
            OVER () AS Q3
    FROM ChannelMetrics
    WHERE views_per_video IS NOT NULL
),
Fences AS (
    SELECT DISTINCT
        Q1,
        Median,
        Q3,
        Q3 - Q1 AS IQR,
        Q3 + 1.5 * (Q3 - Q1) AS Upper_Fence
    FROM Quartiles
),
OutlierSummary AS (
    SELECT
        COUNT(*) AS Valid_Records,
        SUM(
            CASE
                WHEN cm.views_per_video > f.Upper_Fence
                THEN 1
                ELSE 0
            END
        ) AS Upper_Outliers,
        f.Q1,
        f.Median,
        f.Q3,
        f.IQR,
        f.Upper_Fence
    FROM ChannelMetrics cm
    CROSS JOIN Fences f
    WHERE cm.views_per_video IS NOT NULL
    GROUP BY
        f.Q1,
        f.Median,
        f.Q3,
        f.IQR,
        f.Upper_Fence
)
SELECT
    Valid_Records,
    Upper_Outliers,
    CAST(Upper_Outliers * 100.0 / Valid_Records AS DECIMAL(10,2))
        AS Outlier_Percentage,
    Q1,
    Median,
    Q3,
    IQR,
    Upper_Fence
FROM OutlierSummary;

CREATE OR ALTER VIEW vw_youtube_analytics AS
SELECT
    c.channel_id,
    c.channel_name,
    c.country AS country_code,
    r.country_name,
    c.category,
    c.subscriber_count,
    c.view_count,
    c.video_count,
    c.created_date,

    -- Channel age in years
    CAST(
        DATEDIFF(DAY, c.created_date, GETDATE()) / 365.25
        AS DECIMAL(10,2)
    ) AS channel_age_years,

    -- Derived metrics
    CAST(c.view_count AS DECIMAL(38,4))
        / NULLIF(c.subscriber_count, 0)
        AS views_per_subscriber,

    CAST(c.view_count AS DECIMAL(38,4))
        / NULLIF(c.video_count, 0)
        AS views_per_video,

    CAST(c.video_count AS DECIMAL(38,4))
        / NULLIF(
            DATEDIFF(DAY, c.created_date, GETDATE()) / 365.25,
            0
        )
        AS videos_per_year

FROM stg_youtube_channels AS c
LEFT JOIN ref_country AS r
    ON c.country = r.country;
GO

USE YouTube_Creator_Performance_Analysis;
SELECT TOP 20 *
FROM vw_youtube_channels;