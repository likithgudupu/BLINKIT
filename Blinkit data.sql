describe blinkit_db.blinkit_data;
show columns from blinkit_db.blinkit_data;
ALTER TABLE blinkit_db.blinkit_data
RENAME COLUMN `ï»¿Item Fat Content` TO `Item Fat Content`;
select * from blinkit_db.blinkit_data;
ALTER TABLE blinkit_db.blinkit_data
CHANGE COLUMN `Item Fat Content` `Item Fat Content` VARCHAR(100);

ALTER TABLE blinkit_db.blinkit_data
CHANGE COLUMN `Item Identifier` `Item Identifier` VARCHAR(100);


ALTER TABLE blinkit_db.blinkit_data
CHANGE COLUMN `Outlet Identifier` `Outlet Identifier` VARCHAR(100);

ALTER TABLE blinkit_db.blinkit_data
CHANGE COLUMN `Outlet Location Type` `Outlet Location Type` VARCHAR(100);

ALTER TABLE blinkit_db.blinkit_data
CHANGE COLUMN `Outlet Type` `Outlet Type` VARCHAR(100);

ALTER TABLE blinkit_db.blinkit_data
CHANGE COLUMN `Item Visibility` `Item Visibility` float;

ALTER TABLE blinkit_db.blinkit_data
CHANGE COLUMN `Item Weight` `Item Weight` float;

ALTER TABLE blinkit_db.blinkit_data
CHANGE COLUMN `Total Sales` `Total Sales` float;

ALTER TABLE blinkit_db.blinkit_data
CHANGE COLUMN `Rating` `Rating` float;



/* Data Cleaning*/

UPDATE blinkit_db.blinkit_data
SET `Item Fat Content` = 
    CASE 
        WHEN `Item Fat Content` IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN `Item Fat Content` = 'reg' THEN 'Regular'
        ELSE `Item Fat Content`
    END;

SET SQL_SAFE_UPDATES = 1;


select distinct `Item Fat Content` from blinkit_db.blinkit_data;
select * from blinkit_db.blinkit_data;

/* 1. find the sum of sales of different items of fat content   */
select `Item Fat Content`,cast(sum(`Total Sales`) as decimal(10,2)) as `Total_Sales` from blinkit_db.blinkit_data 
group by `Item Fat Content` 
order by `Total_Sales` desc;

/* 2. find the sum of sales of different item type   */

select `Item Type`,cast(sum(`Total Sales`) as decimal(10,2)) as `Total_Sales`,
		cast(avg(`Total Sales`) as decimal(10,2)) as `Average_Sales`from blinkit_db.blinkit_data 
group by `Item Type` 
order by `Total_Sales` desc;


/*  3. top 5 items based on the rating  */
select `Item Type`,cast(sum(`Total Sales`) as decimal(10,2)) as `Total_Sales`,
		cast(avg(`Total Sales`) as decimal(10,2)) as `Average_Sales`,
        cast(avg(`Rating`) as decimal(10,2)) as `Rating_sales`from blinkit_db.blinkit_data 
group by `Item Type`   
order by `Rating_sales` desc 
limit 5; 

/* 4. Fat Content by Outlet for Total Sales  */

SELECT 
    `Outlet Location Type` AS `Outlet_Location_Type`,
    CAST(SUM(CASE WHEN `Item Fat Content` = 'Low Fat' THEN `Total Sales` ELSE 0 END) AS DECIMAL(10,2)) AS `Low_Fat`,
    CAST(SUM(CASE WHEN `Item Fat Content` = 'Regular' THEN `Total Sales` ELSE 0 END) AS DECIMAL(10,2)) AS `Regular`
FROM blinkit_db.blinkit_data
GROUP BY `Outlet_Location_Type`
ORDER BY `Outlet_Location_Type`;

/* 5. Total Sales by Outlet Establishment  */
select distinct(`OUtlet Establishment Year`) as `year`,cast(sum(`Total Sales`) as decimal(10,2)) as `Total_sales`from blinkit_db.blinkit_data
group by `year`
order by `year`desc;

/* 6. Percentage of Sales by Outlet Size  */

select distinct(`Outlet Size`) as `Outlet`, cast((sum(`Total Sales`) *100 / sum(sum(`Total Sales`))  over())as decimal(10,2))  as `Total_sales`
FROM blinkit_db.blinkit_data
group by `Outlet`
order by `Total_sales` desc;

/* 7. Sales by Outlet Location  */
select distinct(`Outlet Location Type`) as `Outlet`, cast(sum(`Total Sales`) as decimal(10,2))  as `Total_sales`
FROM blinkit_db.blinkit_data
group by `Outlet`
order by `Total_sales` desc;

/*  8. All Metrics by Outlet Type  */
SELECT `Outlet Type` as `Outlet_Type`, 
CAST(SUM(`Total Sales`) AS DECIMAL(10,2)) AS `Total_Sales`,
		CAST(AVG(`Total Sales`) AS DECIMAL(10,0)) AS `Avg_Sales`,
		COUNT(*) AS `No_Of_Items`,
		CAST(AVG(`Rating`) AS DECIMAL(10,2)) AS `Avg_Rating`,
		CAST(AVG(`Item Visibility`) AS DECIMAL(10,2)) AS `Item_Visibility`
FROM blinkit_db.blinkit_data
GROUP BY `Outlet_Type`
ORDER BY `Total_Sales` DESC;