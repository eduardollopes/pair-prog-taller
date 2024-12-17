-- We are given a table consisting of two columns, Name, and Profession. 
-- We need to query all the names immediately followed by the first letter in the profession column enclosed in parenthesis.
-- Name Profession
-- Eduardo Data Engineer
-- Eduardo (D)

with cte_prof as (
SELECT 
  name,
  substring(profession, 1) as first_letter_profession
FROM profession 
)
select 
  name
  concat("(",first_letter_profession,")") as profession_abbreviation
from cte_prof