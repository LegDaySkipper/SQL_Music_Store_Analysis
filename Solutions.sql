/*	Question Set 1 - Easy */

/* Q1: Who is the senior most employee based on job title? */

select employee_id, first_name, last_name, title, levels from employee
order by levels desc
limit 1

/* Q2: Which countries have the most Invoices? */

select count(invoice_id) as total_invoice, billing_country from invoice
group by billing_country
order by total_invoice desc

/* Q3: What are top 3 values of total invoice? */

select total 
from invoice
order by total desc

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we 
made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

select billing_city, ROUND(SUM(total)::numeric, 2) as invoice_total from invoice
group by billing_city
order by invoice_total desc
limit 1
select * from invoice

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

select customer.customer_id, first_name, last_name, ROUND(sum(invoice.total)::numeric,2) as total_spent from customer
join invoice
	on customer.customer_id = invoice.customer_id
group by customer.customer_id
order by total_spent desc
limit 1

/* Question Set 2 - Moderate */

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

select distinct first_name, last_name, email, genre.name as genre_name from customer
join invoice 
	on customer.customer_id = invoice.customer_id
join invoice_line 
	on invoice.invoice_id = invoice_line.invoice_id
join track
	on invoice_line.track_id = track.track_id
join genre
	on track.genre_id = genre.genre_id
where genre.name = 'Rock'
order by email;

/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

select artist.name, count(genre.genre_id) as total_tracks from artist
join album
	on artist.artist_id = album.artist_id
join track
	on album.album_id = track.album_id
join genre
	on track.genre_id = genre.genre_id
where genre.name = 'Rock'
group by artist.name
order by total_tracks desc
limit 10

/* Q3: Return all the track names that have a song length longer than the 
average song length. Return the Name and Milliseconds for each track. Order by the song 
length with the longest songs listed first. */

select name, milliseconds,(select avg(milliseconds) from track) as average_length from track
where milliseconds > (
	select avg(milliseconds) as avg_track_length
	from track )
order by milliseconds desc

/* Question Set 3 - Advance */

/* Q1: Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent */

select first_name, last_name, artist.name, sum(invoice_line.unit_price*invoice_line.quantity) as total_spent from customer
join invoice 
	on customer.customer_id = invoice.customer_id
join invoice_line 
	on invoice.invoice_id = invoice_line.invoice_id
join track
	on invoice_line.track_id = track.track_id
join album
	on track.album_id = album.album_id
join artist
	on album.artist_id = artist.artist_id
group by customer.first_name,customer.last_name, artist.name
order by total_spent desc

/* Q2: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres. */
/* Steps to Solve:  There are two parts in question- first most popular music genre and second need data at country level. */

with popular_genre as 
(
    select count(invoice_line.quantity) as purchases, customer.country, genre.name, genre.genre_id, 
	row_number() over(partition by customer.country order by count(invoice_line.quantity) desc) as RowNo 
    from invoice_line 
	join invoice on invoice.invoice_id = invoice_line.invoice_id
	join customer on customer.customer_id = invoice.customer_id
	join track on track.track_id = invoice_line.track_id
	join genre on genre.genre_id = track.genre_id
	group 2,3,4
	order 2 asc, 1 desc
)
select * from popular_genre where RowNo <= 1

/* Q3: Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */

/* Steps to Solve:  Similar to the above question. There are two parts in question- 
first find the most spent on music for each country and second filter the data for respective customers. */

WITH Customter_with_country AS (
		SELECT customer.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending,
	    ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS RowNo 
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY 1,2,3,4
		ORDER BY 4 ASC,5 DESC)
SELECT * FROM Customter_with_country WHERE RowNo <= 1