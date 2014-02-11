
------------------------------------------------------------
-- Author : http://www.teahlab.com/
--
-- Program: Gated RS NAND Latch Testbench
--
-- Note   : A testbench is a program that defines a set
--        of input signals to verify the operation of
--        a circuit: in this case, the Gated RS NAND Latch.
--
--        1] The testbench takes no inputs and returns
--        no outputs. As such the ENTITY declaration
--        is empty.
--
--        2] The circuit under verification, here the
--        Gated RS NAND Latch, is imported into the 
--        testbench ARCHITECTURE as a component.
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity gatedrsnandlatch_tb is
end gatedrsnandlatch_tb;
----------------------
architecture tb of gatedrsnandlatch_tb is
   component gatedrsnandlatch is
      port(clk, S, R : in std_logic;
             Q, notQ : out std_logic);
   end component;
   -------------
   signal clk, S, R, Q, notQ : std_logic;
   -------------
begin
 mapping: gatedrsnandlatch port map(clk, S, R, Q, notQ);

 process
   variable errCnt : integer := 0;
 begin
 -------------TEST 1
   clk <= '1';
   S <= '1';
   R <= '0';
   wait for 10 ns;
   assert(Q = '1') report "Error 1"	severity error;
   if(Q /= '1') then
      errCnt := errCnt + 1;
   end if;
   ----------TEST 2
   clk <= '1';
   S <= '0';
   R <= '1';
   wait for 10 ns;
   assert(Q = '0') report "Error 1" severity error;
   if(Q /= '0') then
      errCnt := errCnt + 1;
   end if;
   -----------------SUMMARY
   if(errCnt = 0) then
      assert false report "Good"	severity note;
   else
      assert true report "Bad" severity error;
   end if;
 end process;
end tb;
--------------------------------------------
configuration cfg_tb of gatedrsnandlatch_tb is
   for tb
   end for;
end cfg_tb;
---------------------------------------------------------END
---------------------------------------------------------END
