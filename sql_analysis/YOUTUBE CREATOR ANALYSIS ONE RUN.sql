/*====================================================================
PROJECT: GLOBAL YOUTUBE CREATOR PERFORMANCE ANALYSIS
DATABASE: YouTube_Creator_Performance_Analysis

DESCRIPTION:
This script performs data validation, enrichment, exploratory data
analysis, descriptive statistics, outlier detection, correlation
analysis, and creates analytical views for Power BI reporting.

DATA TABLES:
    1. stg_youtube_channels
    2. ref_country

ANALYTICAL OUTPUT:
    1. vw_youtube_channels
    2. vw_youtube_analytics
====================================================================*/


/*====================================================================
SECTION 1: DATABASE SETUP
====================================================================*/

USE YouTube_Creator_Performance_Analysis;
GO


/*====================================================================
SECTION 2: INITIAL DATA VALIDATION
Purpose:
- Preview imported datasets
- Confirm row counts
- Validate country reference coverage
====================================================================*/


/* Preview YouTube channel staging data */
SELECT *
FROM dbo.stg_youtube_channels;


/* Preview country reference table */
SELECT *
FROM dbo.ref_country;


/* Confirm number of imported channel records */
SELECT
    COUNT(*) AS channel_rows
FROM dbo.stg_youtube_channels;


/* Confirm number of country reference records */
SELECT
    COUNT(*) AS total_countries
FROM dbo.ref_country;


/* Identify country codes present in the channel dataset
   but missing from the reference table */
SELECT DISTINCT
    c.country AS unmatched_country_code
FROM dbo.stg_youtube_channels AS c
LEFT JOIN dbo.ref_country AS r
    ON c.country = r.country
WHERE c.country IS NOT NULL
    AND r.country IS NULL;


/*====================================================================
SECTION 3: COUNTRY REFERENCE TABLE ENRICHMENT
Purpose:
Convert country codes into readable country names.
====================================================================*/


/* Add country_name column only if it does not already exist */
IF COL_LENGTH('dbo.ref_country', 'country_name') IS NULL
BEGIN
    ALTER TABLE dbo.ref_country
    ADD country_name VARCHAR(100);
END;
GO


/* Populate country names from country codes */
UPDATE dbo.ref_country
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
        ELSE country_name
    END;
GO


/* Preview enriched country reference table */
SELECT *
FROM dbo.ref_country
ORDER BY country;


/*====================================================================
SECTION 4: DATA TYPE OPTIMIZATION
Purpose:
Prevent integer overflow during aggregation and analysis.
====================================================================*/


/* Convert large numeric metrics to BIGINT where necessary */

IF EXISTS
(
    SELECT 1
    FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.stg_youtube_channels')
        AND name = 'subscriber_count'
        AND system_type_id <> TYPE_ID('bigint')
)
BEGIN
    ALTER TABLE dbo.stg_youtube_channels
    ALTER COLUMN subscriber_count BIGINT;
END;


IF EXISTS
(
    SELECT 1
    FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.stg_youtube_channels')
        AND name = 'view_count'
        AND system_type_id <> TYPE_ID('bigint')
)
BEGIN
    ALTER TABLE dbo.stg_youtube_channels
    ALTER COLUMN view_count BIGINT;
END;


IF EXISTS
(
    SELECT 1
    FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.stg_youtube_channels')
        AND name = 'video_count'
        AND system_type_id <> TYPE_ID('bigint')
)
BEGIN
    ALTER TABLE dbo.stg_youtube_channels
    ALTER COLUMN video_count BIGINT;
END;
GO


/*====================================================================
SECTION 5: CREATE BASE ANALYTICAL VIEW
Purpose:
Combine channel data with readable country names.
====================================================================*/

CREATE OR ALTER VIEW dbo.vw_youtube_channels
AS
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
FROM dbo.stg_youtube_channels AS c
LEFT JOIN dbo.ref_country AS r
    ON c.country = r.country;
