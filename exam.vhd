LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_unsigned.all;
ENTITY exam is
PORT( );
end exam;

architecture fonctionel of exam is
signal A, B, C, D : std_ulogic;
signal Z :std_ulogic;
begin 
process ( A B C D)
begin
Z<= A and B;
Z<= C and D;
END fonctionel;
