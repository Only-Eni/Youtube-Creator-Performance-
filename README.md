# YouTube Creator Performance Analysis

An end-to-end data analytics project exploring YouTube creator distribution, audience scale, content activity, and performance patterns across countries using SQL Server and Power BI.

The project works with a dataset of **15,830 YouTube channels** and focuses on transforming raw channel-level data into meaningful analytical insights while accounting for missing data, uneven country representation, and extreme values.

---

## 📊 Dashboard

![YouTube Creator Performance Dashboard](Youtube-Creator-Performance-/powerbi/screenshots/youtube_performance.png)

The dashboard was developed in Power BI using an analytical SQL view containing the cleaned dataset and derived performance metrics.

---

## 🎯 Project Objective

The objective of this project was to simulate a real-world analytics workflow for understanding YouTube creator performance.

Rather than relying on a single metric, the analysis looks at several dimensions of creator performance:

- Creator distribution by country
- Subscriber and view distribution
- Average creator performance
- Content production activity
- Channel age
- Relationships between subscribers, views, and videos
- Outliers and extreme observations
- Missing country information

The project also demonstrates how data quality and sample size can affect analytical conclusions.

---

## ❓ Business Questions

The analysis explores questions including:

1. Which countries have the largest creator representation in the dataset?
2. How are channels, subscribers, and views distributed across countries?
3. Does having more creators necessarily correspond to higher average creator performance?
4. Which channels have the highest subscriber, view, and video counts?
5. How does channel age relate to publishing activity?
6. What relationships exist between:
   - Subscribers and views?
   - Subscribers and videos?
   - Views and videos?
7. How much variation exists across creator metrics?
8. Which observations qualify as statistical outliers?
9. How significant is missing country information?

---

# 🗂️ Dataset

The dataset contains **15,830 YouTube channels** and 12 original fields.

### Original fields

| Field | Description |
|---|---|
| `channel_id` | Channel identifier |
| `channel_name` | Channel name |
| `view_count` | Total channel views |
| `category` | Channel category |
| `country` | Country code |
| `default_language` | Channel default language |
| `subscriber_count` | Subscriber count |
| `created_date` | Channel creation date |
| `description` | Channel description |
| `custom_url` | Channel custom URL |
| `thumbnail` | Channel thumbnail |
| `video_count` | Number of videos |

A country reference table was also used to convert country codes into readable country names.

---

# 🧹 Data Quality

The dataset was audited before analysis.

### Missing values

| Field | Missing records |
|---|---:|
| `channel_id` | 0 |
| `channel_name` | 0 |
| `subscriber_count` | 2 |
| `description` | 901 |
| `custom_url` | 22 |
| `country` | 1,800 |
| `default_language` | 14,105 |

### Duplicate checks

| Field | Duplicate records |
|---|---:|
| `channel_id` | 0 |
| `channel_name` | 48 |
| `custom_url` | 3 |
| `thumbnail` | 378 |

Duplicate channel names were not automatically treated as duplicate channels because different channels can have the same name.

`channel_id` was therefore treated as the channel-level identifier for uniqueness checks.

---

# 🌍 Country Mapping

Country codes were mapped to readable country names using a reference table.

Examples:

```text
US → United States
IN → India
GB → United Kingdom
CA → Canada
AU → Australia
NG → Nigeria
