------------------------------------------------------------
-- Author : http://www.teahlab.com/
--
-- Circuit: Gated RS Latch, Nand Based
--
-- Note   : This VHDL program is a structural description
--        of the interactive Gated RS NAND Latch on 
--        teahlab.com. The program shows every gate in 
--        the circuit and the interconnections between 
--        the gates.
--
--        It is very important to learn structural design
--        (RTL) strategies because as your assignments  
--        become larger and larger, knowledge of register 
--        transfer level  (RTL) design strategies 
--        become indispensable.
------------------------------------------------------------

-- Because the Gated RS NAND Latch comprises four 
-- NAND Gates, we first define a nandGate entity.
library ieee;
use ieee.std_logic_1164.all;

entity nandGate is
   port(A, B : in std_logic;
           F : out std_logic);
end nandGate;
------------
architecture nandFunc of nandGate is
begin
   F <= A nand B;
end nandFunc;
--*===============================================

library ieee;
use ieee.std_logic_1164.all;

entity gatedrsnandlatch is
   port(clk, S, R : in std_logic;
          Q, notQ : out std_logic);
end gatedrsnandlatch;
--------------
architecture funk of gatedrsnandlatch is
   component	nandGate is
      port( A, B : in std_logic;
               F : out std_logic);
   end component;
   ----
   signal top1, bot1, Qback, notQback : std_logic;
begin
   G1: nandGate port map(S, clk, top1);
   G2: nandGate port map(clk, R, bot1);
   G3: nandGate port map(top1, notQback, Qback);
   G4: nandGate port map(Qback, bot1, notQback);
   Q <= Qback;
   notQ <= notQback;
end funk;
---------------------------------------------------------END
---------------------------------------------------------END
