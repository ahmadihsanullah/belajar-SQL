-- Demonstrates subqueries
-- Uses longlist.db

-- Finds all books published by MacLehose Press, with hard-coded id
SELECT "id" FROM "publishers" WHERE "publisher" = 'MacLehose Press';

SELECT "title" FROM "books" WHERE "publisher_id" = 12;

-- Finds all books published by MacLehose Press, with a nested query
SELECT "title" FROM "books" WHERE "publisher_id" = (
    SELECT "id" FROM "publishers" WHERE "publisher" = 'MacLehose Press'
);

-- Finds all ratings for "In Memory of Memory"
SELECT "rating" FROM "ratings" WHERE "book_id" = (
    SELECT "id" FROM "books" WHERE "title" = 'In Memory of Memory'
);

-- Finds average rating for "In Memory of Memory"
SELECT ROUND(AVG("rating"),2) FROM "ratings" WHERE "book_id" = (
    SELECT "id" FROM "books" WHERE "title" = 'In Memory of Memory'
);

-------------- Masuk Ke MANY TO MANY-------------------

-- Finds author who wrote "The Birthday Party"
SELECT "id" FROM "books" WHERE "title" = 'The Birthday Party';

-- temukan id penulis
SELECT "author_id" FROM "authored" WHERE "book_id" = (
    SELECT "id" FROM "books" WHERE "title" = 'The Birthday Party'
);

--temukan nama dari penulis
SELECT "name" FROM "authors" WHERE "id" = (
    SELECT "author_id" FROM "authored" WHERE "book_id" = (
        SELECT "id" FROM "books" WHERE "title" = 'The Birthday Party'
    )
);

-- 1. cari id buku
SELECT "id" FROM "books" WHERE "title" = 'Is Mother Dead'; -- => 6
-- 2. cari id penulis
SELECT "author_id" FROM authored WHERE book_id = (
    SELECT "id" FROM "books" WHERE "title" = 'Is Mother Dead' -- => 66
);
-- cari nama penulis dari id penulis
SELECT name FROM authors WHERE id =(
    SELECT "author_id" FROM authored WHERE book_id = (
        SELECT "id" FROM "books" WHERE "title" = 'Is Mother Dead' -- => Vigdis Hjorth
    )
);

-- Finds all books by Fernanda Melchor, using IN
SELECT "id" FROM "authors" WHERE "name" = 'Fernanda Melchor';

SELECT "book_id" FROM "authored" WHERE "author_id" = (
    SELECT "id" FROM "authors" WHERE "name" = 'Fernanda Melchor'
);

SELECT "title" FROM "books" WHERE "id" IN (
    SELECT "book_id" FROM "authored" WHERE "author_id" = (
        SELECT "id" FROM "authors" WHERE "name" = 'Fernanda Melchor'
    )
);

-- Uses IN to search for multiple authors
SELECT "title" FROM "books" WHERE "id" IN (
    SELECT "book_id" FROM "authored" WHERE "author_id" IN (
        SELECT "id" FROM "authors" WHERE "name" IN ('Fernanda Melchor', 'Annie Ernaux')
    )
);
