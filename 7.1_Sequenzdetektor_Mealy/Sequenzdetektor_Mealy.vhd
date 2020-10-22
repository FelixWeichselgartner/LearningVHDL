LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
------------------------------------
ENTITY Sequenzdetektor IS
    PORT (
        clock, a_rst : IN std_logic;
        x : IN std_logic;
        y_q : OUT std_logic);
END Sequenzdetektor;
------------------------------------
ARCHITECTURE Mealy OF Sequenzdetektor IS
    TYPE states IS (z0, z1, z2);
    SIGNAL z_q, z_next : states;
    SIGNAL xh_q, x_q, y : std_logic;
BEGIN

    -- sequential logic
    PROCESS (clock, a_rst)
    BEGIN
        IF a_rst = '1' THEN -- asynchroner Reset
            z_q <= z0; -- alle FFs rücksetzen
            y_q <= '0';
            x_q <= '1';
            xh_q <= '1';
        ELSIF rising_edge(clock) THEN -- steigende Taktflanke
            xh_q <= x; -- asynchrones Eingangssignal
            x_q <= xh_q; -- zweimal abtakten
            y_q <= y;
            z_q <= z_next;

        END IF;
    END PROCESS;

    -- combinatorical logic
    PROCESS (x_q, z_q)
    BEGIN
        y <= '0'; -- y_q auf Defaultwert setzen
        CASE z_q IS
            WHEN z0 => IF x_q = '0' THEN -- wechsle auf z1
                z_next <= z1;
        END IF;
        WHEN z1 => IF x_q = '1' THEN -- wechsle auf z2 
        z_next <= z2;
    END IF;
    WHEN z2 => IF x_q = '0' THEN -- wechsle auf z1 
    z_next <= z1;
    y <= '1'; -- Folge erkannt!!
ELSE -- wechsle auf z0
    z_next <= z0;
END IF;
WHEN OTHERS => z_next <= z0; -- wechsle auf z0
END CASE;
END PROCESS;