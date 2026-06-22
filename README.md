# Catalyst Supply Chain Analytics Engine (Modern Data Stack)

A data platform built on **Google Cloud BigQuery**, **dbt**, and **Docker**, designed to analyze supply chain order delivery lead times, procurement cost leakages, and real-time stock price correlations.

---

## 🏗️ Data Platform Architecture

The architecture enforces strict data separation and follows the Modern Data Stack (MDS) multi-layer paradigm:

```text
[ Raw Sources ] ──> [ Staging Layer (Views) ] ──> [ Core Warehouse (Seeds) ] ──> [ Data Marts (Tables) ]
(CSV Seeds /        (Type Casting & Cleansing)     (Static Dimensions)           (Business Metrics /
 Kafka Feeds)                                                                     Surrogate Keys)