GO


/* Validate unmatched or missing country records */
SELECT
    COUNT(*) AS channels_without_country_mapping
FROM dbo.vw_youtube_channels
WHERE country_name IS NULL;


/*====================================================================
SECTION 6: COUNTRY-LEVEL EXPLORATORY DATA ANALYSIS
====================================================================*/


/* Countries with the largest creator presence */
SELECT TOP 10
    country_name,
    COUNT(*) AS channel_count
FROM dbo.vw_youtube_channels
WHERE country_name IS NOT NULL
GROUP BY country_name
ORDER BY channel_count DESC;


/* Countries ranked by total subscriber base */
SELECT TOP 10
    country_name,
    COUNT(*) AS channel_count,
    SUM(subscriber_count) AS total_subscribers,
    SUM(view_count) AS total_views
FROM dbo.vw_youtube_channels
WHERE country_name IS NOT NULL
GROUP BY country_name
ORDER BY total_subscribers DESC;


/* Countries with the highest average subscribers per channel */
SELECT TOP 10
    country_name,
    COUNT(*) AS channel_count,
    SUM(subscriber_count) AS total_subscribers,
    AVG(CAST(subscriber_count AS DECIMAL(38,2))) AS avg_subscribers
FROM dbo.vw_youtube_channels
WHERE country_name IS NOT NULL
GROUP BY country_name
ORDER BY avg_subscribers DESC;


/* Countries with the highest average views per channel */
SELECT TOP 10
    country_name,
    COUNT(*) AS channel_count,
    SUM(view_count) AS total_views,
    AVG(CAST(view_count AS DECIMAL(38,2))) AS avg_views
FROM dbo.vw_youtube_channels
WHERE country_name IS NOT NULL
GROUP BY country_name
ORDER BY avg_views DESC;


/*====================================================================
SECTION 7: COUNTRY CONTRIBUTION ANALYSIS
Purpose:
Measure each country's share of channels, subscribers and views.
====================================================================*/

WITH CountryStats AS
(
    SELECT
        country_name,
        COUNT(*) AS channel_count,
        SUM(subscriber_count) AS total_subscribers,
        SUM(view_count) AS total_views,
        AVG(CAST(subscriber_count AS DECIMAL(38,2))) AS avg_subscribers,
        AVG(CAST(view_count AS DECIMAL(38,2))) AS avg_views
    FROM dbo.vw_youtube_channels
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
        100.0 * c.channel_count
        / NULLIF(t.total_channels, 0)
        AS DECIMAL(10,2)
    ) AS channel_share_pct,

    c.total_subscribers,

    CAST(
        100.0 * c.total_subscribers
        / NULLIF(t.total_subscribers, 0)
        AS DECIMAL(10,2)
    ) AS subscriber_share_pct,

    c.total_views,

    CAST(
        100.0 * c.total_views
        / NULLIF(t.total_views, 0)
        AS DECIMAL(10,2)
    ) AS view_share_pct,

    c.avg_subscribers,
    c.avg_views

FROM CountryStats AS c
CROSS JOIN Totals AS t
ORDER BY c.channel_count DESC;


/*====================================================================
SECTION 8: MISSING COUNTRY ANALYSIS
Purpose:
Quantify records without country information.
====================================================================*/

