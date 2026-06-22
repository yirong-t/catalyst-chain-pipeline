# Catalyst Supply Chain Analytics Engine (Modern Data Stack)

A data platform built on **Google Cloud BigQuery**, **dbt**, and **Docker**, designed to analyze supply chain order delivery lead times, procurement cost leakages, and real-time stock price correlations.

---

## 🏗️ Data Platform Architecture

The architecture enforces strict data separation and follows the Modern Data Stack (MDS) multi-layer paradigm:

```mermaid
graph LR
    %% Define Global Professional Palette Styles
    classDef source fill:#F44336,stroke:#333,stroke-width:2px,color:#fff;
    classDef staging fill:#2196F3,stroke:#333,stroke-width:2px,color:#fff;
    classDef seed fill:#FF9800,stroke:#333,stroke-width:2px,color:#fff;
    classDef mart fill:#4CAF50,stroke:#333,stroke-width:2px,color:#fff;

    %% Data Platform Architecture Subgraphs
    subgraph Raw_Ingestion [Raw Ingestion Layer]
        A[(CSV Reference Seeds)]
        B[Kafka Real-time Feeds]
    end

    C[Staging Layer<br/>stg_models<br/>Materialization: View]
    D[(Warehouse Core<br/>dim_supplier_tickers<br/>Static Dimension)]
    E[Data Marts Layer<br/>mart_supply_chain_impact<br/>Materialization: Table]

    %% Data Lineage & Directed Edges
    A --> C
    B --> C
    C --> E
    D --> E

    %% Enforce Color-Coded Schema
    class A,B source;
    class C staging;
    class D seed;
    class E mart;