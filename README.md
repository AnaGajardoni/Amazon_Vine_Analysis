# Amazon_Vine_Analysis
Spark - Google Colab - AWS

## Overview
Amazon Vine Program is a service that allows manufacturers and publishers to receive reviews for their products. Companies pay a small fee to Amazon and provide products to Amazon Vine members, who are then required to publish a review. The main goal is to analyse whether there is any bias toward favorable reviews from Vine members, thus making questionable the credibility of the reviews.

In this challenge, we are to pick one dataset from Amazon Vine Program (Cameras), extract its data and convert it into dataframes using PySpark, then into tables in a relational database (Postgresql) so we can easily examine the results.

## Results
The format of the dataset used as input is as follows:

![initial_df](/resources/initial_df.png)

Using Spark, the information was broken down into four different dataframes, that were later converted to tables:

Customers dataframe:

![customers_df](/resources/customers_df.png)

Products dataframe:

![products_df](/resources/products_df.png)

Reviews dataframe:

![review_id_df](/resources/review_id_df.png)

Vine dataframe:

![vine_df](/resources/vine_df.png)

After the tables were imported in PostgreSQL, using pgAdmin to query, we got the following:

Customers table

![customers_table](/resources/customers_table.png)

Products table

![products_table](/resources/products_table.png)

Reviews table

![review_id_table](/resources/review_id_table.png)

Vine table

![vine_table](/resources/vine_table.png)

After converting the data into a more manageable state (= tables!), it was easy to answer the posed questions through simple SQL statements - the module suggested creating lots of tables, which were created, but actually there was no need. All queries were simple enough to use just run against the original *vine_table*

Intermediary tables:

- Vine20Plus - filtering vine_table with reviews that had 20 votes or more

- Helpful50Plus - filtering Vine20Plus with reviews that had at least 50% of the reviews voted as helpful

- ReviewVineProgram - filtering Helpful50Plus with reviews that were in Vine Program

- ReviewNotVineProgram - filtering Helpful50Plus with reviews that were ***not*** in Vine Program

The structure of all the above tables were the same as the original (vine_table), just the content varied according to the filters applied.

Finally, we get to answer the questions:

**How many Vine reviews and non-Vine reviews were there?**

There were 7,883 Vine Reviews and 1,794,089 Non Vine Reviews. Considering our filter (more than 20 reviews being at least 50% voted as helpful), we came to 23 Vine Reviews as opposed to 7696 Non Vine Reviews. That means 0.29% of the Vine Reviews passed our filter as opposed to 0.42% in the Non Vine group.

**How many Vine reviews were 5 stars? How many non-Vine reviews were 5 stars?**

After querying vine_table, we got

|Rating|Vine | Total   |
|------|-----|---------|
| 1    | "N" | 170014  |
| 1    | "Y" | 143     |
| 2    | "N" | 90592   |
| 2    | "Y" | 357     |
| 3    | "N" | 140321  |
| 3    | "Y" | 1139    |
| 4    | "N" | 333749  |
| 4    | "Y" | 2951    |
| 5    | "N" | 1059413 |
| 5    | "Y" | 3293    |

There were 1,062,706 5-star reviews, 3,293 being Vine Reviews representing 0.31% of the total.

**What percentage of Vine reviews were 5 stars? What percentage of non-Vine reviews were 5 stars?**

There were 1,801,974 reviews, 5-star reviews represented 58.97% of the total, which was a high number. However, from this total, the majority was from Non Vine reviews - they represented 58.79% of the total.

## Summary
The numbers clearly show that there is no bias in this dataset (or else the Vine reviews would be much better if compared to the Non Vine ones).
As an extra analysis, I would recommend breaking the query per product instead of simply review rating and checking what products actually had best reviews. For example, what products make to in this subset of 5-star reviews? How about the ones who make it, how many helpful votes are there?
