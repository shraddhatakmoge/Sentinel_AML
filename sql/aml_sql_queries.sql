-- =========================================
-- PHASE 1: DATASET PROFILING
-- =========================================

-- Query 1: Total transactions
SELECT COUNT(*) AS total_transactions
FROM transactions;


-- Query 2: Total accounts
SELECT COUNT(*) AS total_accounts
FROM accounts;


-- Query 3: Unique banks
SELECT COUNT(DISTINCT bank_id) AS total_banks
FROM accounts;


-- Query 4: Laundering distribution
SELECT
    is_laundering,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY is_laundering;


-- Query 5: Laundering percentage
SELECT
    ROUND(SUM(is_laundering) * 100.0 / COUNT(*), 4) AS laundering_rate
FROM transactions;


-- Query 6: Number of unique active dates
SELECT
    COUNT(DISTINCT DATE(timestamp)) AS total_dates
FROM transactions;


-- Query 7: Daily transaction volume
SELECT
    DATE(timestamp) AS txn_date,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY DATE(timestamp)
ORDER BY txn_date;


-- Query 8: Top 3 busiest transaction days
SELECT
    DATE(timestamp) AS txn_date,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY DATE(timestamp)
ORDER BY transaction_count DESC
LIMIT 3;


-- Query 9: Transaction count by payment format
SELECT
    payment_format,
    COUNT(*) AS txn_count_per_payment_format
FROM transactions
GROUP BY payment_format
ORDER BY txn_count_per_payment_format DESC;


-- Query 10: Top 5 banks by number of accounts
SELECT
    bank_name,
    bank_id,
    COUNT(*) AS total_accounts
FROM accounts
GROUP BY bank_name, bank_id
ORDER BY total_accounts DESC
LIMIT 5;


-- =========================================
-- PHASE 2: BASIC BEHAVIORAL ANALYSIS
-- =========================================

-- Query 11: Top 5 sender accounts by transaction count
SELECT
    from_account,
    COUNT(*) AS txn_count
FROM transactions
GROUP BY from_account
ORDER BY txn_count DESC
LIMIT 5;


-- Query 12: Top 5 sender accounts by total amount sent
SELECT
    from_account,
    SUM(amount_paid) AS total_amount_sent
FROM transactions
GROUP BY from_account
ORDER BY total_amount_sent DESC
LIMIT 5;


-- Query 13: Same-bank vs Cross-bank transactions
SELECT
    CASE
        WHEN from_bank = to_bank THEN 'Same Bank'
        ELSE 'Cross Bank'
    END AS transaction_type,
    COUNT(*) AS txn_count
FROM transactions
GROUP BY
    CASE
        WHEN from_bank = to_bank THEN 'Same Bank'
        ELSE 'Cross Bank'
    END;


select amount_paid, high_value_transactions from (
select amount_paid,
	case 
		when amount_paid>1000000 then 'high value'
		else 'low value'
	end as high_value_transactions
from transactions
) t where high_value_transactions='high value' order by amount_paid desc ;


SELECT COUNT(*) AS high_value_transactions
FROM transactions
WHERE amount_paid > 1000000;

SELECT COUNT(*) AS high_value_suspicious_transactions
FROM transactions
WHERE amount_paid > 1000000 and is_laundering=1;


select payment_format ,  total_txn ,  laundering_txn , laundering_rate from (
select payment_format, count(*) as total_txn , sum(is_laundering) as laundering_txn , 
round((sum(is_laundering)*100.0)/count(*),4) as laundering_rate from transactions
group by payment_format
)t ;


select receiving_currency , 
	sum(is_laundering) as laundering_txn 
from transactions group by receiving_currency;


select to_account , count(*) as total_txn from transactions where is_laundering=1 
group by to_account order by total_txn desc;


select from_account , count(distinct to_account) as unique_receivers
from transactions group by from_account ;


SELECT 
    to_account,
    COUNT(DISTINCT from_account) AS unique_senders
FROM transactions
GROUP BY to_account
ORDER BY unique_senders DESC
LIMIT 5;


SELECT
    from_account,
    DATE(timestamp) AS txn_date,
    COUNT(*) AS txn_count
FROM transactions
GROUP BY from_account, DATE(timestamp)
HAVING COUNT(*) > 20
ORDER BY txn_count DESC;