SELECT
    COUNT(*) AS total_channels,

    SUM(
        CASE
            WHEN country_name IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_country_channels,

    CAST(
        100.0 *
        SUM(
            CASE
                WHEN country_name IS NULL THEN 1
                ELSE 0
            END
        )
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS missing_country_pct,

    SUM(
        CASE
            WHEN country_name IS NOT NULL THEN 1
            ELSE 0
        END
    ) AS known_country_channels,

    CAST(
        100.0 *
        SUM(
            CASE
                WHEN country_name IS NOT NULL THEN 1
                ELSE 0
            END
        )
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS known_country_pct

FROM dbo.vw_youtube_channels;


/*====================================================================
SECTION 9: DESCRIPTIVE STATISTICS
Purpose:
Summarize central tendency and distribution of core metrics.
====================================================================*/

SELECT
    COUNT(subscriber_count) AS subscriber_count_n,
    MIN(subscriber_count) AS subscriber_min,
    MAX(subscriber_count) AS subscriber_max,
    AVG(CAST(subscriber_count AS DECIMAL(38,2))) AS subscriber_mean,
    STDEV(CAST(subscriber_count AS FLOAT)) AS subscriber_stddev,

    COUNT(view_count) AS view_count_n,
    MIN(view_count) AS view_min,
    MAX(view_count) AS view_max,
    AVG(CAST(view_count AS DECIMAL(38,2))) AS view_mean,
    STDEV(CAST(view_count AS FLOAT)) AS view_stddev,

    COUNT(video_count) AS video_count_n,
    MIN(video_count) AS video_min,
    MAX(video_count) AS video_max,
    AVG(CAST(video_count AS DECIMAL(38,2))) AS video_mean,
    STDEV(CAST(video_count AS FLOAT)) AS video_stddev

FROM dbo.vw_youtube_channels;


/*====================================================================
SECTION 10: QUARTILE AND MEDIAN ANALYSIS
Purpose:
Evaluate distribution characteristics beyond mean values.
====================================================================*/

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

    FROM dbo.vw_youtube_channels
)

SELECT
    'Subscribers' AS metric,
    MIN(subscriber_count) AS min_value,
    MAX(subscriber_count) AS max_value,
    AVG(CAST(subscriber_count AS DECIMAL(38,2))) AS mean_value,
    STDEV(CAST(subscriber_count AS FLOAT)) AS std_dev,
    MAX(sub_q1) AS q1,
    MAX(sub_median) AS median,
    MAX(sub_q3) AS q3

FROM dbo.vw_youtube_channels
CROSS JOIN Stats
WHERE subscriber_count IS NOT NULL

UNION ALL

SELECT
    'Views',
    MIN(view_count),
    MAX(view_count),
    AVG(CAST(view_count AS DECIMAL(38,2))),
    STDEV(CAST(view_count AS FLOAT)),
    MAX(view_q1),
    MAX(view_median),
    MAX(view_q3)

FROM dbo.vw_youtube_channels
CROSS JOIN Stats
WHERE view_count IS NOT NULL

UNION ALL

SELECT
    'Videos',
    MIN(video_count),
    MAX(video_count),
    AVG(CAST(video_count AS DECIMAL(38,2))),
    STDEV(CAST(video_count AS FLOAT)),
    MAX(video_q1),
    MAX(video_median),
    MAX(video_q3)

FROM dbo.vw_youtube_channels
CROSS JOIN Stats
WHERE video_count IS NOT NULL;


/*====================================================================
SECTION 11: IQR OUTLIER ANALYSIS
Purpose:
Identify unusually large subscriber, view and video counts.

Method:
Upper outlier = Q3 + 1.5 × IQR
====================================================================*/

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

    FROM dbo.vw_youtube_channels
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
                q.sub_q3 + (1.5 * (q.sub_q3 - q.sub_q1))
            THEN 1
            ELSE 0
        END
    ) AS upper_outliers,

    COUNT(v.subscriber_count) AS valid_records,

    CAST(
        100.0 *
        SUM(
            CASE
                WHEN v.subscriber_count >
                    q.sub_q3 + (1.5 * (q.sub_q3 - q.sub_q1))
                THEN 1
                ELSE 0
            END
        )
        / NULLIF(COUNT(v.subscriber_count), 0)
        AS DECIMAL(10,2)
    ) AS outlier_percentage

FROM dbo.vw_youtube_channels AS v
CROSS JOIN Quartiles AS q
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
                q.view_q3 + (1.5 * (q.view_q3 - q.view_q1))
            THEN 1
            ELSE 0
        END
    ),

    COUNT(v.view_count),

    CAST(
        100.0 *
        SUM(
            CASE
                WHEN v.view_count >
                    q.view_q3 + (1.5 * (q.view_q3 - q.view_q1))
                THEN 1
                ELSE 0
            END
        )
        / NULLIF(COUNT(v.view_count), 0)
        AS DECIMAL(10,2)
    )

