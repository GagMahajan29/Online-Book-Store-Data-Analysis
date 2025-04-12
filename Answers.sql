create database OBS_Project;

select * from Books
select * from Customers
select * from Orders

-- 1) Retrieve all books in the "Fiction" genre:

select Book_ID,Title from Books where Genre='Fiction' --60 books are having the genre "Fiction"

-- 2) Find books published after the year 1950:

select Book_ID,Title,Published_Year from Books where Published_Year > 1950 --292 books

-- 3) List all customers from Canada:

select Customer_ID,Name from Customers where Country='Canada'

-- 4) Show orders placed in November 2023:

select * from Orders where MONTH(Order_Date)=11 and Year(Order_Date)=2023  --25 orders

-- 5) Retrieve the total stock of books available:

select Sum(Stock) [Total Stock] from Books   --25056

-- 6) Find the details of the most expensive book:

select * from Books where Price=(Select MAX(Price) from Books)

-- 7) Show all customers who ordered more than 1 quantity of a book:

select Customer_ID from Orders where Quantity>1 

-- 8) Retrieve all orders where the total amount exceeds $20:

select * from Orders where Total_Amount>20


-- 9) List all genres available in the Books table:

select Distinct Genre from Books

-- 10) Find the book with the lowest stock:

select * from Books where Stock=(select MIN(Stock) from Books)

-- 11) Calculate the total revenue generated from all orders:

select SUM(Total_Amount) [Total Revenue] from Orders    --75628.66


-- 12) Retrieve the total number of books sold for each genre:

select Genre,SUM(Quantity) [Quantity sold for each genre] 
from Books b JOIN Orders o on b.Book_ID=o.Book_ID
Group by Genre

-- 13) Find the average price of books in the "Fantasy" genre:

select AVG(Price) [Avg price for fantasy genre] from Books where Genre='Fantasy'  --25.98

-- 14) List customers who have placed at least 2 orders:

select Name,COUNT(Order_ID) [No. of orders]
from Customers c Join Orders o on c.Customer_ID=o.Customer_ID
group by Name
having COUNT(Order_ID)>=2

-- 15) Find the most frequently ordered book:

select top 1 b.Book_ID,Title,Count(Order_ID) [Frequency]
from Books b join Orders o on b.Book_ID=o.Book_ID
Group by b.Book_ID,Title
order by count(Order_ID) desc 

-- 16) Show the top 3 most expensive books of the 'Fantasy' Genre :

select top 3 Book_ID,Title,Price from Books
order by Price desc

-- 17) Retrieve the total quantity of books sold by each author:

select Author,SUM(Quantity) [Books sold by each author]
from Books b join Orders o on b.Book_ID=o.Book_ID 
group by Author
order by SUM(Quantity) desc

-- 18) List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30

-- 19) Find the customer who spent the most on orders:

SELECT top 1 c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc

-- 20) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ,b.Title,b.Stock
ORDER BY b.book_id