select a.account_number , count(distinct t.from_account) as sending_acc , count(distinct t.to_account) as receiving_acc
from accounts a 
join transactions t 
on a.account_number = t.from_account
group by a.account_number;


WITH fan_in AS (
    SELECT
        to_account AS account,
        COUNT(DISTINCT from_account) AS unique_senders
    FROM transactions
    GROUP BY to_account
),
fan_out AS (
    SELECT
        from_account AS account,
        COUNT(DISTINCT to_account) AS unique_receivers
    FROM transactions
    GROUP BY from_account
)
SELECT
    fi.account,
    fi.unique_senders,
    fo.unique_receivers
FROM fan_in fi
JOIN fan_out fo
    ON fi.account = fo.account
ORDER BY 
    fi.unique_senders DESC,
    fo.unique_receivers DESC;


SELECT
    from_account,
    COUNT(*) AS suspicious_near_threshold_txns
FROM transactions
WHERE amount_paid BETWEEN 900000 AND 999999
GROUP BY from_account
HAVING COUNT(*) > 10
ORDER BY suspicious_near_threshold_txns DESC;



SELECT
    from_account,
    COUNT(*) AS round_amount_txn_count
FROM transactions
WHERE amount_paid % 100000 = 0
GROUP BY from_account
HAVING COUNT(*) > 10
ORDER BY round_amount_txn_count DESC;



select transaction_id , receiving_currency , payment_currency from 
(
select transaction_id , receiving_currency , payment_currency,
	case 
		when receiving_currency != payment_currency then 'sus'
		else 'non-sus'
	end as suspicious_acc
from transactions
)t
where suspicious_acc = 'sus';


SELECT COUNT(*) AS mismatched_currency_txns
FROM transactions
WHERE receiving_currency != payment_currency;

SELECT
    from_bank,
    to_bank,
    COUNT(*) AS laundering_txn
FROM transactions
WHERE is_laundering = 1
  AND from_bank != to_bank
GROUP BY from_bank, to_bank
ORDER BY laundering_txn DESC;



select count(*) as total_self_txn from transactions where from_account=to_account;

select count(*) as total_self_txn from transactions where from_account=to_account and is_laundering=1;

select to_account , count(*) as total_laundering_txn from transactions where is_laundering=1 
group by to_account having count(*)>5;


select from_account , to_account , count(*) as total_laundering_txn from transactions
where is_laundering=1
group by  from_account , to_account
order by total_laundering_txn desc
limit 5;


select to_account , sum(amount_received) as total_amount_received 
from transactions
where is_laundering=1 
group by to_account
order by total_amount_received desc;


SELECT
    ROUND(AVG(amount_paid), 2) AS avg_laundering_amount
FROM transactions
WHERE is_laundering = 1;


select from_account , amount_paid , top_3_rank from
(
select from_account  ,amount_paid, rank() over(partition by from_account order by amount_paid desc) as top_3_rank 
from transactions
)t
where top_3_rank <=3;

SELECT
    from_account,
    transaction_id,
    timestamp,
    amount_paid,
    SUM(amount_paid) OVER (
        PARTITION BY from_account
        ORDER BY timestamp, transaction_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM transactions;


select from_account , amount_paid ,
lag(amount_paid) over(partition by from_account order by timestamp , transaction_id) as previous_transaction ,
amount_paid - lag(amount_paid) over(partition by from_account order by timestamp , transaction_id) as difference_previous_current
from transactions;


WITH increase AS
(
    SELECT
        from_account,
        current_amount,
        previous_amount,
        current_amount >= previous_amount * 10 AS increase_factor
    FROM
    (
        SELECT
            from_account,
            amount_paid AS current_amount,
            LAG(amount_paid) OVER
            (
                PARTITION BY from_account
                ORDER BY timestamp, transaction_id
            ) AS previous_amount
        FROM transactions
    ) t
)

SELECT *
FROM increase
WHERE previous_amount IS NOT NULL
AND increase_factor >= 10;


SELECT
    from_account,
    COUNT(*) AS total_laundering_count
FROM transactions
WHERE is_laundering = 1
GROUP BY from_account
HAVING COUNT(*) >= 3
ORDER BY total_laundering_count DESC;






















	