FROM dbo.vw_youtube_channels AS v
CROSS JOIN Quartiles AS q
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
                q.video_q3 + (1.5 * (q.video_q3 - q.video_q1))
            THEN 1
            ELSE 0
        END
    ),

    COUNT(v.video_count),

    CAST(
        100.0 *
        SUM(
            CASE
                WHEN v.video_count >
                    q.video_q3 + (1.5 * (q.video_q3 - q.video_q1))
                THEN 1
                ELSE 0
            END
        )
        / NULLIF(COUNT(v.video_count), 0)
        AS DECIMAL(10,2)
    )

FROM dbo.vw_youtube_channels AS v
CROSS JOIN Quartiles AS q
WHERE v.video_count IS NOT NULL;


/*====================================================================
SECTION 12: TOP CHANNEL ANALYSIS
====================================================================*/


/* Top channels by subscribers */
SELECT TOP 10
    channel_name,
    country_name,
    subscriber_count,
    view_count,
    video_count,
    created_date
FROM dbo.vw_youtube_channels
WHERE subscriber_count IS NOT NULL
ORDER BY subscriber_count DESC;


/* Top channels by total views */
SELECT TOP 10
    channel_name,
    country_name,
    subscriber_count,
    view_count,
    video_count,
    created_date
FROM dbo.vw_youtube_channels
WHERE view_count IS NOT NULL
ORDER BY view_count DESC;


/* Top channels by content volume */
SELECT TOP 10
    channel_name,
    country_name,
    subscriber_count,
    view_count,
    video_count,
    created_date
FROM dbo.vw_youtube_channels
WHERE video_count IS NOT NULL
ORDER BY video_count DESC;


/*====================================================================
SECTION 13: PEARSON CORRELATION ANALYSIS
Formula:
r = [nΣXY − (ΣX)(ΣY)]
    -----------------------------------
    √([nΣX² − (ΣX)²][nΣY² − (ΣY)²])
====================================================================*/


