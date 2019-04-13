--  -- Practice joins

-- Get all invoices where the unit_price on the invoice_line is greater than $0.99.

select * from invoice
join invoice_line 
on invoice_line.invoice_id = invoice.invoice_id
where invoice_line.unit_price > 0.99;

-- Get the invoice_date, customer first_name and last_name, and total from all invoices.

select invoice.invoice_date, customer.first_name, customer.last_name, invoice.total 
from invoice
join customer 
on invoice.customer_id = customer.customer_id;

-- Get the customer first_name and last_name and the support rep's first_name and last_name from all customers.
-- Support reps are on the employee table.

select customer.first_name, customer.last_name, employee.first_name, employee.last_name
from customer
join employee
on customer.support_rep_id = employee_id;


-- Get the album title and the artist name from all albums.

select album.title, artist.name
from album
join artist
on album.artist_id = artist.artist_id;

-- Get all playlist_track track_ids where the playlist name is Music.

select playlist_track.track_id
from playlist_track
join playlist
on playlist.playlist_id = playlist_track.playlist_id
where playlist.name = 'Music';

-- Get all track names for playlist_id 5.

select track.name
from track
join playlist_track
on playlist_track_id = track.track_id
where playlist_track_id = 5;

-- Get all track names and the playlist name that they're on ( 2 joins ).

select track.name, playlist.name
from track
join playlist_track
on track.track_id = playlist_track_id
join playlist
on playlist_track.playlist_id = playlist.playlist_id;

-- Get all track names and album titles that are the genre Alternative & Punk ( 2 joins ).

select track.name, album.title
from track
join album
on track.album_id = album.album_id
join genre 
on genre.genre_id = track.genre_id
where genre.name = 'Alternative & Punk';

-- -- Practice nested queries

-- Get all invoices where the unit_price on the invoice_line is greater than $0.99.

select *
from invoice
where invoice_id 
in ( select invoice_id from invoice_line where unit_price > 0.99 );


-- Get all playlist tracks where the playlist name is Music.

select *
from playlist_track
where playlist_id in ( select playlist_id from playlist where name = 'Music' );


-- Get all track names for playlist_id 5.

select name
from track
where track_id in ( select track_id from playlist_track where playlist_id = 5 );


-- Get all tracks where the genre is Comedy.

select *
from track
where genre_id in ( select genre_id from genre where name = 'Comedy' );


-- Get all tracks where the album is Fireball.

select *
from track
where album_id in ( select album_id from album where title = 'Fireball' );

-- Get all tracks for the artist Queen ( 2 nested subqueries ).

select *
from track
where album_id in ( 
  select album_id from album where artist_id in ( 
    select artist_id from artist where name = 'Queen'
  )
); 


-- -- Practice updating Rows

-- Find all customers with fax numbers and set those numbers to null.
update customer
set fax=null where fax is not null;

-- Find all customers with no company (null) and set their company to "Self"
update customer
set company='self' where company is null;

-- Find the customer Julia Barnett and change her last name to Thompson
update customer 
set last_name="Thompson" 
where first_name="Julia" and last_name="Barnett";

-- Find the customer with this email luisrojas@yahoo.cl and change his support rep to 4.
update customer 
set support_rep_id=4 where email="luisrojas@yahoo.cl"

-- Find all tracks that are the genre Metal and have no composer. Set the composer to "The darkness around us".
update track
set composer="The darkness around us"
where genre_id=(select genre_id from genre where name="Metal")
and composer is null;


-- -- Group by

-- Find a count of how many tracks there are per genre. Display the genre name with the count.
select count(*), g.Name
from track t
join genre g 
on t.genre_id = g.genre_id
group by g.name;

-- Find a count of how many tracks are the "Pop" genre and how many tracks are the "Rock" genre.
select count(*), g.name
track t
join genre g
on g.genr_id = t.genre_id
where g.name='Pop' or g.name='Rock'
group by g.name;

-- Find a list of all artists and how many albums they have
select ar.name, count(*)
from artist ar
join album al
on ar.artist_Id = al.artist_id
group by ar.name;


-- -- Use Distinct

-- From the track table find a unique list of all composers
select distinct composer
from track;


-- From the invoice table find a unique list of all billing_postal_codes
select distinct billing_postal_code
from invoice;


-- From the customer table find a unique list of all companys
select distinct company
from customer;


-- -- Delete Rows

-- Delete all 'bronze' entries from the table.
delete from practice_delete
where type = "Bronze";

-- Delete all 'silver' entries from the table.
delete from practice_delete
where type = "Silver";

-- Delete all entries whose value is equal to 150.
delete from practice_delete
where value = 150;

