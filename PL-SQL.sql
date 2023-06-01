--PL/SQL variable declaration and print value
set serveroutput on
declare
book_id book.category_id%type;
cat library.category%type;
begin
select category_id into book_id from book where book_id=1;
select category into cat from library where category_id=(select category_id from book where book_id=1);
dbms_output.put_line('category-id-'||book_id||'  category-name-'||cat);
end; 
/



--Insert and set default value

declare 
cat_id library.category_id%type:=100;
cat library.category%type:='abc';
self library.self_no%type:=1;
r library.row_no%type:=2;

begin
insert into library values(cat_id,cat,self,r);
end;
/



--rowtype
declare
rowt library%rowtype;
begin
select * into rowt from library where category_id=1;
dbms_output.put_line(rowt.category_id||' '||rowt.category||' '||rowt.self_no||' '||rowt.row_no);
end;
/



--take category_id as input and print the book_id under the category
declare
 cat_id book.category_id%type;
 id book.book_id%type;
x number(3):=&s;
cursor cid(cat book.category_id%type) is
select book_id,category_id from book where category_id=cat;
 begin

open cid(x);
loop
fetch cid into id,cat_id;
exit when cid%RowCount>10 or cid%NotFound;
dbms_output.put_line(id||' '||cat_id);
end loop;
close cid;
end;
/



--Array

DECLARE
  a  library.category%type;
  b  library.category_id%type;
  TYPE namearray IS VARRAY(10) OF VARCHAR(20);
  TYPE idarray IS VARRAY(10) OF INTEGER;
  catnam namearray := namearray();
  catid idarray := idarray();
begin
  for i in 1..catnam.COUNT
  loop
    select category, category_id INTO a, b FROM library WHERE category_id = i;
    catnam(i) := a;
    catid(i) := b;
  end loop;
  
  -- Print the array elements
  for i IN 1..catnam.COUNT
  loop
    DBMS_OUTPUT.PUT_LINE('Category Name: ' || catnam(i) || ', Category ID: ' || catid(i));
  end loop;
end;
/


--procedure

create or replace procedure GetCategoryInfo(
  p_category_id IN Library.category_id%TYPE,
  p_category OUT Library.category%TYPE
)
is
begin
  SELECT category INTO p_category
  FROM Library
  WHERE category_id = p_category_id;
end;
/

declear
  v_category_name Library.category%TYPE;
begin
  GetCategoryInfo(1, v_category_name); -- Pass the desired category ID
  DBMS_OUTPUT.PUT_LINE('Category Name: ' || v_category_name);
end;
/



//function

create or replace function GetCategoryName(
  p_category_id IN Library.category_id%TYPE
) RETURN Library.category%TYPE
is
  v_category Library.category%TYPE;
begin
  SELECT category INTO v_category
  FROM Library
  WHERE category_id = p_category_id;
  
  RETURN v_category;
end;
/
declear
  v_category_name Library.category%TYPE;
begin
  v_category_name := GetCategoryName(1); -- Pass the desired category ID
  DBMS_OUTPUT.PUT_LINE('Category Name: ' || v_category_name);
end;
/