/* Relationship between subscribers and views */
SELECT
    COUNT(*) AS valid_channels,

    CAST(
        (
            COUNT(*) *
            SUM(
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
                    COUNT(*) *
                    SUM(
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
                    COUNT(*) *
                    SUM(
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

FROM dbo.vw_youtube_channels
WHERE subscriber_count IS NOT NULL
    AND view_count IS NOT NULL;


/* Relationship between subscribers and video count */
SELECT
    COUNT(*) AS valid_channels,

    CAST(
        (
            COUNT(*) *
            SUM(
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
                    COUNT(*) *
                    SUM(
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
                    COUNT(*) *
                    SUM(
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

FROM dbo.vw_youtube_channels
WHERE subscriber_count IS NOT NULL
    AND video_count IS NOT NULL;


/* Relationship between views and video count */
SELECT
    COUNT(*) AS valid_channels,

    CAST(
        (
            COUNT(*) *
            SUM(
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
                    COUNT(*) *
                    SUM(
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
                    COUNT(*) *
                    SUM(
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

FROM dbo.vw_youtube_channels
WHERE view_count IS NOT NULL
    AND video_count IS NOT NULL;


/*====================================================================
SECTION 14: CHANNEL PERFORMANCE METRICS
Purpose:
Derive comparable performance indicators.

Metrics:
- Views per subscriber
- Views per video
- Videos published per year
====================================================================*/

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
        /
        NULLIF(
            CAST(DATEDIFF(DAY, created_date, GETDATE()) AS FLOAT)
            / 365.25,
            0
        )
        AS videos_per_year

    FROM dbo.vw_youtube_channels
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


/*====================================================================
SECTION 15: CONTENT PRODUCTION RATE ANALYSIS
====================================================================*/

SELECT TOP 10
    channel_name,
    country_name,
    created_date,
    video_count,

    DATEDIFF(
        DAY,
        created_date,
        GETDATE()
    ) AS channel_age_days,

    CAST(
        CAST(DATEDIFF(
            DAY,
            created_date,
            GETDATE()
        ) AS FLOAT)
        / 365.25
        AS DECIMAL(12,2)
    ) AS channel_age_years,

    CAST(
        CAST(video_count AS FLOAT)
        /
        NULLIF(
            CAST(
                DATEDIFF(
                    DAY,
                    created_date,
                    GETDATE()
                ) AS FLOAT
            ) / 365.25,
            0
        )
        AS DECIMAL(18,2)
    ) AS videos_per_year

FROM dbo.vw_youtube_channels
WHERE created_date IS NOT NULL
    AND video_count IS NOT NULL
ORDER BY videos_per_year DESC;


/*====================================================================
SECTION 16: VIDEOS PER YEAR OUTLIER ANALYSIS
====================================================================*/

WITH ChannelMetrics AS
(
    SELECT
        CAST(video_count AS FLOAT)
        /
        NULLIF(
            CAST(
                DATEDIFF(
                    DAY,
                    created_date,
                    GETDATE()
                ) AS FLOAT
            ) / 365.25,
            0
        ) AS videos_per_year

    FROM dbo.vw_youtube_channels
    WHERE created_date IS NOT NULL
        AND video_count IS NOT NULL
),
Quartiles AS
(
    SELECT DISTINCT

        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY videos_per_year)
            OVER () AS q1,

        PERCENTILE_CONT(0.50)
            WITHIN GROUP (ORDER BY videos_per_year)
            OVER () AS median,

        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY videos_per_year)
            OVER () AS q3

    FROM ChannelMetrics
    WHERE videos_per_year IS NOT NULL
)

SELECT
    q1,
    median,
    q3,
    q3 - q1 AS iqr,
    q3 + 1.5 * (q3 - q1) AS upper_fence
FROM Quartiles;
GO


/*====================================================================
SECTION 17: FINAL ANALYTICAL VIEW FOR POWER BI
Purpose:
Create a reusable analytics-ready dataset containing original and
derived channel performance metrics.
====================================================================*/

CREATE OR ALTER VIEW  dbo.vw_youtube_channels
AS
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

    /* Channel age in years */
    CAST(
        CAST(
            DATEDIFF(
                DAY,
                c.created_date,
                GETDATE()
            ) AS FLOAT
        ) / 365.25
        AS DECIMAL(10,2)
    ) AS channel_age_years,

    /* Average lifetime views generated per subscriber */
    CAST(c.view_count AS FLOAT)
    / NULLIF(CAST(c.subscriber_count AS FLOAT), 0)
    AS views_per_subscriber,

    /* Average lifetime views generated per uploaded video */
    CAST(c.view_count AS FLOAT)
    / NULLIF(CAST(c.video_count AS FLOAT), 0)
    AS views_per_video,

    /* Average content production rate since channel creation */
    CAST(c.video_count AS FLOAT)
    /
    NULLIF(
        CAST(
            DATEDIFF(
                DAY,
                c.created_date,
                GETDATE()
            ) AS FLOAT
        ) / 365.25,
        0
    ) AS videos_per_year

FROM dbo.stg_youtube_channels AS c
LEFT JOIN dbo.ref_country AS r
    ON c.country = r.country;
GO


/*====================================================================
SECTION 18: FINAL VIEW VALIDATION
====================================================================*/


/* Preview analytics-ready dataset */
SELECT TOP 20 *
FROM dbo.vw_youtube_channels;


/* Confirm row count remains consistent with source dataset */
SELECT
    COUNT(*) AS analytics_view_rows
FROM dbo.vw_youtube_channels;
GO