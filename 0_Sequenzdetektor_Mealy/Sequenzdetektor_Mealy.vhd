library ieee;
use ieee.std_logic_1164.all;
------------------------------------
entity Sequenzdetektor is
  port (clock        : in std_logic;
        x            : in std_logic;
        y_q          : out std_logic );
end Sequenzdetektor;
------------------------------------
architecture Mealy of Sequenzdetektor is
type states is (z0, z1, z2);
signal z_q       : states;
signal xh_q, x_q : std_logic;
begin
  process(clock)
  begin
    if rising_edge(clock) then   -- steigende Taktflanke

      xh_q <= x;                    -- asynchrones Eingangssignal
      x_q  <= xh_q;                 -- zweimal abtakten
      y_q  <= '0';                  -- y_q auf Defaultwert setzen

      case z_q is
        when z0 => if x_q = '0' then     -- wechsle auf z1
                     z_q <= z1;
                   end if;
        when z1 => if x_q = '1' then     -- wechsle auf z2 
                     z_q <= z2;
                   end if;
        when z2 => if x_q = '0' then     -- wechsle auf z1 
                     z_q <= z1;
                     y_q <= '1';         -- Folge erkannt!!
                   else                  -- wechsle auf z0
                     z_q <= z0;
                   end if;
        when others => z_q <= z0;        -- wechsle auf z0
      end case;

    end if;
  end process;
end Mealy;

 
