# 🎵 Music Store Data Analysis

> SQL project analyzing a 9-table relational music store database to uncover insights on customer behavior, genre popularity, artist performance, and revenue patterns across countries.

---

## 📌 Overview

This project uses structured SQL queries to answer real business questions for a digital music store. The analysis spans 3 difficulty levels — from basic aggregations to advanced CTEs and window functions — across a fully normalized relational database.

---

## 🗃️ Database Schema

![Music Store Schema](MusicDatabaseSchema.png)

**9 Tables:**

| Table | Description |
|---|---|
| `artist` | Artist names |
| `album` | Albums linked to artists |
| `track` | Individual tracks with genre, length, price |
| `genre` | Music genres |
| `media_type` | Format of the track (MP3, AAC etc.) |
| `playlist` / `playlist_track` | Playlists and their tracks |
| `customer` | Customer details and location |
| `invoice` / `invoice_line` | Purchase transactions and line items |
| `employee` | Store staff and hierarchy |

---

## 🛠️ Tools Used

| Tool | Purpose |
|---|---|
| PostgreSQL | Database and query execution |
| pgAdmin | SQL client |
| Git & GitHub | Version control |

---

## ❓ Business Questions Solved

### 🟢 Set 1 — Easy
| # | Question |
|---|---|
| 1 | Who is the most senior employee based on job title? |
| 2 | Which countries have the most invoices? |
| 3 | What are the top 3 highest invoice values? |
| 4 | Which city generates the most revenue? (For Music Festival planning) |
| 5 | Who is the best customer by total spend? |

### 🟡 Set 2 — Moderate
| # | Question |
|---|---|
| 1 | Return email, name & genre of all Rock music listeners (alphabetical) |
| 2 | Top 10 rock artists by track count |
| 3 | All tracks longer than average song length, ordered by duration |

### 🔴 Set 3 — Advanced
| # | Question |
|---|---|
| 1 | Amount spent by each customer on each artist (6-table join) |
| 2 | Most popular genre per country using CTE + ROW_NUMBER() |
| 3 | Top spending customer per country with tie-handling using CTE + ROW_NUMBER() |

---

## 🔍 Key SQL Techniques Used

- **Multi-table JOINs** — up to 6 tables joined in a single query
- **CTEs** (Common Table Expressions) — for modular, readable advanced queries
- **Window Functions** — `ROW_NUMBER() OVER(PARTITION BY ...)` for country-level rankings
- **Subqueries** — for filtering against aggregated values (e.g. above-average track length)
- **Aggregations** — `SUM`, `COUNT`, `AVG`, `ROUND` across grouped dimensions
- **Tie handling** — returning all records when top values are shared across countries

---

## 📈 Key Findings

- **USA dominates invoices** — highest number of transactions across all billing countries
- **Prague generates the highest city-level revenue** — ideal location for a promotional Music Festival
- **Rock is the most purchased genre** — present across the majority of countries analyzed
- **Led Zeppelin, U2, and Deep Purple** are the top 3 rock artists by track count in the dataset
- **R&B/Soul and Latin genres** emerge as top genres in specific non-English speaking markets
- Top spending customers identified per country — enabling targeted loyalty campaigns

---

## 📁 Repository Structure

```
music-store-analysis/
│
├── Solutions.sql                  # All 11 queries with comments
├── Music_Store_Analysis.pdf       # Question set document
├── MusicDatabaseSchema.png        # Entity relationship diagram
└── README.md
```

---

## ▶️ How to Run

### Prerequisites
- PostgreSQL installed
- pgAdmin or any PostgreSQL client
- Music store database loaded

### Steps

```sql
-- 1. Load the database
-- Import Music_Store_database.sql into your PostgreSQL instance via pgAdmin
-- File → Restore or run via psql:

psql -U postgres -f Music_Store_database.sql

-- 2. Open Solutions.sql in pgAdmin
-- Run each query individually to see results
```
