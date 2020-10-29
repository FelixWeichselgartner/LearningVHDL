
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; -- to use std_logic / std_logic_vector
USE ieee.numeric_std.ALL; -- to use arithmetic functions
USE ieee.std_logic_unsigned.ALL; -- add std_logic_vectors

ENTITY adder IS
    -- all ports of type std_logic / std_logic_vector
    PORT (
        a : IN std_logic_vector(7 DOWNTO 0);
        b : IN std_logic_vector(7 DOWNTO 0);
        m : IN std_logic;       -- mode 1: add; mode 0: subtract
        Q : OUT std_logic_vector(7 DOWNTO 0);
        c : OUT std_logic;      -- carry of result
        s : OUT std_logic;      -- if 1 result is negative
        zero : OUT std_logic);  -- if 1 result is zero
END adder;

ARCHITECTURE arch OF adder IS
BEGIN

    -- combinatorical logic
    PROCESS (a, b, m)
        variable number1, number2 : signed(7 DOWNTO 0);
        variable result : signed(8 DOWNTO 0) := "000000000";
    BEGIN
        -- default values
        Q <= x"00";
        c <= '0';
        s <= '0';
        zero <= '0';
        
        number1 := signed(a);
        number2 := signed(b);
        
        -- subtraction
        if (m = '0') then
            number2 := -number2;
        end if;
        
        -- addition
        result := (number1(7) & number1) + (number2(7) & number2);
        c <= result(8);
        if (result < 0) then
            s <= '1';
        end if;
        
        if result(7 DOWNTO 0) = x"00" then
            zero <= '1';
        end if;
        
        Q <= std_logic_vector(result(7 DOWNTO 0));
    END PROCESS;

END arch;